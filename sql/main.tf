terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    http = { source = "hashicorp/http" }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = "409c82a5-bbbb-4516-93db-5cd3c7eba263"
  resource_provider_registrations = "none"
}

# public_network_access_enabled = true  need to VNet/private access
#----------------------------------------
resource "azurerm_mssql_server" "sql" {
  name                         = "test-sql-server-20261003" #globally unique
  resource_group_name          = "test_resource_group"
  location                     = "South India"
  version                      = "12.0"
  administrator_login          = var.sql_admin
  administrator_login_password = var.sql_password
  public_network_access_enabled = true
}

data "http" "my_ip" {
  url = "https://api.ipify.org"
}

resource "azurerm_mssql_firewall_rule" "local" {
  name             = "MyLocalIP"
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = trimspace(data.http.my_ip.response_body)
  end_ip_address   = trimspace(data.http.my_ip.response_body)
}

resource "azurerm_mssql_database" "db" {
  name      = "test_db"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic"
}