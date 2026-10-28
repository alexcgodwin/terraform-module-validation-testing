config {
  call_module_type = "local"
}
rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_unused_declarations" { enabled = true }
rule "terraform_naming_convention" { enabled = true }
rule "terraform_documented_variables" { enabled = false }
