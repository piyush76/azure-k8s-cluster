
ENV=${1:-dev}

if [[ "$ENV" != "dev" && "$ENV" != "prod" ]]; then
  echo "Error: Environment must be 'dev' or 'prod'"
  echo "Usage: ./select-environment.sh [dev|prod]"
  exit 1
fi

if [ -z "$SUBSCRIPTION_ID" ]; then
  echo "Error: SUBSCRIPTION_ID environment variable is not set"
  echo "Please set it with: export SUBSCRIPTION_ID=your-subscription-id"
  exit 1
fi

if [ -z "$CLINT_ID" ]; then
  echo "Error: CLINT_ID environment variable is not set"
  echo "Please set it with: export CLINT_ID=your-client-id"
  exit 1
fi

if [ -z "$SERVICE_PRINCIPAL_SECRET" ]; then
  echo "Error: SERVICE_PRINCIPAL_SECRET environment variable is not set"
  echo "Please set it with: export SERVICE_PRINCIPAL_SECRET=your-client-secret"
  exit 1
fi

echo "Selecting $ENV environment..."
cp environments/$ENV.tfvars terraform.tfvars

export TF_VAR_environment=$ENV

echo "Environment set to $ENV"
echo "Initializing Terraform..."
terraform init

echo "Running Terraform plan..."
terraform plan -var subscription_id=$SUBSCRIPTION_ID \
  -var client_secret="$SERVICE_PRINCIPAL_SECRET" \
  -var client_id=$CLINT_ID \
  -out=tfplan.binary

echo "Plan saved to tfplan.binary"
echo "To apply the changes, run: terraform apply tfplan.binary"
echo ""
echo "Note: You can also run Terraform commands with the environment variable:"
echo "TF_VAR_environment=$ENV terraform apply"
