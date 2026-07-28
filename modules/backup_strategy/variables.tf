variable "instance_id" {
  description = "(Required, String) SQL Server instance ID."
  type        = string
}

variable "backup_type" {
  description = "(Optional, String) Backup type. Valid: weekly, daily. Default: daily. weekly requires backup_cycle length 2-7; daily requires backup_day=1."
  type        = string
  default     = "daily"
}

variable "backup_time" {
  description = "(Optional, Int) Backup start hour, 0-23."
  type        = number
  default     = null
}

variable "backup_day" {
  description = "(Optional, Int) Backup interval in days when backup_type=daily. Currently only 1 is valid."
  type        = number
  default     = 1
}

variable "backup_model" {
  description = "(Optional, String) Backup mode. Valid: master_pkg, master_no_pkg, slave_pkg, slave_no_pkg."
  type        = string
  default     = null
}

variable "backup_cycle" {
  description = "(Optional, Set) Days of week for backup when backup_type=weekly. 1-7 (Mon-Sun)."
  type        = set(number)
  default     = []
}

variable "backup_save_days" {
  description = "(Optional, Int) Backup retention days, 3-1830. Default: 7."
  type        = number
  default     = 7
}

variable "regular_backup_enable" {
  description = "(Optional, String) Archive backup switch. enable / disable. Default: disable."
  type        = string
  default     = "disable"
}

variable "regular_backup_save_days" {
  description = "(Optional, Int) Archive backup retention days, 90-3650. Default: 365."
  type        = number
  default     = 365
}

variable "regular_backup_strategy" {
  description = "(Optional, String) Archive backup policy. years / quarters / months. Default: months."
  type        = string
  default     = "months"
}

variable "regular_backup_counts" {
  description = "(Optional, Int) Number of retained archive backups. Default: 1."
  type        = number
  default     = 1
}

variable "regular_backup_start_time" {
  description = "(Optional, String) Archive backup start date YYYY-MM-DD."
  type        = string
  default     = null
}
