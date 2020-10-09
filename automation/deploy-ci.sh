#!/bin/sh

set -euo pipefail

CLOUDFORMATION_ARTIFACTS_BUCKET=$(aws cloudformation list-exports --query "Exports[?Name==\`CloudFormationArtifactsBucket\`].Value" --output text)

if [ -z "$CLOUDFORMATION_ARTIFACTS_BUCKET" ]; then
        echo "Unable to locate Cloudformation Export 'CloudformationArtifactsBucket' - have you setup the account-wide-resources for this account and region?"
        exit 1
fi

STACK_NAME=coffee-store-ci

sam.cmd deploy \
        --stack-name STACK_NAME \
        --template-file ci.yaml \
        --capabilities CAPABILITY_IAM \
        --parameter-overrides CloudFormationArtifactsBucket=$CLOUDFORMATION_ARTIFACTS_BUCKET \
        --no-fail-on-empty-changeset

echo
echo Stack deployed as $STACK_NAME 
echo