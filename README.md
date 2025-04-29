# Azure Kubernetes Service (AKS) Terraform Modules

This repository contains Terraform modules for deploying a production-ready Azure Kubernetes Service (AKS) cluster with all necessary supporting infrastructure.

## Module Structure

The infrastructure is organized into the following modules:

- **Resource Group**: Creates the Azure resource group for all resources
- **Network**: Sets up the virtual network, subnets, and optionally an Application Gateway
- **AKS**: Deploys the Kubernetes cluster with configurable node pools
- **ACR**: Creates an Azure Container Registry for storing container images
- **Key Vault**: Provisions an Azure Key Vault and configures it for use with AKS
- **Monitoring**: Sets up Log Analytics workspace for cluster monitoring

## Prerequisites
- Terraform v1.0.0 or newer
- Azure CLI installed and authenticated
- Sufficient permissions to create resources in Azure

```bash
az login --scope https://management.core.windows.net//.default
```

## Authentication
- **Service Principal**: Create a service principal for Terraform to use. This can be done via the Azure CLI:

```bash
# Replace <SP_NAME> with your desired service principal name
# Replace <SUBSCRIPTION_ID> with your Azure subscription ID
# Replace <TENANT_ID> with your Azure tenant ID

# Create a service principal and assign it the Contributor role on the subscription
az ad sp create-for-rbac --name <SP_NAME> --role Contributor --scopes /subscriptions/<SUBSCRIPTION_ID>
```

This will output the `appId` (client ID), `password` (client secret), and `tenant`.

- **Environment Variables**: Set the following environment variables in your terminal:

```bash
export SUBSCRIPTION= "<SUBSCRIPTION_ID>"
export SERVICE_PRINCIPAL_SECRET= "<SERVICE_PRINCIPAL_SECRET>"
export CLIENT_ID= "<CLIENT_ID>"
export TENANT_ID= "<TENANT_ID>"
``
## Configuration
- **Terraform Variables**: You can customize the deployment by modifying the `variables.tf` file in each module. The variables include options for resource names, locations, and other configurations.
- **Terraform Backend**: If you want to use a remote backend for storing the Terraform state, configure the `backend` block in your `main.tf` file. This is useful for team collaboration and state management.
- **Terraform Provider**: Ensure that the `provider` block in your `main.tf` file is set to use the Azure provider.
```

## Usage
```bash
- terraform fmt : Formats terraform configuration files. 
- terraform init :  initializes a working directory containing Terraform configuration files.
- terraform validate : checks the syntax and internal consistency of Terraform configuration files
- terraform plan -out main.tfplan : generates an execution plan showing what changes Terraform will make to reach the desired state of infrastructure
- terraform apply main.tfplan : applies the changes outlined in the saved plan file (main.tfplan)
- terraform plan -var subscription_id=$SUBSCRIPTION -var client_secret="$SERVICE_PRINCIPAL_SECRET" -var client_id=$CLINT_ID -out=tfplan.binary
## Only run this command if you want to destroy the whole cluster.  
- terraform destroy -var subscription_id=$SUBSCRIPTION -var client_secret="$SERVICE_PRINCIPAL_SECRET" -var client_id=$CLINT_ID  
```
## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| resourceGroupName | Name of the resource group | string | "ics-dev-aks-rg" |
| location | Azure region where resources will be created | string | "centralus" |
| resourceName | Name of the AKS cluster | string | "ics-dev-aks-cluster" |
| managedNodeResourceGroup | Name of the resource group for managed AKS resources | string | "ics-dev-aks-mrg" |
| SystemPoolType | VM size for the system node pool | string | "Standard" |
| nodePoolName | Name of the default node pool | string | "icsdevpool01" |
| registries_sku | SKU for the Azure Container Registry | string | "Basic" |
| omsagent | Enable OMS agent for monitoring | bool | true |
| retentionInDays | Log retention period in days | number | 30 |
| authorizedIPRanges | Authorized IP ranges for API server access | list(string) | ["198.180.200.254/32"] |
| ingressApplicationGateway | Enable Application Gateway Ingress Controller | bool | true |
| keyVaultAksCSI | Enable Key Vault CSI driver | bool | true |
| keyVaultCreate | Create a new Key Vault | bool | true |
| keyVaultAksCSIPollInterval | Poll interval for Key Vault CSI driver | string | "30m" |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_name | The name of the resource group |
| aks_cluster_name | The name of the AKS cluster |
| aks_cluster_id | The ID of the AKS cluster |
| kube_config | The kubeconfig for the AKS cluster |
| acr_login_server | The login server URL for the Azure Container Registry |
| key_vault_id | The ID of the Key Vault |
| key_vault_uri | The URI of the Key Vault |
| log_analytics_workspace_id | The ID of the Log Analytics workspace |



