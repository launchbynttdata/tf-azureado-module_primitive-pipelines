// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "project_id" {
  description = "(Required) The project ID or project name."
  type        = string
}

variable "name" {
  description = "The name of the build definition."
  type        = string
}

variable "path" {
  description = "The folder path of the build definition."
  type        = string
  default     = null
}

variable "agent_pool_name" {
  description = "The agent pool that should execute the build. Defaults to Azure Pipelines."
  type        = string
  default     = "Azure Pipelines"
}

variable "ci_trigger" {
  description = "The repository block as documented below."
  type = object({
    use_yaml = optional(bool)
    override = optional(object({
      batch = optional(bool)
      branch_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
      path_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
      max_concurrent_builds_per_branch = number
      polling_interval                 = number
      polling_job_id                   = string
    }))
  })
  default = {
    use_yaml = false
  }
}

variable "pull_request_trigger" {
  description = "Pull Request Integration trigger."
  type = object({
    use_yaml       = bool
    initial_branch = optional(string)
    forks = object({
      enabled       = bool
      share_secrets = bool
    })
    override = optional(object({
      auto_cancel = bool
      branch_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
      path_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
    }))
  })
  default = {
    use_yaml = false
    forks = {
      enabled       = false
      share_secrets = false
    }
  }
}

variable "variable_groups" {
  description = "A list of variable group IDs (integers) to link to the build definition. Defaults to {}."
  type        = list(number)
  default     = null
}

variable "features" {
  description = "A list of variable group IDs (integers) to link to the build definition. Defaults to {}."
  type = object({
    skip_first_run = optional(bool)
  })
  default = {}
}

variable "queue_status" {
  description = "The queue status of the build definition. Valid values: enabled or paused or disabled. Defaults to enabled."
  type        = string
  default     = "enabled"
}

variable "schedules" {
  description = "The schedules block as documented below."
  type = object({
    days_to_build              = list(string)
    schedule_only_with_changes = optional(bool)
    start_hours                = optional(string)
    start_minutes              = optional(string)
    time_zone                  = optional(string)
    branch_filter = optional(object({
      include = optional(list(string))
      exclude = optional(list(string))
    }))
  })
  default = null
}

variable "repository" {
  description = "The repository block as documented below."
  type = object({
    branch_name           = string
    repo_id               = string
    repo_type             = string
    service_connection_id = optional(string)
    yml_path              = optional(string)
    github_enterprise_url = optional(string)
    report_build_status   = optional(bool)
  })
}
