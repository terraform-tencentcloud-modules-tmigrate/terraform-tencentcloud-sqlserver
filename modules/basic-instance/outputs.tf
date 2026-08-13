output "instance_ids" {
  value       = { for k, v in tencentcloud_sqlserver_basic_instance.this : k => v.id }
  description = "Map of instance keys to instance IDs."
}

output "instance_vips" {
  value       = { for k, v in tencentcloud_sqlserver_basic_instance.this : k => v.vip }
  description = "Map of instance keys to private IPs."
}

output "instance_vports" {
  value       = { for k, v in tencentcloud_sqlserver_basic_instance.this : k => v.vport }
  description = "Map of instance keys to private ports."
}

output "instance_dns_pod_domains" {
  value       = { for k, v in tencentcloud_sqlserver_basic_instance.this : k => v.dns_pod_domain }
  description = "Map of instance keys to internet domain names."
}

output "instance_statuses" {
  value       = { for k, v in tencentcloud_sqlserver_basic_instance.this : k => v.status }
  description = "Map of instance keys to instance statuses."
}

output "instances" {
  value       = tencentcloud_sqlserver_basic_instance.this
  description = "Raw instance resources for advanced references."
}
