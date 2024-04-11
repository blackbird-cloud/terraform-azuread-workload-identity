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
