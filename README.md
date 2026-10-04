# Azure + Terraform Setup

1. Login to Azure Portal as Admin.
2. Entra ID → Users → New user → Create user `test`.
3. Entra ID → Groups → New group → Create group `test_group`.
4. `test_group` → Members → Add user `test`.
5. Resource Groups → Create `test_resource_group` → Region: `South India`.
6. RBAC (Role based Access control :Add user/group to a Role) `test_resource_group` → Access control (IAM) → Add role assignment → `SQL Server Contributor` → Assign to `test_group` → Scope: `test_resource_group`.
7. test_resource_group → Access control (IAM) → Add role assignment → `SQL Security Manager` → Assign to `test_group` → Scope: `test_resource_group`.
8. Install Azure CLI on Ubuntu.
9. Login to Azure CLI as `test` using `az login`.
10. Verify subscription and Resource Group using Azure CLI.
11. Install Terraform using the official HashiCorp repository.
12. Create Terraform project: `~/Programming/azure-terraform/sql`.


# Terraform / Azure Investigation Commands

```bash

az login
az account list
az group list 
az provider list --query "[?registrationState=='Registered'].namespace" 
az sql server list 
az sql db list \
  --resource-group test_resource_group \
  --server test-sql-server-20261003 



terraform init
terraform validate # Validate Terraform syntax/configuration before applying
terraform plan # See what changes / If code is changed
terraform apply # Apply the Terraform configuration
terraform destroy

# Follow the commands suggested by Terraform on error
terraform state list #Debug
terraform state show azurerm_mssql_server.sql
# Check the Azure resource directly to compare Terraform state with Azure
az sql server show --name test-sql-server-20261003 --resource-group test_resource_group -o table
```