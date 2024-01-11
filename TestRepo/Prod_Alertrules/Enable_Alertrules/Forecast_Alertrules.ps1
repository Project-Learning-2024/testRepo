az monitor metrics alert update --enabled true --name "Forecasting Prod - ADF Pipeline Failure Alert" --resource-group "azsu-rg-forecast-prod-001"
################################################################################################
az config set extension.use_dynamic_install=yes_without_prompt
az monitor scheduled-query update --disabled false --name "Forecasting-Prod-Long Running Pipelines" --resource-group "azsu-rg-forecast-prod-001"
