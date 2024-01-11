az monitor metrics alert update --enabled true --name "Forecasting PreProd - ADF Pipeline Failure Alert" --resource-group "azsu-rg-forecast-preprod-01"
az config set extension.use_dynamic_install=yes_without_prompt
az monitor scheduled-query update --disabled false --name "Forecasting-PreProd-Long Running Pipelines" --resource-group "azsu-rg-forecast-preprod-01"