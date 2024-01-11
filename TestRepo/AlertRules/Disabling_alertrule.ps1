az monitor metrics alert update --enabled false --name "Forecasting PreProd - ADF Pipeline Failure Alert" --resource-group "azsu-rg-forecast-preprod-01"
az config set extension.use_dynamic_install=yes_without_prompt
az monitor scheduled-query update --disabled true --name "Forecasting-PreProd-Long Running Pipelines" --resource-group "azsu-rg-forecast-preprod-01"

#az monitor metrics alert update --enabled false --name "Failure Anomalies - azsuappinsightforecastpprod" --resource-group "azsu-rg-forecast-preprod-01"
#Disable_Enable_AllAlertRulesInRG.ps1 -ResourceGroupName "azsu-rg-rostering-es-001"
#$Alertrules = @( "forecasting pre-prod - adf pipeline failure alert",
#"Forecasting PreProd - ADF Pipeline Failure Alert"
#)
 #foreach ($rule in $Alertrules)
 #{
  #   $rg = "azsu-rg-forecast-preprod-01"
  #  az monitor metrics alert update --enabled false --name "$rule" --resource-group "$rg"
 #}

#Disable-AzActivityLogAlert -Name "asp-integration-channelrouting-scale-down" -ResourceGroupName "azsu-rg-Integration-preprod-001"

#az monitor activity-log alert update --resource-group "azsu-rg-Integration-preprod-001" --name "asp-integration-channelrouting-scale-down" --enabled false

#Update-AzActivityLogAlert -Name "asp-integration-channelrouting-scale-down" -ResourceGroupName "azsu-rg-Integration-preprod-001" -Enabled $false

