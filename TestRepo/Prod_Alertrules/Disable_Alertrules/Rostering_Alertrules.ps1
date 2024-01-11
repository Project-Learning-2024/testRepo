#Disabling Metric Alerts:
$Alertrules = @( "Alert on Capman Appointing and Capacity Validation API",
"Roster ADF Pipelines Failures",
"Rostering Prod - adf pipeline failure alert"
)
 foreach ($rule in $Alertrules)
 {
     $rg = "azsu-rg-rostering-prod-001"
     az monitor metrics alert update --enabled false --name "$rule" --resource-group "$rg"
 }
#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
#Disabling scheduledqueryrules:
$Alertrules = @( "500 Error in Gap Resolution API",
"500 Error in the CapMan Appointing API",
"500 Error in Work Approval API",
"API Exceptions Capman Prod",
"Appointing API reduced slots offering below threshold 80",
"Capman Data ingest Prod",
"Capman Datasync prod",
"Capman Datasync prod Snow Trigger",
"Capman Incremental Update Prod Snow Trigger",
"Performance Management for Prod API's",
"Roster Publish Production",
"Roster Runs Production",
"WorkApprovalAPI Exceptions"
)
foreach ($rule in $Alertrules)
 {
	$rg = "azsu-rg-rostering-prod-001"
	az config set extension.use_dynamic_install=yes_without_prompt
	az monitor scheduled-query update --disabled true --name $rule"" --resource-group "$rg"
 }	
