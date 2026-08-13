variable "sqlserver_instances" {
  type = map(object({
    name              = string
    availability_zone = string
    memory            = number
    storage           = number
    cpu               = number
    machine_type      = string
    engine_version    = string
    charge_type       = optional(string, "POSTPAID_BY_HOUR")
    vpc_id            = string
    subnet_id         = string

    collation = optional(string, "Chinese_PRC_CI_AS")
    time_zone = optional(string, null)

    maintenance_week_set   = optional(list(number), null)
    maintenance_start_time = optional(string, null)
    maintenance_time_span  = optional(number, null)

    disk_encrypt_flag = optional(number, 0)

    security_groups = optional(list(string), null)

    project_id   = optional(number, null)
    auto_renew   = optional(number, null)
    auto_voucher = optional(number, 0)
    voucher_ids   = optional(list(string), null)
    period        = optional(number, 1)

    tags = optional(map(string), null)
  }))
  description = "Map of SQL Server basic instances to create. Each entry supports all attributes of tencentcloud_sqlserver_basic_instance."
}
