# Login to Azure
az login

# Set the default subscription
az account set --subscription "<subscription_id_OR_subscription_name>"

# Variables
# resourceGroupName="<resource_group_name>"
# functionAppName="<function_app_name>"
# location="<location>"
# runtime="<runtime>"
# storageAccountName="<storage_account_name>"
# appInsightsName="<application_insights_name>"

resourceGroupName="af-aad-rg"
functionAppName="af-aad-func"
functionVersion="4"
location="uksouth"
runtime="dotnet"
operatingSystem="linux"
storageAccountName="afaadstorage"
appInsightsName="afaadappinsights"

# Create a resource group
az group create \
  --name $resourceGroupName \
  --location $location

# Create a storage account
az storage account create \
  --name $storageAccountName \
  --location $location \
  --resource-group $resourceGroupName \
  --sku Standard_LRS


# Create an Application Insights component
az monitor app-insights component create \
  --app $appInsightsName \
  --location $location \
  --resource-group $resourceGroupName


# Create an Azure Function App with Application Insights enabled
az functionapp create \
  --name $functionAppName \
  --resource-group $resourceGroupName \
  --functions-version $functionVersion \
  --storage-account $storageAccountName \
  --consumption-plan-location $location \
  --runtime $runtime \
  --os-type $operatingSystem \
  --app-insights $appInsightsName

