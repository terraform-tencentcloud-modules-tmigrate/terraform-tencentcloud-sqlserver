output "db_ids" {
  description = "Map of db name -> resource id (instance_id|db_name)."
  value       = { for k, v in tencentcloud_sqlserver_db.this : k => v.id }
}

output "db_statuses" {
  description = "Map of db name -> status (creating/running/modifying/deleting)."
  value       = { for k, v in tencentcloud_sqlserver_db.this : k => v.status }
}
