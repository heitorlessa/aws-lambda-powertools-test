#!/bin/bash
set -uxo pipefail # prevent accessing unset env vars, prevent masking pipeline errors to the next command

#docs
#title              :create_pr_for_staged_changes.sh
#description        :This script will create a PR for staged changes, detect and close duplicate PRs.
#author		    :@heitorlessa
#date               :May 8th 2023
#version            :0.1
#usage		    :bash create_pr_for_staged_changes.sh {git_staged_files_or_directories_separated_by_space}
#notes              :Meant to use in GitHub Actions only. Temporary branch will be named $TEMP_BRANCH_PREFIX-$GITHUB_RUN_ID
#os_version         :Ubuntu 22.04.2 LTS
#required_env_vars  :PR_TITLE, TEMP_BRANCH_PREFIX, GH_TOKEN
#==============================================================================

# Sets GitHub Action with error message to ease troubleshooting
function error() {
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
    debug "Do we have required environment variables?"
    test -z "${TEMP_BRANCH_PREFIX}" && error "TEMP_BRANCH_PREFIX env must be set to create a PR"
    test -z "${PR_TITLE}" && error "PR_TITLE env must be set"
    test -z "${GH_TOKEN}" && error "GH_TOKEN env must be set for GitHub CLI"

    # Default GitHub Actions Env Vars: https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables
    debug "Are we running in GitHub Action environment?"
    test -z "${GITHUB_RUN_ID}" && error "GITHUB_RUN_ID env must be set to trace Workflow Run ID back to PR"
    test -z "${GITHUB_SERVER_URL}" && error "GITHUB_SERVER_URL env must be set to trace Workflow Run ID back to PR"
    test -z "${GITHUB_REPOSITORY}" && error "GITHUB_REPOSITORY env must be set to trace Workflow Run ID back to PR"

    set_environment_variables
}

function set_environment_variables() {
    export readonly WORKFLOW_URL="${GITHUB_SERVER_URL}"/"${GITHUB_REPOSITORY}"/actions/runs/"${GITHUB_RUN_ID}" # e.g., heitorlessa/aws-lambda-powertools-test/actions/runs/4913570678
    export readonly TEMP_BRANCH="${TEMP_BRANCH_PREFIX}"-"${GITHUB_RUN_ID}"                                     # e.g., ci-changelog-4894658712
    export readonly BASE_BRANCH="${BASE_BRANCH:-develop}"                                                      # e.g., main, defaults to develop if missing
    export readonly PR_BODY="This is an automated PR created from the following workflow"
    export readonly FILENAME=".github/scripts/$(basename "$0")"
    export readonly NO_DUPLICATES_MESSAGE="No duplicated PRs found"
}

function has_anything_changed() {
    debug "Is there an update to the source code?"
    HAS_ANY_SOURCE_CODE_CHANGED="$(git status --porcelain)"

    test -z "${HAS_ANY_SOURCE_CODE_CHANGED}" && echo "Nothing to update" && exit 0
}

function create_temporary_branch_with_changes() {
    debug "Creating branch ${TEMP_BRANCH}"
    git checkout -b "${TEMP_BRANCH}"

    debug "Committing staged files: $*"
    git add "$@"
    git commit -m "${PR_TITLE}"

    debug "Creating branch remotely"
    git push origin "${TEMP_BRANCH}"
}

function create_pr() {
    debug "Creating PR against ${TEMP_BRANCH} branch"
    NEW_PR_URL=$(gh pr create --title "${PR_TITLE}" --body "${PR_BODY}: ${WORKFLOW_URL}" --base "${BASE_BRANCH}" || error "Failed to create PR") # e.g, https://github.com/awslabs/aws-lambda-powertools/pull/13

    # greedy remove any string until the last URL path, including the last '/'. https://opensource.com/article/17/6/bash-parameter-expansion
    NEW_PR_ID="${NEW_PR_URL##*/}" # 13
    export NEW_PR_URL
    export NEW_PR_ID
}

function close_duplicate_prs() {
    debug "Do we have any duplicate PRs?"
    DUPLICATE_PRS=$(gh pr list --search "${PR_TITLE}" --json number --jq ".[] | select(.number != ${NEW_PR_ID}) | .number") # e.g, 13\n14

    if [ -z "${DUPLICATE_PRS}"]; then
        DUPLICATE_PRS="${NO_DUPLICATES_MESSAGE}"
    else
        debug "Closing duplicated PRs: "${DUPLICATE_PRS}""
        echo "${DUPLICATE_PRS}" | xargs -L1 gh pr close --delete-branch --comment "Superseded by #${NEW_PR_ID}"
    fi

    export readonly DUPLICATE_PRS
}

function report_summary() {
    debug "Creating job summary"
    echo "### Pull request created successfully :rocket: ${NEW_PR_URL} <br/><br/> Closed duplicated PRs: ${DUPLICATE_PRS}" >>"$GITHUB_STEP_SUMMARY"

    notice "PR_URL is ${NEW_PR_URL}"
    notice "PR_BRANCH is ${TEMP_BRANCH}"
    notice "PR_DUPLICATES are ${DUPLICATE_PRS}"
}

function main() {
    # Sanity check
    has_anything_changed
    has_required_config

    create_temporary_branch_with_changes "$@"
    create_pr
    close_duplicate_prs

    report_summary
}

main "$@"
