# kl groot api-gateway / kl groot api-gateway 2
function kl() {
local env=$1
local svc=$2
local pod
[[ -z $3 ]] && pod=1 || pod=$3
echo "Envrionment=${env} / Service=${svc}"
local pods="kubectl -n ${env} get pods | grep ${svc} | awk '{print \$1}'"
eval $pods
local cmd="${pods} | awk 'NR==${pod}{print;}' | xargs kubectl -n ${env} logs -f"
echo "Command: ${cmd}"
eval $cmd
}
