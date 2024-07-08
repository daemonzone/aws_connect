#!/bin/bash

export AWS_REGION=eu-south-1

if [ $# -eq 0 ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

service_name="$1"

AWSCLI=$(which aws)

cluster=$(aws ecs list-clusters --output text | awk -F":" '{ print $6 }' | awk -F"/" '{ print $2 }')
if [ "$cluster" == "" ] ; then
	exit 1
fi

echo "Cluster: ${cluster}"

services=$(aws ecs list-services --cluster $cluster)
service_names=$(echo "$services" | jq -r '.serviceArns[] | sub("arn:aws:ecs:eu-south-1:312297881051:service/extendi-smd-dev/"; "")')

echo -e "[Services]\n${service_names}"

if ! echo "$service_names" | grep -qw "$service_name"; then
    echo "Service '$service_name' not valid"
    exit 1
fi

tasks=$(aws ecs list-tasks --cluster $cluster --service-name $service_name)
task_id=$(echo "$tasks" | jq -r '.taskArns[] | split("/") | .[-1]')

echo -e "[Tasks]\n${tasks}"

echo -e "\nConnecting to task ${task_id}..."

echo "$AWSCLI ecs execute-command --cluster $cluster --region $AWS_REGION --task $task_id --container $service_name --interactive --command \"/bin/sh\""
$AWSCLI ecs execute-command --cluster $cluster --region $AWS_REGION --task $task_id --container $service_name --interactive --command "/bin/sh"

