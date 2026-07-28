resource "tencentcloud_sqlserver_general_cloud_instance" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  zone                = var.zone
  memory              = var.memory
  storage             = var.storage
  cpu                 = var.cpu
  machine_type        = var.machine_type
  instance_charge_type = var.instance_charge_type
  db_version          = var.db_version
  period              = var.period
  auto_renew_flag     = var.auto_renew_flag
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  project_id          = var.project_id
  security_group_list = var.security_group_list
  collation           = var.collation
  time_zone           = var.time_zone
  multi_zones         = var.multi_zones
  multi_nodes         = var.multi_nodes
  dr_zones            = var.dr_zones
  disk_encrypt_flag    = var.disk_encrypt_flag

  weekly     = var.weekly
  start_time = var.start_time
  span       = var.span

  dynamic "resource_tags" {
    for_each = var.resource_tags
    content {
      tag_key   = resource_tags.value.tag_key
      tag_value = resource_tags.value.tag_value
    }
  }

  lifecycle {
    # period is immutable (provider enforces); API applies its own default.
    # multi_zones cannot be changed after creation.
    # security_group_list is managed by tencentcloud_sqlserver_config_instance_security_groups below.
    ignore_changes = [period, multi_zones, security_group_list]
  }
}

# ─── Security groups (managed independently, takes over from instance.security_group_list) ───
resource "tencentcloud_sqlserver_config_instance_security_groups" "this" {
  count = var.create && length(var.security_group_id_set) > 0 ? 1 : 0

  instance_id           = join("", tencentcloud_sqlserver_general_cloud_instance.this.*.id)
  security_group_id_set = var.security_group_id_set

  depends_on = [tencentcloud_sqlserver_general_cloud_instance.this]
}

# ─── Instance parameters ───
resource "tencentcloud_sqlserver_config_instance_param" "this" {
  count = var.create && length(var.instance_params) > 0 ? 1 : 0

  instance_id = join("", tencentcloud_sqlserver_general_cloud_instance.this.*.id)

  dynamic "param_list" {
    for_each = var.instance_params
    content {
      name          = param_list.value.name
      current_value = param_list.value.current_value
    }
  }

  depends_on = [tencentcloud_sqlserver_general_cloud_instance.this]
}

# ─── SSL ───
# ssl_type: null = do not create; "enable" / "disable" / "renew" = corresponding operation
resource "tencentcloud_sqlserver_instance_ssl" "this" {
  count = var.create && var.ssl_type != null ? 1 : 0

  instance_id = join("", tencentcloud_sqlserver_general_cloud_instance.this.*.id)
  type        = var.ssl_type

  depends_on = [tencentcloud_sqlserver_general_cloud_instance.this]
}

# ─── TDE (Transparent Data Encryption) ───
# tde_certificate_attribution: null = do not create; "self" / "others"
resource "tencentcloud_sqlserver_instance_tde" "this" {
  count = var.create && var.tde_certificate_attribution != null ? 1 : 0

  instance_id            = join("", tencentcloud_sqlserver_general_cloud_instance.this.*.id)
  certificate_attribution = var.tde_certificate_attribution
  quote_uin              = var.tde_quote_uin

  # TDE depends on SSL (mutual exclusion: cannot run in parallel)
  depends_on = [tencentcloud_sqlserver_instance_ssl.this]
}

# ─── Wan IP (external access) ───
# null = do not create; true = enable; false = disable (resource must exist to disable)
resource "tencentcloud_sqlserver_wan_ip_config" "this" {
  count = var.create && var.enable_wan_ip != null ? 1 : 0

  instance_id   = join("", tencentcloud_sqlserver_general_cloud_instance.this.*.id)
  enable_wan_ip = var.enable_wan_ip
  ro_group_id   = var.ro_group_id

  # WanIP depends on TDE (mutual exclusion: cannot run in parallel)
  depends_on = [tencentcloud_sqlserver_instance_tde.this]
}
