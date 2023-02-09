variable resource_group_name {
  type      = string
}

variable application {
  type = string
  validation {
    condition     = length(var.application) > 3
    error_message = "${var.application} must be a minimum of three (3) characters."
  }
}

variable environment {
  type = string
  validation {
    condition     = length(var.environment) == 3
    error_message = "${var.environment} must be three (3) characters."
  }
}

variable instance_number {
  type = string
  validation {
    condition     = can(regex("^[0-9]{3}$", var.instance_number))
    error_message = "${var.instance_number} must be three (3) numbers."
  }
  default   = "001"
}

variable location {
  type      = string
}

variable account_kind {
  type      = string
  default   = "BlobStorage"
  validation {
    condition     = can(regex("^(BlobStorage|BlockBlobStorage|FileStorage|Storage|StorageV2)$", var.account_kind))
    error_message = "The account kind must be one of BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable account_tier {
  type      = string
  default   = "Standard"
  validation {
    condition     = can(regex("^(Standard|Premium)$", var.account_tier))
    error_message = "The account tier must be one of Standard, Premium."
  }
}

variable replication_type {
  type      = string
  default   = "LRS"
  validation {
    condition     = can(regex("^(LRS|ZRS|GRS|GZRS|RAGRS)$", var.replication_type))
    error_message = "The replication type must be one of LRS, ZRS, GRS, GZRS, RAGRS."
  }
}

variable containers {
  type      = list(object({
    name                    = string
    role_assignments        = optional(list(object({
      role_definition_name    = string
      object_id               = string
    })), [])
  }))
  default   = []
}

variable role_assignments {
  type      = list(object({
    role_definition_name    = string
    object_id               = string
  }))
  default   = []
}