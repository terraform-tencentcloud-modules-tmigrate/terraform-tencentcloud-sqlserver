resource "tencentcloud_sqlserver_config_backup_strategy" "this" {
  instance_id = var.instance_id

  backup_type                 = var.backup_type
  backup_time                 = var.backup_time
  backup_day                  = var.backup_day
  backup_model                = var.backup_model
  backup_cycle                = var.backup_cycle
  backup_save_days            = var.backup_save_days
  regular_backup_enable       = var.regular_backup_enable
  regular_backup_save_days    = var.regular_backup_save_days
  regular_backup_strategy     = var.regular_backup_strategy
  regular_backup_counts       = var.regular_backup_counts
  regular_backup_start_time   = var.regular_backup_start_time
}
