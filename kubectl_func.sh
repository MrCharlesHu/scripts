# kl groot api-gateway / kl groot api-gateway 2
function kl() {
    local env=$1
    local svc=$2
    local pod
    [[ -z $3 ]] && pod=1 || pod=$3
    printf "\e[1;32mEnvrioment:\e[0m \e[1;46m【${env}】\e[0m \e[1;32mService:\e[0m \e[1;46m【${svc}】\e[0m\n"
    #echo "Envrionment=${env} / Service=${svc}"
    local pods="kubectl -n ${env} get pods | grep ${svc} | awk '{print \$1}'"
    eval $pods
    local cmd="${pods} | awk 'NR==${pod}{print;}' | xargs kubectl -n ${env} logs -f"
    printf "\e[1;32mCommand:\e[0m \e[1;46m${cmd}\e[0m\n"
    #echo "Command: ${cmd}"
    eval $cmd
}

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
