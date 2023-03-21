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

variable allow_public_blob_access {
  type          = bool
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

variable file_shares {
  type      = list(object({
    name                    = string
    role_assignments        = optional(list(object({
      role_definition_name    = string
      object_id               = string
    })), [])
  }))
  default   = []
}

variable queues {
  type      = list(object({
    name                    = string
    role_assignments        = optional(list(object({
      role_definition_name    = string
      object_id               = string
    })), [])
  }))
  default   = []
}

variable tables {
  type      = list(object({
    name                    = string
  }))
  default   = []
}

variable private_endpoints {
  type          = object({
    blobs                  = optional(list(object({
      subnet_id               = string
      private_dns_zone_id     = string
      resource_group_name     = string
      purpose                 = optional(string, "")
    })), [])
    files                  = optional(list(object({
      subnet_id               = string
      private_dns_zone_id     = string
      resource_group_name     = string
      purpose                 = optional(string, "")
    })), [])
    queues                 = optional(list(object({
      subnet_id               = string
      private_dns_zone_id     = string
      resource_group_name     = string
      purpose                 = optional(string, "")
    })), [])
    tables                 = optional(list(object({
      subnet_id               = string
      private_dns_zone_id     = string
      resource_group_name     = string
      purpose                 = optional(string, "")
    })), [])
  })
  description   = "The private connection information object."
  default       = {}
}

variable role_assignments {
  type      = list(object({
    role_definition_name    = string
    object_id               = string
  }))
  default   = []
}

variable networking_config {
  type        = object({
    default_action        = optional(string, "Allow")
    allow_public_access   = optional(bool, true)
    bypass                = optional(string, "AzureServices")
  })
  description = "The networking configuration for the storage account."
  default     = {}
}