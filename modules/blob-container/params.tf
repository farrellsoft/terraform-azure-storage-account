
variable container_name {
  type      = string
}

variable storage_account_name {
  type      = string
}

variable role_assignments {
  type      = list(object({
    role_definition_name    = string
    object_id               = string
  }))
  default   = []
}