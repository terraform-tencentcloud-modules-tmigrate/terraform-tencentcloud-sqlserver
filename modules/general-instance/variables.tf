variable "create" {
  description = "Whether to create the SQL Server instance."
  type        = bool
  default     = true
}

variable "name" {
  description = "(Required, String) Name of the SQL Server instance, max 60 bytes."
  type        = string
  default     = null
}

variable "zone" {
  description = "(Required, String) Availability zone, e.g. ap-guangzhou-1."
  type        = string
  default     = null
}

variable "memory" {
  description = "(Required, Int) Memory in GB."
  type        = number
  default     = null
}

variable "storage" {
  description = "(Required, Int) Disk size in GB, must be a multiple of 10."
  type        = number
  default     = null
}

variable "cpu" {
  description = "(Required, Int) CPU cores."
  type        = number
  default     = null
}

variable "machine_type" {
  description = "(Required, String) Host disk type. Valid: CLOUD_HSSD, CLOUD_TSSD, CLOUD_BSSD."
  type        = string
  default     = null
}

variable "instance_charge_type" {
  description = "(Optional, String) Payment mode. Valid: PREPAID, POSTPAID. Default: POSTPAID."
  type        = string
  default     = "POSTPAID"
}

variable "db_version" {
  description = "(Optional, String) SQL Server version. e.g. 2008R2, 2012SP3, 2016SP1, 2017, 2019. Default: 2008R2."
  type        = string
  default     = "2008R2"
}

variable "period" {
  description = "(Optional, Int) Purchase period in months (1-48). Only valid for PREPAID."
  type        = number
  default     = 1
}

variable "auto_renew_flag" {
  description = "(Optional, Int) Auto renewal flag, 0-normal, 1-auto. Only valid for PREPAID."
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "(Optional, String) VPC ID. Must be set together with subnet_id."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "(Optional, String) VPC subnet ID. Must be set together with vpc_id."
  type        = string
  default     = null
}

variable "project_id" {
  description = "(Optional, Int) Project ID. Default: 0."
  type        = number
  default     = 0
}

variable "security_group_list" {
  description = "(Optional, Set) Security group ID list, e.g. [\"sg-xxx\"]."
  type        = set(string)
  default     = []
}

variable "weekly" {
  description = "(Optional, Set) Maintenance weekdays, 1-7 (Mon-Sun)."
  type        = set(number)
  default     = []
}

variable "start_time" {
  description = "(Optional, String) Maintenance daily start time, format HH:mm."
  type        = string
  default     = null
}

variable "span" {
  description = "(Optional, Int) Maintenance duration in hours."
  type        = number
  default     = null
}

variable "resource_tags" {
  description = "(Optional, List) Tags bound to the instance."
  type = list(object({
    tag_key   = string
    tag_value = optional(string, "")
  }))
  default = []
}

variable "collation" {
  description = "(Optional, String) System character set collation. Default: Chinese_PRC_CI_AS."
  type        = string
  default     = "Chinese_PRC_CI_AS"
}

variable "time_zone" {
  description = "(Optional, String) System timezone. Default: China Standard Time."
  type        = string
  default     = "China Standard Time"
}

variable "multi_zones" {
  description = "(Optional, Bool) Deploy across availability zones. Default: false."
  type        = bool
  default     = false
}

variable "multi_nodes" {
  description = "(Optional, Bool) Multi-node architecture. When true, multi_zones must be true."
  type        = bool
  default     = false
}

variable "dr_zones" {
  description = "(Optional, Set) Standby node availability zones. Only valid when multi_nodes=true. Min 2, max 5."
  type        = set(string)
  default     = []
}

variable "disk_encrypt_flag" {
  description = "(Optional, Int) Disk encryption, 0-disabled, 1-enabled."
  type        = number
  default     = 0
}

# ─── Security groups (managed by config_instance_security_groups resource) ───
variable "security_group_id_set" {
  description = "(Optional, Set) Security group IDs to bind via config_instance_security_groups. Takes over from security_group_list (which is ignored)."
  type        = set(string)
  default     = []
}

# ─── Instance parameters ───
variable "instance_params" {
  description = "(Optional, List) Instance parameters to modify. Each item: { name = string, current_value = string }. Some params may require instance restart."
  type = list(object({
    name          = string
    current_value = string
  }))
  default = []
}

# ─── Wan IP (external access) ───
variable "enable_wan_ip" {
  description = "(Optional, Bool) Enable/disable Wan IP for external access. null = do not create the resource."
  type        = bool
  default     = null
}

variable "ro_group_id" {
  description = "(Optional, String) Read-only group ID, only needed when enabling Wan IP for RO group."
  type        = string
  default     = null
}

# ─── SSL ───
variable "ssl_type" {
  description = "(Optional, String) SSL operation. enable / disable / renew. null = do not create the resource."
  type        = string
  default     = null
}

# ─── TDE (Transparent Data Encryption) ───
variable "tde_certificate_attribution" {
  description = "(Optional, String) TDE certificate attribution. self / others. null = do not create the resource."
  type        = string
  default     = null
}

variable "tde_quote_uin" {
  description = "(Optional, String) Referenced main account ID, required when certificate_attribution is others."
  type        = string
  default     = null
}
