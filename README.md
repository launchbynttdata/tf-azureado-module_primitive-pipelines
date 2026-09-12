# tf-azureado-module_primitive-pipelines

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This Terraform primitive module manages an [`azuredevops_build_definition`](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/build_definition) resource.

It wraps a YAML-backed Azure Pipelines build definition: project, name, repository (TfsGit or GitHub), CI and pull-request triggers, schedules, agent pool, queue status, and optional variable groups. For GitHub repositories it looks up the project and GitHub service connection; for Azure Repos (TfsGit) it looks up the Git repository.

The module does not create Azure DevOps projects, service connections, Git repositories, or variable groups. Those must already exist. An `examples/complete` configuration shows a GitHub-backed pipeline against this repository.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 0.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.117, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuredevops_build_definition.build_definition](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/build_definition) | resource |
| [azuredevops_git_repository.repo](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/git_repository) | data source |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azuredevops_serviceendpoint_github.github_connection](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_github) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool_name"></a> [agent\_pool\_name](#input\_agent\_pool\_name) | The agent pool that should execute the build. Defaults to Azure Pipelines. | `string` | `"Azure Pipelines"` | no |
| <a name="input_ci_trigger"></a> [ci\_trigger](#input\_ci\_trigger) | The repository block as documented below. | <pre>object({<br/>    use_yaml = optional(bool)<br/>    override = optional(object({<br/>      batch = optional(bool)<br/>      branch_filter = optional(object({<br/>        include = optional(list(string))<br/>        exclude = optional(list(string))<br/>      }))<br/>      path_filter = optional(object({<br/>        include = optional(list(string))<br/>        exclude = optional(list(string))<br/>      }))<br/>      max_concurrent_builds_per_branch = number<br/>      polling_interval                 = number<br/>      polling_job_id                   = string<br/>    }))<br/>  })</pre> | <pre>{<br/>  "use_yaml": false<br/>}</pre> | no |
| <a name="input_features"></a> [features](#input\_features) | A list of variable group IDs (integers) to link to the build definition. Defaults to {}. | <pre>object({<br/>    skip_first_run = optional(bool)<br/>  })</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the build definition. | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | The folder path of the build definition. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) The project ID or project name. | `string` | n/a | yes |
| <a name="input_pull_request_trigger"></a> [pull\_request\_trigger](#input\_pull\_request\_trigger) | Pull Request Integration trigger. | <pre>object({<br/>    use_yaml       = bool<br/>    initial_branch = optional(string)<br/>    forks = object({<br/>      enabled       = bool<br/>      share_secrets = bool<br/>    })<br/>    override = optional(object({<br/>      auto_cancel = bool<br/>      branch_filter = optional(object({<br/>        include = optional(list(string))<br/>        exclude = optional(list(string))<br/>      }))<br/>      path_filter = optional(object({<br/>        include = optional(list(string))<br/>        exclude = optional(list(string))<br/>      }))<br/>    }))<br/>  })</pre> | <pre>{<br/>  "forks": {<br/>    "enabled": false,<br/>    "share_secrets": false<br/>  },<br/>  "use_yaml": false<br/>}</pre> | no |
| <a name="input_queue_status"></a> [queue\_status](#input\_queue\_status) | The queue status of the build definition. Valid values: enabled or paused or disabled. Defaults to enabled. | `string` | `"enabled"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository block as documented below. | <pre>object({<br/>    branch_name           = string<br/>    repo_id               = string<br/>    repo_type             = string<br/>    service_connection_id = optional(string)<br/>    yml_path              = optional(string)<br/>    github_enterprise_url = optional(string)<br/>    report_build_status   = optional(bool)<br/>  })</pre> | n/a | yes |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | The schedules block as documented below. | <pre>object({<br/>    days_to_build              = list(string)<br/>    schedule_only_with_changes = optional(bool)<br/>    start_hours                = optional(string)<br/>    start_minutes              = optional(string)<br/>    time_zone                  = optional(string)<br/>    branch_filter = optional(object({<br/>      include = optional(list(string))<br/>      exclude = optional(list(string))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_variable_groups"></a> [variable\_groups](#input\_variable\_groups) | A list of variable group IDs (integers) to link to the build definition. Defaults to {}. | `list(number)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_revision"></a> [revision](#output\_revision) | n/a |
| <a name="output_schedule_id"></a> [schedule\_id](#output\_schedule\_id) | n/a |
<!-- END_TF_DOCS -->

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to Terraform and Golang, as well as some common linting tasks. These will be configured for you when you run `make configure`.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.

2. Ensure you are signed into the appropriate cloud provider (e.g. AWS or Azure) for the module under test in your current console session.

3. Run the Terraform and Golang linters with the following command:

```
make lint
```

4. Once you have satisfied the linters, the following command will build example infrastructure in your configured cloud, run the tests, and then tear down the infrastructure it created:

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, will all be performed in CI. Running these validations locally prior to opening a PR helps ensure a smooth review and merge process.

### Review & Merge Process

Once your change has been tested locally and your branch pushed up, open a new Pull Request for your branch to the default (main) branch of this repository.

The title of your Pull Request will determine the version bump for this change, and the title must be in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format in order to merge. A breaking change will trigger a major version bump, a feature will trigger a minor version bump, and all other types will trigger a patch version bump.

Ensure your CI workflows are passing; seek approval from teammates and address any feedback; seek any explicit approvals required by the CODEOWNERS file. You may merge the PR as soon as all requirements are met, and a new release and tag will be automatically created for you.

### Automatic Updates

The shared configuration and workflow files in this repository are largely managed through the [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton) repository. Outside of perhaps the `.gitignore` to account for specific files being generated by certain Terraform modules (e.g. Lambda functions), there should not be much cause to update these files on a per-repo basis, and making changes to them individually is discouraged.

If desired, you can check for and run these updates locally in a branch if you have the `copier` tool installed. Some example commands are included below:

```
# Check for updates, optionally checking prerelease versions
copier check-update [--prereleases]

# Run an update, using default answers if there are any. We use tasks, which requires --trust to be set.
copier update --defaults --trust [--prereleases]

# Recopy from the source, and --overwrite all templated files in the process
copier recopy --defaults --trust --overwrite [--prereleases]
```

Automatic updates will run through a scheduled workflow, and if the post-update tests are successful, the Pull Request created will automatically merge. Conflicts in the update or failures to test may leave a Pull Request outstanding, which needs to be addressed by a Launch Engineer.
