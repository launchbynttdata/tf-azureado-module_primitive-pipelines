package testimpl

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"os/exec"
	"strings"
	"testing"
)

func TestComposableAzPipeline(t *testing.T, ctx types.TestContext) {

	pipelineID := string(terraform.Output(t, ctx.TerratestTerraformOptions(), "id"))
	fmt.Printf("Pipeline ID from Terraform: %s\n", pipelineID)

	azurePipelineID := getAzureDevopsPipeline("id", pipelineID)
	fmt.Printf("Pipeline ID from Azure DevOps: %s\n", azurePipelineID)

	assert.Equal(t, azurePipelineID, pipelineID, "Pipeline ID is not matching")

}

func getAzureDevopsPipeline(field string, pipelineID string) string {
	organization := "https://dev.azure.com/launch-dso"
	project := "platform-accelerators"

	cmd := exec.Command("az", "pipelines", "show", "--id", pipelineID, "--org", organization, "--project", project, "--query", field, "-o", "tsv")
	output, err := cmd.Output()
	if err != nil {
		fmt.Printf("Error in getting pipeline details: %s: %s\n", field, err)
		return ""
	}
	return strings.TrimSpace(string(output))
}
