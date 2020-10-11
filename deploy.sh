#! /bin/sh

#set -euo pipefail 

if [ "$#" -gt 0 ]; then
    STACK_NAME=$1
else
    STACK_NAME="coffee-store-${USER}" #Set USER beforehand if running in git bash
fi

CLOUDFORMATION_ARTIFACTS_BUCKET=$(aws cloudformation list-exports --query "Exports[?Name==\`CloudformationArtifactsBucket\`].Value" --output text) 

sam deploy \
    --stack-name $STACK_NAME \
    --s3-bucket $CLOUDFORMATION_ARTIFACTS_BUCKET \
    --template-file template.yaml \
    --capabilities CAPABILITY_IAM \
    --no-fail-on-empty-changeset
