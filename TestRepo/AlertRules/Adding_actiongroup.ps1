#az monitor metrics alert update --name "test_action1" --resource-group "azsu-rg-rostering-es-001" --add-action "/subscriptions/c678f6a4-dcf2-44d6-bb9c-8773dc2ff347/resourceGroups/azsu-rg-devops-nfr-poc-001/providers/microsoft.insights/actionGroups/AG_snow_poc"
#az monitor metrics alert update --name "test_action1" --resource-group "azsu-rg-rostering-es-001" --remove-actions "/subscriptions/c678f6a4-dcf2-44d6-bb9c-8773dc2ff347/resourceGroups/azsu-rg-rostering-es-001/providers/microsoft.insights/actionGroups/test action"
#$Alertrules = @( "Forecasting PreProd - ADF Pipeline Failure Alert",
#"Forecasting-PreProd-Long Running Pipelines"
#)
#foreach ($rule in $Alertrules)
 #{
	#$rg = "azsu-rg-forecast-preprod-01"
	#$actiongroup_id = "/subscriptions/623FBF80-A26A-4955-A8B6-F602A56CB50F/resourceGroups/azsu-rg-Integration-preprod-001/providers/microsoft.insights/actionGroups/AG_Snow_Int_PreProd"
	#az monitor metrics alert update --name "$rule" --resource-group "$rg" --add-action "$actiongroup_id"
 #}

$Alertrules = @( "Forecasting-PreProd-Long Running Pipelines"
)
$rg = "azsu-rg-forecast-preprod-01"
$actiongroup_id = "/subscriptions/623FBF80-A26A-4955-A8B6-F602A56CB50F/resourceGroups/azsu-rg-Integration-preprod-001/providers/microsoft.insights/actionGroups/AG_Snow_Int_PreProd"
foreach ($rule in $Alertrules)
 {
	az config set extension.use_dynamic_install=yes_without_prompt
	az monitor scheduled-query update --name "$rule" --resource-group "$rg" --add-action "$actiongroup_id"
 }