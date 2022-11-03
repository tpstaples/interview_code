commandresult=()
while IFS= read -r line; do
  commandresult+=( "$line" )
done < <(kubectl get ns --no-headers| awk '{print $1}')

for ((i = 0; i < ${#commandresult[@]}; i++ )); do
  kubectl get deploy -o yaml -n ${commandresult[$i]}
done
