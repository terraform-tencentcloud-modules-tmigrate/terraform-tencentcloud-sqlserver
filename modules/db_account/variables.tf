variable "create" {
  description = "Whether to create accounts."
  type        = bool
  default     = true
}

variable "instance_id" {
  description = "(Required, String) SQL Server instance ID that accounts belong to."
  type        = string
  default     = null
}

# ─── 高级权限账号 (is_admin=true)，自动拥有所有 DB 的 db_owner，不需要 db_attachment ───
variable "admin_accounts" {
  description = "Map of admin (high-privilege) accounts. Key = account name. These accounts automatically own all DBs (db_owner) — db_attachments are ignored for admin accounts."
  type = map(object({
    password = string # sensitive
    remark  = optional(string, "")
  }))
  default = {}
}

# ─── 普通账号 (is_admin=false)，需要 db_attachment 授权访问具体 DB ───
variable "normal_accounts" {
  description = "Map of normal accounts. Key = account name. Each account must declare db_attachments with privilege ReadOnly|ReadWrite to access DBs."
  type = map(object({
    password = string # sensitive
    remark   = optional(string, "")
    db_attachments = list(object({
      db_name   = string
      privilege = string # ReadOnly | ReadWrite
    }))
  }))
  default = {}
}

# NOTE: 特殊权限账号 (库级独占隔离) 不被 Terraform provider 支持。
# SDK 的 CreateAccount API 无相关参数，无法通过 TF 创建该类账号。
# 如需创建特殊账号，请使用腾讯云控制台或提交工单。
