# tf-azureado-module_primitive-pipelines

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 0.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.96.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuredevops_build_definition.build_definition](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/build_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) The project ID or project name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the build definition. | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | The folder path of the build definition. | `string` | `null` | no |
| <a name="input_agent_pool_name"></a> [agent\_pool\_name](#input\_agent\_pool\_name) | The agent pool that should execute the build. Defaults to Azure Pipelines. | `string` | `"Azure Pipelines"` | no |
| <a name="input_ci_trigger"></a> [ci\_trigger](#input\_ci\_trigger) | The repository block as documented below. | <pre>object({<br>    use_yaml = optional(bool)<br>    override = optional(object({<br>      batch = optional(bool)<br>      branch_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      path_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      max_concurrent_builds_per_branch = number<br>      polling_interval                 = number<br>      polling_job_id                   = string<br>    }))<br>  })</pre> | <pre>{<br>  "use_yaml": false<br>}</pre> | no |
| <a name="input_pull_request_trigger"></a> [pull\_request\_trigger](#input\_pull\_request\_trigger) | Pull Request Integration trigger. | <pre>object({<br>    use_yaml       = bool<br>    initial_branch = optional(string)<br>    forks = object({<br>      enabled       = bool<br>      share_secrets = bool<br>    })<br>    override = optional(object({<br>      auto_cancel = bool<br>      branch_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      path_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>    }))<br>  })</pre> | <pre>{<br>  "forks": {<br>    "enabled": false,<br>    "share_secrets": false<br>  },<br>  "use_yaml": false<br>}</pre> | no |
| <a name="input_variable_groups"></a> [variable\_groups](#input\_variable\_groups) | A list of variable group IDs (integers) to link to the build definition. Defaults to {}. | `list(number)` | `null` | no |
| <a name="input_features"></a> [features](#input\_features) | A list of variable group IDs (integers) to link to the build definition. Defaults to {}. | <pre>object({<br>    skip_first_run = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_queue_status"></a> [queue\_status](#input\_queue\_status) | The queue status of the build definition. Valid values: enabled or paused or disabled. Defaults to enabled. | `string` | `"enabled"` | no |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | The repository block as documented below. | <pre>object({<br>    days_to_build              = list(string)<br>    schedule_only_with_changes = optional(bool)<br>    start_hours                = optional(string)<br>    start_minutes              = optional(string)<br>    time_zone                  = optional(string)<br>    branch_filter = optional(object({<br>      include = optional(list(string))<br>      exclude = optional(list(string))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository block as documented below. | <pre>object({<br>    branch_name           = string<br>    repo_id               = string<br>    repo_type             = string<br>    service_connection_id = string<br>    yml_path              = optional(string)<br>    github_enterprise_url = optional(string)<br>    report_build_status   = optional(bool)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_revision"></a> [revision](#output\_revision) | n/a |
| <a name="output_schedule_id"></a> [schedule\_id](#output\_schedule\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
