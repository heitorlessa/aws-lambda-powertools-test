<!-- changelog is partially generated, so it doesn't follow headings and required structure, so we disable it. -->
<!-- markdownlint-disable -->

<a name="unreleased"></a>
# Unreleased

## Maintenance

* document it


<a name="v2.14.2a2"></a>
## [v2.14.2a2] - 2023-05-19
## Maintenance

* version bump
* fic release_version var dependency
* **ci:** bump version to 2.14.2a1 ([#119](https://github.com/awslabs/aws-lambda-powertools-python/issues/119))


<a name="v"></a>
## [v] - 2023-05-19
## Maintenance

* version bump
* create wrapper on download/upload to fix git issues take 5
* create wrapper on download/upload to fix git issues take 4
* create wrapper on download/upload to fix git issues take 3
* create wrapper on download/upload to fix git issues tak2
* create wrapper on download/upload to fix git issues
* use checkout on quality_check
* replace cache with upload-artifact
* create integrity check job
* fix git config overriden take 17
* fix git config overriden take 16a
* fix git config overriden take 16
* fix git config overriden take 15
* fix git config overriden take 14
* fix git config overriden take 13
* fix git config overriden take 12
* fix git config overriden take 11
* fix git config overriden take 10
* fix git config overriden take 9
* fix git config overriden take 8
* fix git config overriden take 7
* fix git config overriden take 6
* fix git config overriden take 5
* fix git config overriden take 4
* fix git config overriden take 3
* fix git config overriden take 2
* fix git config overriden take 1
* improve integrity check
* pin poetry install
* **deps-dev:** bump types-requests from 2.28.11.17 to 2.30.0.0 ([#12](https://github.com/awslabs/aws-lambda-powertools-python/issues/12))
* **deps-dev:** bump mypy-boto3-secretsmanager ([#109](https://github.com/awslabs/aws-lambda-powertools-python/issues/109))


<a name="v2.14.1a5"></a>
## [v2.14.1a5] - 2023-05-19
## Maintenance

* **deps-dev:** bump mkdocs-material from 9.1.9 to 9.1.13 ([#82](https://github.com/awslabs/aws-lambda-powertools-python/issues/82))


<a name="v2.14.1a4"></a>
## [v2.14.1a4] - 2023-05-19
## Bug Fixes

* **ci:** install poetry when bumping versions

## Maintenance

* use release commit only


<a name="v2.14.1a3"></a>
## [v2.14.1a3] - 2023-05-19
## Bug Fixes

* set base_branch, dont't rely upstream workflow
* **ci:** start_span typo
* **ci:** unbound variable in error take 3
* **ci:** unbound variable in error take 2
* **ci:** unbound variable in error
* **ci:** github output var
* **ci:** start_span typo take 2

## Maintenance

* sync release changes with prod
* sync create-pr changes with prod
* fix job output
* test job output
* test composite action with git setupo
* test composite action take 14
* test composite action take 12
* test composite action take 11
* test composite action take 10
* test composite action take 9
* test composite action take 8
* test composite action take 7
* test composite action take 6
* test composite action take 5
* test composite action take 4
* test composite action take 3
* test composite action take 2
* test composite action
* replace debug for normal echo to ease ops
* remove debugging
* introduce spans to ease debugging when debug logs are off
* test cleanup with native env vars
* cosmetic changes
* reduce boilereprlate
* improve no duplicate message
* revert mike to push alias
* early exit on create PR failure; cleanup
* get a sample webhook payload for testing
* test docs pr mechanism take 3
* test docs pr mechanism take2
* fix unset var
* test docs pr mechanism
* try building docs from temp branch
* accept branch or commit id to build docs from
* **ci:** test cleanup update take 3
* **ci:** skip analytics job on forks
* **ci:** debug job circuit breaker condition take 7
* **ci:** debug job circuit breaker condition take 6
* **ci:** debug job circuit breaker condition take 5
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
* **ci:** test release drafter ([#4](https://github.com/awslabs/aws-lambda-powertools-python/issues/4))
* **ci:** test cleanup update take2
* **ci:** test cleanup update
* **ci:** use TEMP_BRANCH_PREFIX to remove more boilerplate
* **ci:** last cleanup
* **ci:** use default env vars to reduce boilerplate
* **ci:** move to manual dispatch to test cross-branch docs
* **ci:** disable termination exit on false status take 2
* **ci:** disable termination exit on false status
* **ci:** enable pipefail and early exits
* **ci:** docs rebuild ([#60](https://github.com/awslabs/aws-lambda-powertools-python/issues/60))
* **ci:** improve reporting
* **ci:** try notice msgs
* **ci:** final lint pass
* **ci:** fix arg passing take 3
* **ci:** fix arg passing take 2
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
* **ci:** create a temp branch with action workflow run id take 3
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


[Unreleased]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v2.14.2a2...HEAD
[v2.14.2a2]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v...v2.14.2a2
[v]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v2.14.1a5...v
[v2.14.1a5]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v2.14.1a4...v2.14.1a5
[v2.14.1a4]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v2.14.1a3...v2.14.1a4
[v2.14.1a3]: https://github.com/awslabs/aws-lambda-powertools-python/compare/v0.1.0...v2.14.1a3
