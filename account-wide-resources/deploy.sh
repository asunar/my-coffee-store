#!/bin/sh

if [[ $# -ne 1 ]]; then
    echo "Invalid number of arguments"
    echo
    echo "usage:"
    echo "$ ./deploy.sh GITHUB_TOKEN"
    echo
    exit 2
fi

set -euo pipefail

sam deploy \
    --stack-name account-wide-resources \
    --parameter-overrides GithubPersonalAccessToken=$1 \
    --template-file template.yaml \
    --capabilities CAPABILITY_IAM \
    --no-fail-on-empty-changeset

CLOUDFORMATION_ARTIFACTS_BUCKET=$(aws cloudformation list-exports --query "Exports[?Name=='CloudformationArtifactsBucket'].Value" --output text)

echo
echo Stack deployed as account-wide-resources
echo CloudFormation artifacts bucket deployed as $CLOUDFORMATION_ARTIFACTS_BUCKET
echo