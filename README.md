<!-- BEGIN_TF_DOCS -->
# Terraform Azuread Workload Identity Module
Terraform module to create an Azure AD Workload Identity

[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Example
```hcl
locals {
  oidc_issuer_url = "azurerm_kubernetes_cluster.default.identity.0.issuer"
  resource_group  = "example-group"
  subscription_id = "00000000-0000-0000-0000-000000000000"
}

module "azuread_workload_identity" {
  source = "../"

  name                 = "cert-manager"
  namespace            = "cert-manager"
  service_account_name = "cert-manager"
  oidc_issuer_url      = local.oidc_issuer_url
  role_assignments = [
    {
      name                 = "dns",
      scope                = "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group}",
      role_definition_name = "DNS Zone Contributor"
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3 |

## Resources

| Name | Type |
|------|------|
| [azuread_application.default](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.default](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_service_principal.default](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_application_fic_prefix"></a> [ad\_application\_fic\_prefix](#input\_ad\_application\_fic\_prefix) | The prefix for the Azure AD application federated identity credential name | `string` | `"fed-identity"` | no |
| <a name="input_ad_application_prefix"></a> [ad\_application\_prefix](#input\_ad\_application\_prefix) | The prefix for the Azure AD application name | `string` | `"sp"` | no |
| <a name="input_audiences"></a> [audiences](#input\_audiences) | The audiences for the federated identity credential | `list(string)` | <pre>[<br/>  "api://AzureADTokenExchange"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the workload identity | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of the workload identity | `string` | n/a | yes |
| <a name="input_oidc_issuer_url"></a> [oidc\_issuer\_url](#input\_oidc\_issuer\_url) | The OIDC issuer URL | `string` | n/a | yes |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | Role assignments | <pre>list(object({<br/>    name                 = string,<br/>    scope                = string,<br/>    role_definition_id   = optional(string),<br/>    role_definition_name = optional(string),<br/>    principal_type       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_client_id"></a> [app\_client\_id](#output\_app\_client\_id) | The client ID of the Azure AD application |
| <a name="output_service_principal"></a> [service\_principal](#output\_service\_principal) | The service principal of the Azure AD application |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2025 [Blackbird Cloud](https://blackbird.cloud)
<!-- END_TF_DOCS -->