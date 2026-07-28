variable "instance_id" {
  description = "(Required, String, ForceNew) SQL Server instance ID that DB belongs to."
  type        = string
}

variable "dbs" {
  description = "Map of databases to create. Key = DB name. name/charset are ForceNew (cannot be changed after creation); only remark can be updated."
  type = map(object({
    charset = optional(string, "Chinese_PRC_CI_AS")
    remark  = optional(string, "")
  }))
  default = {}
}
