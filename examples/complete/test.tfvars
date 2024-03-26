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

project_id = "<PROJECT_ID>"

repository = {
  repo_type             = "GitHub"
  repo_id               = "nexient-llc/demo-azure-resource-group"
  github_enterprise_url = "https://github.company.com"
  branch_name           = "main"
  yml_path              = "internals/pipelines/pipeline.yml"
  service_connection_id = "<SERVICE_CONNECTION_ID>"
}

schedules = {
  branch_filter = {
    include = ["main"]
  }
  days_to_build = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
}
