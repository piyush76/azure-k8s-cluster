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

## Usage

```hcl
module "aks_cluster" {
  source = "github.com/your-repo/terraform-aks-azure"

  # Resource Group
  resourceGroupName = "my-aks-rg"
  location          = "eastus"
  
  # AKS Cluster
  resourceName             = "my-aks-cluster"
  managedNodeResourceGroup = "my-aks-mrg"
  SystemPoolType           = "Standard_DS2_v2"
  nodePoolName             = "systempool"
  
  # Container Registry
  registries_sku = "Basic"
  
  # Monitoring
  omsagent        = true
  retentionInDays = 30
  
  # Network Security
  authorizedIPRanges = ["x.x.x.x/32"] # Your IP range
  
  # Application Gateway
  ingressApplicationGateway = true
  
  # Key Vault
  keyVaultAksCSI             = true
  keyVaultCreate             = true
  keyVaultAksCSIPollInterval = "30m"
}
```

See the `examples` directory for complete usage examples.

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

## License

MIT
