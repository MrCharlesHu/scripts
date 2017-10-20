function k8s_log() {
    local project_name
    case $1 in
        "engine" )
            project_name="saas-engine"
            ;;
        "admin" )
            project_name="saas-webadmin"
            ;;
        * )
        echo "Can't recognize the project name" ${1}
            ;;
    esac
    printf "\e[1;32mProject Name:\e[0m \e[1;46m【${project_name}】\e[0m\n"
    kubectl get pods | grep ${project_name} | awk '{print $1}' | xargs -t -I {} kubectl logs -f --limit-bytes=1000 {}
    #local pod_name=$(kubectl get pods | grep ${project_name} | awk '{print $1}')
    #printf "\e[1;32mPod Name:\e[0m \e[1;46m【${pod_name}】\e[0m\n"
    #kubectl logs -f --limit-bytes=1000 ${pod_name}
}
