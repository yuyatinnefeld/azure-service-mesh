##################################### USE TERRAFORM VIA SERVICE PRINCIPAL #####################################
export AZURE_TENANT_DEV="xxx"
export SUBSCRIPTION_ID="xxx"
export AZURE_SERVICE_PRINCIPAL_APP_ID_DEV="xxx"
export AZURE_SERVICE_PRINCIPAL_PASSWORD_DEV="xxx"
export AZURE_CLIENT_ID_DEV="xxx"
export AZURE_CLIENT_SECRET="xxx"
export AZURE_STATE_FILE_STORAGE="xxx"
export AZURE_STORAGE_RESOURCE_GROUP="xxx"
export ENV="xxx"

export TF_VAR_ARM_TENANT_ID=$AZURE_TENANT_DEV
export TF_VAR_ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID_DEV
export TF_VAR_ARM_CLIENT_ID=$AZURE_CLIENT_ID_DEV
export TF_VAR_ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET

# !!! THIS MUST BE RUN BEFORE CI/CD PIPELINE TF SCRIPTS RUNNING !!!
export ARM_ACCESS_KEY=$(az storage account keys list --resource-group $AZURE_STORAGE_RESOURCE_GROUP-$ENV --account-name $AZURE_STATE_FILE_STORAGE --query '[0].value' -o tsv)
terraform init -backend-config="env/dev.tfbackend"