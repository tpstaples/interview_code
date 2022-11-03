aws ec2 describe-network-interfaces --region us-east-1 --filters Name=status,Values=available --query 'NetworkInterfaces[*].{ENI:NetworkInterfaceId}' | jq -r .[].ENI | xargs -I {} aws ec2 delete-network-interface --network-interface-id {}