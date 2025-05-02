

ENV=${1:-dev}

if [[ "$ENV" != "dev" && "$ENV" != "prod" ]]; then
  echo "Error: Environment must be 'dev' or 'prod'"
  echo "Usage: ./select-environment.sh [dev|prod]"
  exit 1
fi

echo "Selecting $ENV environment..."
cp environments/$ENV.tfvars terraform.tfvars

export TF_VAR_environment=$ENV

echo "Environment set to $ENV"
echo "Run 'terraform init' and 'terraform plan' to see the changes"
echo "To apply the changes, run 'terraform apply'"
echo ""
echo "Note: You can also run Terraform commands with the environment variable:"
echo "TF_VAR_environment=$ENV terraform apply"
