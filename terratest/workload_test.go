package terratest

import (
    "path/filepath"
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
)

// Uses a disposable working directory and terraform_data only. No cloud provider.
func TestWorkloadModuleContract(t *testing.T) {
    root, err := filepath.Abs("../examples/dev")
    if err != nil { t.Fatal(err) }
    opts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        TerraformDir: root,
        NoColor: true,
    })
    // Verify the plan and outputs via a real local Terraform apply.
    // This test never makes cloud calls. CI runners provide disposable workspaces.
    defer terraform.Destroy(t, opts)
    terraform.InitAndApply(t, opts)
    if got := terraform.Output(t, opts, "team"); got != "platform-team" {
        t.Fatalf("team output changed: %s", got)
    }
    if got := terraform.Output(t, opts, "alert_level"); got != "warning" {
        t.Fatalf("dev alert level changed: %s", got)
    }
}
