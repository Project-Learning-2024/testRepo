az monitor metrics alert update --enabled true --name "Athena Prod ADF failure alert" --resource-group "azsu-rg-athena-prod-001"
az monitor metrics alert update --enabled true --name "SIPD-D365 PROD Availability Test Alert" --resource-group "azsu-rg-coreloganalyticsprod-sipd-001"
az monitor metrics alert update --enabled true --name "Pipeline Failure" --resource-group "azsu-rg-data-deltalake-prod-001"
az monitor metrics alert update --enabled true --name "Pipeline Failure" --resource-group "azsu-rg-data-prod-001"
##############################################################################################
az config set extension.use_dynamic_install=yes_without_prompt
az monitor scheduled-query update --disabled false --name "Failurerate of WorkOrder related operations are High" --resource-group "azsu-rg-coreloganalyticsprod-sipd-001"
az monitor scheduled-query update --disabled false --name "Request Failure due to breaching concurrent API limits" --resource-group "azsu-rg-coreloganalyticsprod-sipd-001"
