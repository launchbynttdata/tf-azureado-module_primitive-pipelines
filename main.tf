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

data "azuredevops_git_repository" "repo" {
  project_id = var.project_id
  name       = var.repository.repo_id
}

resource "azuredevops_build_definition" "build_definition" {
  project_id      = var.project_id
  name            = var.name
  path            = var.path
  agent_pool_name = var.agent_pool_name
  queue_status    = var.queue_status
  variable_groups = var.variable_groups

  ci_trigger {
    use_yaml = var.ci_trigger.use_yaml
    dynamic "override" {
      for_each = var.ci_trigger.override != null ? [var.ci_trigger.override] : []
      content {
        batch                            = var.ci_trigger.override.batch
        max_concurrent_builds_per_branch = var.ci_trigger.override.max_concurrent_builds_per_branch
        polling_interval                 = var.ci_trigger.override.polling_interval
        polling_job_id                   = var.ci_trigger.override.polling_job_id
        dynamic "branch_filter" {
          for_each = var.ci_trigger.override.branch_filter != null ? [var.ci_trigger.override.branch_filter] : []
          content {
            include = var.ci_trigger.override.branch_filter.include
            exclude = var.ci_trigger.override.branch_filter.exclude
          }
        }
        dynamic "path_filter" {
          for_each = var.ci_trigger.override.path_filter
          content {
            include = var.ci_trigger.override.path_filter.include
            exclude = var.ci_trigger.override.path_filter.exclude
          }
        }
      }
    }
  }

  dynamic "pull_request_trigger" {
    for_each = var.pull_request_trigger != null ? [var.pull_request_trigger] : []
    content {
      use_yaml       = var.pull_request_trigger.use_yaml
      initial_branch = var.pull_request_trigger.initial_branch
      forks {
        enabled       = var.pull_request_trigger.forks.enabled
        share_secrets = var.pull_request_trigger.forks.share_secrets
      }
      dynamic "override" {
        for_each = var.pull_request_trigger.override != null ? [var.pull_request_trigger.override] : []
        content {
          auto_cancel = var.pull_request_trigger.override.auto_cancel
          dynamic "branch_filter" {
            for_each = var.pull_request_trigger.override.branch_filter != null ? [var.pull_request_trigger.override.branch_filter] : []
            content {
              include = var.pull_request_trigger.override.branch_filter.include
              exclude = var.pull_request_trigger.override.branch_filter.exclude
            }
          }
          dynamic "path_filter" {
            for_each = var.pull_request_trigger.override.path_filter != null ? [var.pull_request_trigger.override.path_filter] : []
            content {
              include = var.pull_request_trigger.override.path_filter.include
              exclude = var.pull_request_trigger.override.path_filter.exclude
            }
          }
        }
      }
    }
  }

  dynamic "features" {
    for_each = var.features != null ? [var.features] : []
    content {
      skip_first_run = var.features.skip_first_run
    }
  }

  repository {
    branch_name           = var.repository.branch_name
    repo_id               = data.azuredevops_git_repository.repo.id
    repo_type             = var.repository.repo_type
    service_connection_id = var.repository.service_connection_id
    yml_path              = var.repository.yml_path
    github_enterprise_url = var.repository.github_enterprise_url
    report_build_status   = var.repository.report_build_status
  }

  dynamic "schedules" {
    for_each = var.schedules != null ? ["schedules"] : []

    content {
      dynamic "branch_filter" {
        for_each = var.schedules.branch_filter != null ? [var.schedules.branch_filter] : []
        content {
          include = var.schedules.branch_filter.include
          exclude = var.schedules.branch_filter.exclude
        }
      }
      days_to_build              = var.schedules.days_to_build
      schedule_only_with_changes = var.schedules.schedule_only_with_changes
      start_hours                = var.schedules.start_hours
      start_minutes              = var.schedules.start_minutes
      time_zone                  = var.schedules.time_zone
    }
  }
}
