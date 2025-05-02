# Environment-Based Configuration for Azure Kubernetes Service

This guide explains how to use the environment-based configuration system for deploying Azure Kubernetes Service (AKS) clusters with different settings for development and production environments.

## Overview

The terraform-aks-azure project now supports environment-specific configurations, allowing you to:

- Deploy different AKS configurations based on environment (dev, prod)
- Use environment-specific variable files
- Select environments using Terraform environment variables
- Apply consistent naming conventions across environments

## Environment Files

Environment-specific configurations are stored in the `environments/` directory:

- `environments/dev.tfvars` - Development environment configuration
- `environments/prod.tfvars` - Production environment configuration

These files contain pre-configured settings optimized for each environment:

| Setting | Development | Production |
|---------|-------------|------------|
| VM Size | Standard_DS2_v2 | Standard_D4s_v3 |
| App Gateway | Disabled | Enabled |
| NGINX Ingress | Enabled | Disabled |
| Log Retention | 30 days | 90 days |
| DNS Zone | dev.apps.azure.incora.com | prod.apps.azure.incora.com |

## How to Use

### Option 1: Using the Selection Script

The easiest way to select an environment is to use the provided script:

```bash
# Select development environment
./select-environment.sh dev

# Select production environment
./select-environment.sh prod
```

This script:
1. Copies the appropriate environment file to `terraform.tfvars`
2. Sets the `TF_VAR_environment` environment variable
3. Provides instructions for the next steps

### Option 2: Manual Environment Selection

You can also manually select an environment:

```bash
# Copy the environment file
cp environments/dev.tfvars terraform.tfvars

# Set the environment variable
export TF_VAR_environment=dev

# Run Terraform commands
terraform init
terraform plan
terraform apply
```

### Option 3: Direct Environment Variable

You can specify the environment directly with Terraform commands:

```bash
# For development
TF_VAR_environment=dev terraform apply -var-file=environments/dev.tfvars

# For production
TF_VAR_environment=prod terraform apply -var-file=environments/prod.tfvars
```

## Customizing Environments

To customize an environment:

1. Copy the template file:
   ```bash
   cp terraform.tfvars.template terraform.tfvars
   ```

2. Edit the `terraform.tfvars` file with your desired settings

3. Apply with the appropriate environment:
   ```bash
   TF_VAR_environment=dev terraform apply
   ```

## Creating New Environments

To create a new environment (e.g., staging):

1. Create a new environment file:
   ```bash
   cp environments/dev.tfvars environments/staging.tfvars
   ```

2. Edit the file with appropriate settings

3. Update the `select-environment.sh` script to include the new environment

## Best Practices

- Always use the same environment name in both the tfvars file and the TF_VAR_environment variable
- Keep sensitive values out of environment files and use Terraform secrets management
- Test changes in development before applying to production
- Use version control to track changes to environment configurations
