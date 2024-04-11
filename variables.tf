variable "namespace" {
  description = "The namespace of the workload identity"
  type        = string
}

variable "name" {
  description = "The name of the workload identity"
  type        = string
}

variable "service_account_name" {
  description = "The name of the service account"
  type        = string
}

variable "oidc_issuer_url" {
  description = "The OIDC issuer URL"
  type        = string
}

variable "ad_application_prefix" {
  description = "The prefix for the Azure AD application name"
  default     = "sp"
  type        = string
}

variable "ad_application_fic_prefix" {
  description = "The prefix for the Azure AD application federated identity credential name"
  default     = "fed-identity"
  type        = string
}

variable "audiences" {
  description = "The audiences for the federated identity credential"
  type        = list(string)
  default     = ["api://AzureADTokenExchange"]
}

variable "role_assignments" {
  default = []
  type = list(object({
    name                 = string,
    scope                = string,
    role_definition_id   = optional(string),
    role_definition_name = optional(string),
    principal_type       = optional(string)
  }))
  description = "Role assignments"
}
