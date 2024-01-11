az account set -s "623fbf80-a26a-4955-a8b6-f602a56cb50f"
$actiongroup_id = "/subscriptions/623FBF80-A26A-4955-A8B6-F602A56CB50F/resourceGroups/azsu-rg-Integration-preprod-001/providers/microsoft.insights/actionGroups/AG_Snow_Int_PreProd"
az config set extension.use_dynamic_install=yes_without_prompt
az monitor scheduled-query update --resource-group "azsu-rg-forecast-preprod-01" --name "Forecasting-PreProd-Long Running Pipelines" --action-groups $actiongroup_id