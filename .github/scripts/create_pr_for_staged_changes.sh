#!/bin/bash

readonly COMMIT_MSG="chore(ci): update changelog with latest changes"
readonly PR_TITLE="chore(ci): changelog rebuild"
readonly PR_BODY="This is an automated PR created from the following workflow"

# Sets GitHub Action with error message to ease troubleshooting
function validation_error() {
    readonly FILENAME=".github/scripts/$(basename $0)"
    echo "::error file=${FILENAME}::$0"
    exit 1
}

# Check whether there are any staged changes before continuing
HAS_CHANGE="$(git status --porcelain)"
test -z "${HAS_CHANGE}" && echo "Nothing to update" && exit 0

# Sanity check
test -z "${WORKFLOW_URL}" && validation_error "WORKFLOW_URL env must be set for traceability"
test -z "${TEMP_BRANCH}" && validation_error "TEMP_BRANCH env must be set in order to create a PR"
test -z "${RUN_ID}" && validation_error "RUN_ID env must be set to trace GitHub Action Workflow Run ID back to PR"
test -z "${GH_TOKEN}" && validation_error "GH_TOKEN env must be set for GitHub CLI"

echo "::debug::Creating branch ${TEMP_BRANCH}"
git checkout -b "${TEMP_BRANCH}"

echo "::debug::Committing staged files: $@"
git add $@
git commit -m "${COMMIT_MSG}"

echo "::debug::Creating branch remotely"
git push origin "${TEMP_BRANCH}"

echo "::debug::Preparing PR against ${BRANCH} branch"

PR_ID=$(gh pr create --title "${PR_TITLE}":"${RUN_ID}" --body "${PR_BODY}: ${WORKFLOW_URL}" --base "${BRANCH}")

echo "### Pull request ${PR_ID} created successfully! :rocket:" >>$GITHUB_STEP_SUMMARY
