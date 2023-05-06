#!/bin/bash

#title              :create_pr_for_staged_changes.sh
#description        :This script will create a PR for staged changes, detect and close duplicate PRs with the same title, and craft a GitHub Actions report at the end.
#author		        :@heitorlessa
#date               :May 8th 2023
#version            :0.1
#usage		        :bash create_pr_for_staged_changes.sh
#notes              :Install Vim and Emacs to use this script.
#os_version         :Ubuntu   22.04.2 LTS
#required_env_vars  :COMMIT_MSG, PR_TITLE, TEMP_BRANCH, GH_TOKEN, RUN_ID, WORKFLOW_URL
#==============================================================================

PR_BODY="This is an automated PR created from the following workflow"
readonly PR_BODY

# Sets GitHub Action with error message to ease troubleshooting
function validation_error() {
    FILENAME=".github/scripts/$(basename "$0")"
    echo "::error file=${FILENAME}::$1"
    exit 1
}

function debug() {
    echo "::debug::$1"
}

debug "Is there an update to changelog?"
HAS_CHANGE="$(git status --porcelain)"
test -z "${HAS_CHANGE}" && echo "Nothing to update" && exit 0

debug "Do we have required environment variables?"
test -z "${WORKFLOW_URL}" && validation_error "WORKFLOW_URL env must be set for traceability"
test -z "${TEMP_BRANCH}" && validation_error "TEMP_BRANCH env must be set to create a PR"
test -z "${RUN_ID}" && validation_error "RUN_ID env must be set to trace Workflow Run ID back to PR"
test -z "${GH_TOKEN}" && validation_error "GH_TOKEN env must be set for GitHub CLI"

debug "Creating branch ${TEMP_BRANCH}"
git checkout -b "${TEMP_BRANCH}"

debug "Committing staged files: \"$*\""
git add "$*"
git commit -m "${COMMIT_MSG}"

debug "Creating branch remotely"
git push origin "${TEMP_BRANCH}"

debug "Creating PR against ${BRANCH} branch"
NEW_PR_URL=$(gh pr create --title "${PR_TITLE}" --body "${PR_BODY}: ${WORKFLOW_URL}" --base "${BRANCH}") # https://github.com/awslabs/aws-lambda-powertools/pull/13
NEW_PR_ID="${NEW_PR_URL##*/}"                                                                            # 13

debug "Do we have any duplicate PRs?"
DUPLICATE_PRS=$(gh pr list --search "${PR_TITLE}" --json number --jq ".[] | select(.number != ${NEW_PR_ID}) | .number")

debug "Closing duplicated PRs if any"
echo "${DUPLICATE_PRS}" | xargs -L1 gh pr close --delete-branch --comment "Superseded by #${NEW_PR_ID}"

debug "Creating job summary"
echo "### Pull request created successfully! :rocket: #${NEW_PR_ID}. \n\n Closed duplicated PRs (if any): ${DUPLICATE_PRS}" >>"$GITHUB_STEP_SUMMARY"

debug "Creating job outputs"
echo "PR_URL=${NEW_PR_URL}" >>"$GITHUB_OUTPUT"
echo "PR_BRANCH=${TEMP_BRANCH}" >>"$GITHUB_OUTPUT"
echo "PR_DUPLICATES=${DUPLICATE_PRS}" >>"$GITHUB_OUTPUT"
