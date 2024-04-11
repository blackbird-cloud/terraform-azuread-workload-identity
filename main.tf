data "azuread_client_config" "current" {}

resource "azuread_application" "default" {
  display_name = "${var.ad_application_prefix}-${var.name}-${var.namespace}"
}

resource "azuread_service_principal" "default" {
  client_id = azuread_application.default.client_id
  owners    = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_federated_identity_credential" "default" {
  application_id = azuread_application.default.id

  display_name = "${var.ad_application_fic_prefix}-${var.name}-${var.namespace}"
  description  = "The federated identity used to federate K8s with Azure AD with the app service running in k8s ${var.namespace} for app ${var.name}"
  audiences    = var.audiences
  issuer       = var.oidc_issuer_url
  subject      = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
}

locals {
  roles = { for role in var.role_assignments : role.name => role }
}

resource "azurerm_role_assignment" "assignment" {
  for_each             = local.roles
  scope                = each.value.scope
  role_definition_id   = each.value.role_definition_id
  role_definition_name = each.value.role_definition_name
  principal_id         = azuread_service_principal.default.id
}
