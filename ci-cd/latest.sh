#!/bin/bash

# GCR env variables
# $GCLOUD_KEY_JSON
# $DOCKER_REPO_HOST
#
# ECR env variables
# $AWS_SECRET_ACCESS_KEY
cicd_docker_login () {
    if [ -z "$GCLOUD_KEY_JSON$AWS_SECRET_ACCESS_KEY" ]
    then
        echo "Cloud credentials \$GCLOUD_KEY_JSON or \$AWS_SECRET_ACCESS_KEY are empty, have you set a context for this CircleCI job correctly?"
    else
        # GCR login
        if [ ! -z "$GCLOUD_KEY_JSON" ]
        then
            printenv GCLOUD_KEY_JSON | docker login -u _json_key --password-stdin "https://$DOCKER_REPO_HOST"
        fi
        # ECR Login 
        if [ ! -z "$AWS_SECRET_ACCESS_KEY" ]
        then
            aws ecr get-login --no-include-email | bash
        fi
    fi
}

# Execute argument as function
"$@"