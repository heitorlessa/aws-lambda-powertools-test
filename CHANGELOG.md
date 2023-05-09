<!-- changelog is partially generated, so it doesn't follow headings and required structure, so we disable it. -->
<!-- markdownlint-disable -->

<a name="unreleased"></a>
# Unreleased

## Maintenance

* fix unset var
* test docs pr mechanism
* try building docs from temp branch
* accept branch or commit id to build docs from
* cosmetic changes
* get a sample webhook payload for testing
* **ci:** debug job circuit breaker condition take 5
* **ci:** debug job circuit breaker condition take 6
* **ci:** debug job circuit breaker condition take 7
* **ci:** debug job circuit breaker condition take 4
* **ci:** debug job circuit breaker condition take 3
* **ci:** debug job circuit breaker condition take 2
* **ci:** debug job circuit breaker condition
* **ci:** test job circuit breaker condition
* **ci:** test job circuit breaker
* **ci:** remove simulated failure
* **ci:** test cleanup update take 6
* **ci:** test cleanup update take 5
* **ci:** test cleanup update take 4
* **ci:** test cleanup update take 3
* **ci:** test cleanup update take2
* **ci:** test cleanup update
* **ci:** use TEMP_BRANCH_PREFIX to remove more boilerplate
* **ci:** last cleanup
* **ci:** use default env vars to reduce boilerplate
* **ci:** skip analytics job on forks
* **ci:** disable termination exit on false status take 2
* **ci:** disable termination exit on false status
* **ci:** enable pipefail and early exits
* **ci:** test release drafter ([#4](https://github.com/awslabs/aws-lambda-powertools-python/issues/4))
* **ci:** improve reporting
* **ci:** try notice msgs
* **ci:** final lint pass
* **ci:** fix arg passing take 3
* **ci:** create a temp branch with action workflow run id take 3
* **ci:** fix arg passing
* **ci:** remove arg expansion lint
* **ci:** lint with shellcheck part 2
* **ci:** lint with shellcheck
* **ci:** make script and workflow reusable
* **ci:** use bash word expansion over basename
* **ci:** debug bash string expansion
* **ci:** fix typos
* **ci:** trigger changelog on build again
* **ci:** close duplicate PRs
* **ci:** automate PR creation for changelog take 1
* **ci:** add gh_token env var for gh cli
* **ci:** create a temp branch with action workflow run id
* **ci:** remove intentional failure
* **ci:** intentionally fail to test err msg take 2
* **ci:** changelog rebuild:4895407959 ([#9](https://github.com/awslabs/aws-lambda-powertools-python/issues/9))
* **ci:** intentionally fail to test err msg
* **ci:** isolate git commands in a script for debuggability
* **ci:** test orphan branch cleanup
* **ci:** correct pr body message
* **ci:** changelog rebuild ([#7](https://github.com/awslabs/aws-lambda-powertools-python/issues/7))
* **ci:** create a temp branch with action workflow run id take 9
* **ci:** create a temp branch with action workflow run id take 8
* **ci:** create a temp branch with action workflow run id take 7
* **ci:** create a temp branch with action workflow run id take 6
* **ci:** create a temp branch with action workflow run id take 5
* **ci:** create a temp branch with action workflow run id take 4
* **ci:** fix arg passing take 2
* **ci:** create a temp branch with action workflow run id take 2
* **ci:** update todo for tomorrow
* **deps:** bump zgosalvez/github-actions-ensure-sha-pinned-actions ([#41](https://github.com/awslabs/aws-lambda-powertools-python/issues/41))
* **deps-dev:** bump mkdocs-material from 9.1.8 to 9.1.9 ([#1](https://github.com/awslabs/aws-lambda-powertools-python/issues/1))
* **deps-dev:** bump mypy-boto3-s3 from 1.26.116 to 1.26.127 ([#11](https://github.com/awslabs/aws-lambda-powertools-python/issues/11))
* **deps-dev:** bump mypy-boto3-cloudwatch from 1.26.99 to 1.26.127 ([#10](https://github.com/awslabs/aws-lambda-powertools-python/issues/10))


<a name="v0.1.0"></a>
## v0.1.0 - 2023-05-02
## Bug Fixes

* **ci:** add permission for release drafting
* **ci:** pin sigstore correctly
* **ci:** pin 3rd party gh action
* **ci:** id-token typo

## Documentation

* **jmespath:** fix MD037/no-space-in-emphasis

## Features

* **ci:** include signing artifacts in release

## Maintenance

* split build, sign, and release
* split jobs and permissions
* sync base repo
* cleanup release targeting test only
* project init


[Unreleased]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v0.1.0...HEAD
