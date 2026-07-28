output "instance_id" {
  description = "ID of the SQL Server instance."
  value       = var.create ? join("", tencentcloud_sqlserver_general_cloud_instance.this.*.id) : ""
}

output "name" {
  description = "Name of the SQL Server instance."
  value       = var.create ? join("", tencentcloud_sqlserver_general_cloud_instance.this.*.name) : ""
}

output "dns_pod_domain" {
  description = "Internet address domain name."
  value       = var.create ? join("", tencentcloud_sqlserver_general_cloud_instance.this.*.dns_pod_domain) : ""
}

output "tgw_wan_vport" {
  description = "External port number."
  value       = var.create ? join("", tencentcloud_sqlserver_general_cloud_instance.this.*.tgw_wan_vport) : ""
}

output "wan_dns_pod_domain" {
  description = "Wan IP internet domain (from wan_ip_config resource)."
  value       = var.create && var.enable_wan_ip != null ? join("", tencentcloud_sqlserver_wan_ip_config.this.*.dns_pod_domain) : ""
}

output "wan_tgw_wan_vport" {
  description = "Wan IP external port (from wan_ip_config resource)."
  value       = var.create && var.enable_wan_ip != null ? join("", tencentcloud_sqlserver_wan_ip_config.this.*.tgw_wan_vport) : 0
}
