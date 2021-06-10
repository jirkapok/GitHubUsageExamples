# GitHub Actions

* Actions are added to repository as .github/workflow directory
* actions are [yaml file format](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
* Official actions are available on [GitHub Market place](https://github.com/marketplace)
* Multiple workflow files are understood as independent CI/CD pipelines, they can't interact

## Features

* CI - based on events and repository manipulations like push/merge etc.
* Custom actions
* Self hosted runners
* Manipulate the repository
* Artifacts storage

## Jobs

* There needs to be at least one job
* Job elements are names of jobs
* One job is isolated piece of work, the can be sequence or in parallel
* To exchange data between Jobs, you need to use artifacts

## Runners

* runs-on: runner, there is an option to run on github hosted runner or local runner
  * Ubuntu, macOs or Windows images available
  * More runners are available for self-hosted
  * Steps - execute on the same runner
  * Checkout action is required and pulls latest commit into work directory on the runner
  * run step executes any shell commands

## Events (triggers)

* Available:
  * GitHub webhooks - commits, pull requests, issues etc.
    * Associated with any github api: <https://docs.github.com/en/developers/webhooks-and-events/github-event-types>
    * Limit to types:
  * Scheduled events: `schedule` using POSIX cron syntax
    * on latest commit on default branch
    * shortest interval is 5 minutes
  * External: repository_dispatch
* ON
  * push, pull_request - can have value of branch filter, tags, paths

```yaml
on:
  pull_request:
    types: [assigned, unassigned]
  issue_comment:
    types: [created, deleted]
```

## Parametrization

* See `parameters_env.yml`
* Context variables
  * There is large number of variables already defined by github
  * Context is defined as object accessible using dot notation
  * There is context for workflow, job, step
  * Some of them are also available as environment variables (e.g. GITHUB_RUN_NUMBER)
* Environment variables
  * Can be stored on workflow, job, or step level, lower level overrides above level value
  * Env. can be stored also in environment files
  * Can't be shared between jobs
  * Changing env. value doesn't affect global value
* Inputs and outputs
  * Can be shared across jobs
  * Inputs can be defined only for custom actions or from UI in workflow_dispatch or in custom actions
  * Inputs from UI can't be arrays, because they are plain text values
  * Outputs can be transferred from step to job and shared across job
* Secured values should be shared using Secrets

### Secrets

* are defined in repository options > Secrets
* Some actions require authorization as input
* secrets.GITHUB_TOKEN: automatically created when enabling github actions on the repository
  * no need to reference in workflow file

```yaml
steps:
  - name: Hello world
    with:
      super-secret: ${{secrets.MySecret}}
    env:
      super-secret: ${{secrets.MySecret}}
```

## Environments

* Following example results in 4 builds as matrix of os and node.js versions:

```yaml
strategy:
  matrix:
    node-versions: [10.x, 12.x]
    os: [ubuntu-latest, windows-2016]
```

## Custom actions

* See [Creating javascript action](https://docs.github.com/en/actions/creating-actions/creating-a-javascript-action)
* can be written for docker container or in plain javascript
* They should be placed in separate repository, so you can version them as standalone application
* Running action from the same repository is not directly supported

## Self hosted runner

* Pricing can be found in your github profile > Settings > [Billing](https://github.com/settings/billing)
* Default runners for both linux and windows available
* Self automatically updated and removed if not connected to github within 30 days.
* [Available runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
* [See also](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
* Add self hosted runner in repository Settings > Actions > Runners
* To enforce usage of concrete runner use labels
* Containers:
  * [Ubuntu](https://github.com/tcardonne/docker-github-runner)
  * [Windows](https://github.com/cosmoconsult/github-runner-windows)
  * See also `./runner`
  * start the runner as

```powershell
docker build -t github-runner-windows .  # from runners directory
# replace YourLogin/repository and YourToken values
docker run -e GITHUBREPO_OR_ORG=YourLogin/repository -e GITHUBPAT=YourToken github-runner-windows
```

## Approval workflow

* The workflow files are isolated and git runs matching the event happened

## Links

* [Github Documentation](https://help.github.com/en/actions/)
* [VS code extension](https://marketplace.visualstudio.com/items?itemName=cschleiden.vscode-github-actions)
* [Training app](https://github-actions-hero.now.sh)
* Pluralsight courses
  * [Getting Started with GitHub Actions](https://app.pluralsight.com/library/courses/github-actions-getting-started/table-of-contents)
  * [Supercharging your GitHub Workflow](https://app.pluralsight.com/library/courses/supercharging-git-workflow/table-of-contents)
  * [Building custom GitHub Actions](https://app.pluralsight.com/library/courses/building-custom-github-actions/table-of-contents)
