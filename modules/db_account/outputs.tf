output "admin_account_ids" {
  description = "Map of admin account name -> resource id (instance_id|name)."
  value       = { for k, v in tencentcloud_sqlserver_account.admin : k => v.id }
}

output "normal_account_ids" {
  description = "Map of normal account name -> resource id (instance_id|name)."
  value       = { for k, v in tencentcloud_sqlserver_account.normal : k => v.id }
}

output "normal_db_attachment_ids" {
  description = "Map of 'accountName|dbName' -> attachment resource id."
  value       = { for k, v in tencentcloud_sqlserver_account_db_attachment.normal : k => v.id }
}
