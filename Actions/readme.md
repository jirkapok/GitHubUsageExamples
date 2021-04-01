# GitHub Actions self study

* Actions are added to repository as .github/workflow directory
* actions are yaml file format
* [Github Documentation](https://help.github.com/en/actions/)
* [VS code extension](https://marketplace.visualstudio.com/items?itemName=cschleiden.vscode-github-actions)
* [Training app](https://github-actions-hero.now.sh)
* Pluralsight courses
  * [Getting Started with GitHub Actions](https://app.pluralsight.com/library/courses/github-actions-getting-started/table-of-contents)
  * [Supercharging your GitHub Workflow](https://app.pluralsight.com/library/courses/supercharging-git-workflow/table-of-contents)
  * [Building custom GitHub Actions](https://app.pluralsight.com/library/courses/building-custom-github-actions/table-of-contents)

## GitHub features

* GitHub pages
  * [Example deployment](https://www.codecademy.com/articles/f1-u3-github-pages)
  * [Automated deployment Action](https://github.com/marketplace/actions/deploy-to-github-pages)
* [Packages](https://docs.github.com/en/packages/guides/package-client-guides-for-github-packages)
* Actions
* Wiki
* License
* Contributors
* Issue templates
* Security

## Features

* CI
* Custom actions
* Self hosted runners
* Manipulate the repository
* Artifacts storage

## GitHub Actions

* ON
  * push, pull_request - can have value of branch filter, tags, paths
* There needs to be atleast one job
  * Job elements are names of jobs
  * runs-on: runner, there is an option to run on github hosted runner or local runner
    * Ubuntu, macOs or Windows images available
    * More runners are available for self-hosted
    * Steps - execute on the same runner
    * Checkout action is required and pulls latest commit into work directory on the runner
    * run step executes any shell commands

### Events

* Available:

  * GitHub webhooks - commits, pull requests, issues etc.
    * Associated with any github api: <https://docs.github.com/en/developers/webhooks-and-events/github-event-types>
    * Limit to types:
  * Scheduled events: `schedule` using POSIX cron syntax
    * on latest commit on default branch
    * shortest interval is 5 minutes
  * External: repository_dispatch

```yaml
on:
  pull_request:
    types: [assigned, unassigned]
  issue_comment:
    types: [created, deleted]
```

### Env. variables and secrets

* Secrets are defined in repository options > Secrets
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

### Environments

* Following example results in 4 builds as matrix of os and node.js versions:

```yaml
strategy:
  matrix:
    node-versions: [10.x, 12.x]
    os: [ubuntu-latest, windows-2016]
```

### Approval workflow

* The workflow files are isolated and git runs matching the event happend

### Questions

* How and where to find provided official actions? Github.com/marketplace
* What if you have multiple workflow files?
