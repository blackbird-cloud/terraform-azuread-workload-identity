output "app_client_id" {
  description = "The client ID of the Azure AD application"
  value       = azuread_application.default.client_id
}

output "service_principal" {
  description = "The service principal of the Azure AD application"
  value       = azuread_service_principal.default
}
