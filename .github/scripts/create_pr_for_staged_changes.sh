#!/bin/bash
set -uxo pipefail # quickest explanation https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425

#docs
#title              :create_pr_for_staged_changes.sh
#description        :This script will create a PR for staged changes, detect and close duplicate PRs with the same title, and craft a GitHub Actions report at the end.
#author		        :@heitorlessa
#date               :May 8th 2023
#version            :0.1
#usage		        :bash create_pr_for_staged_changes.sh {git_staged_files_or_directories_separated_by_space}
#notes              :Install Vim and Emacs to use this script.
#os_version         :Ubuntu 22.04.2 LTS
#required_env_vars  :COMMIT_MSG, PR_TITLE, TEMP_BRANCH, GH_TOKEN, GITHUB_RUN_ID, GITHUB_SERVER_URL, GITHUB_REPOSITORY
#==============================================================================

PR_BODY="This is an automated PR created from the following workflow"
FILENAME=".github/scripts/$(basename "$0")"
readonly PR_BODY
readonly FILENAME

# Sets GitHub Action with error message to ease troubleshooting
function raise_validation_error() {
    echo "::error file=${FILENAME}::$1"
    exit 1
}

function debug() {
    echo "::debug::$1"
}

function notice() {
    echo "::notice file=${FILENAME}::$1"
}

function has_required_config() {
    # Default GitHub Actions Env Vars: https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables
    debug "Do we have required environment variables?"
    test -z "${TEMP_BRANCH}" && raise_validation_error "TEMP_BRANCH env must be set to create a PR"
    test -z "${GH_TOKEN}" && raise_validation_error "GH_TOKEN env must be set for GitHub CLI"
    test -z "${GITHUB_RUN_ID}" && raise_validation_error "GITHUB_RUN_ID env must be set to trace Workflow Run ID back to PR"
    test -z "${GITHUB_SERVER_URL}" && raise_validation_error "GITHUB_SERVER_URL env must be set to trace Workflow Run ID back to PR"
    test -z "${GITHUB_REPOSITORY}" && raise_validation_error "GITHUB_REPOSITORY env must be set to trace Workflow Run ID back to PR"

    WORKFLOW_URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"
    export readonly WORKFLOW_URL
}

function has_anything_changed() {
    debug "Is there an update to changelog?"
    HAS_CHANGE="$(git status --porcelain)"
    test -z "${HAS_CHANGE}" && echo "Nothing to update" && exit 0
}

function push_staged_files_to_temp_branch() {
    debug "Creating branch ${TEMP_BRANCH}"
    git checkout -b "${TEMP_BRANCH}"

    debug "Committing staged files: $*"
    git add "$@"
    git commit -m "${COMMIT_MSG}"

    debug "Creating branch remotely"
    git push origin "${TEMP_BRANCH}"
}

function create_pr() {
    debug "Creating PR against ${BRANCH} branch"
    NEW_PR_URL=$(gh pr create --title "${PR_TITLE}" --body "${PR_BODY}: ${WORKFLOW_URL}" --base "${BRANCH}") # https://github.com/awslabs/aws-lambda-powertools/pull/13
    NEW_PR_ID="${NEW_PR_URL##*/}"                                                                            # 13
    export NEW_PR_URL
    export NEW_PR_ID
}

function close_duplicate_prs() {
    debug "Do we have any duplicate PRs?"
    DUPLICATE_PRS=$(gh pr list --search "${PR_TITLE}" --json number --jq ".[] | select(.number != ${NEW_PR_ID}) | .number")

    debug "Closing duplicated PRs if any"
    echo "${DUPLICATE_PRS}" | xargs -L1 gh pr close --delete-branch --comment "Superseded by #${NEW_PR_ID}"
    export DUPLICATE_PRS
}

function report_summary() {
    debug "Creating job summary"
    echo "### Pull request created successfully :rocket: #${NEW_PR_URL} <br/><br/> Closed duplicated PRs (if any): ${DUPLICATE_PRS}" >>"$GITHUB_STEP_SUMMARY"

    notice "PR_URL is ${NEW_PR_URL}"
    notice "PR_BRANCH is ${TEMP_BRANCH}"
    notice "PR_DUPLICATES are ${DUPLICATE_PRS}"
}

function main() {
    # Sanity check
    has_anything_changed
    has_required_config

    push_staged_files_to_temp_branch "$@"
    create_pr
    close_duplicate_prs

    report_summary
}

main "$@"
