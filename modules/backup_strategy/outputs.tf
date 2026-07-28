output "backup_strategy_id" {
  description = "ID of the backup strategy (equals instance_id)."
  value       = tencentcloud_sqlserver_config_backup_strategy.this.id
}
