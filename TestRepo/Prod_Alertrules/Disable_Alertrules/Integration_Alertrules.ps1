#Disabling Metric Alerts:
$Alertrules = @( "Integration Api - 401|429 error",
"Integration-ADF-GCNFeed-FailedPipeline",
"Integration-ADF-Inventory-FailedPipeline",
"Integration-ADF-PRODUCTSFEED-FailedPipeline",
"Integration-ADF-rejectedtimeoff-FailedPipeline",
"Integration-BGE-ADF-ProductsFeed-Pipeline Failures",
"Integration-BGE-ADF-ProductsFeed-Pipeline Failures Snow Trigger",
"Integration-BGE-LA-ProductsFeed-SFTP Failures",
"Integration-BGE-LA-ProductsFeed-SFTP Failures Snow Trigger",
"Integration-BGE-SB-CCB-ServicePoint-Postback Failures",
"Integration-BGE-SB-CCB-ServicePoint-Postback Failures Snow Trigger",
"Integration-BGE-SB-CCB-WorkOrder-Backfill Failures",
"Integration-BGE-SB-CCB-WorkOrder-History-Backfill Failures",
"integration-comms.notifications.d365-deadletter-events",
"integration-comms.notifications.d365-deadletter-events-error",
"integration-futureloa-failure-events-WD",
"integration-partsorder.batch-deadletter-events",
"integration-partsorder.batch-deadletter-events-error",
"integration-partsorder.calidus-deadletter-events",
"integration-partsorder.calidus-deadletter-events-error",
"integration-partsorder.d365-deadletter-events",
"integration-partsorder.d365-deadletter-events-error",
"integration-postatus-deadletter-events",
"integration-Productgroups.publish.error-activemessages-threshold",
"integration-sapworkorder-backfill-deadletter-events",
"integration-statuschange-deadletter-events",
"integration-statuschange-digital-deadletter-events",
"integration-statuschange-elli-deadletter-events",
"integration-wostatus-outbound-deadletter-events",
"integration-wostatus-outbound-deadletter-events-error",
"integration-wostatus-sap-activemessages-threshhold",
"la-integration-gcnfeed-sftp",
"la-integration-products-backfill",
"la-integration-productsfeed-sftp",
"la-statusupdate-digital",
"la-statusupdate-elli",
"la-wochannelrulecreate",
"la-wochannelruledelete",
"la-wochannelrulerefresh",
"la-wochannelruleupdate",
"SIPD-Integration-SB-CPU",
"SIPD-Integration-SB-MemoryUsage",
"SIPD-Integration-SB-ServerErrors",
"SIPD-Integration-SB-ThrottledRequest",
"SIPD - Integration APIM Service Capacity"
)
 foreach ($rule in $Alertrules)
 {
     $rg = "azsu-rg-Integration-prod-001"
     az monitor metrics alert update --enabled false --name "$rule" --resource-group "$rg"
 }
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#Disabling scheduledqueryrules:
$Alertrules = @( "Appointment Slots API Dependency failures",
"Appointment Slots API Dependency failures Snow Trigger",
"Integration Wostatus Outbound Digital Deadletter Events Snow Trigger",
"Integration WoStatusDataEnricher Deadletter Events-snowtrigger",
"integration-api-failed-response-status",
"Integration-BGE-Appointment API Failures",
"Integration-BGE-Appointment API Failures Snow Trigger",
"Integration-BGE-SB-CCB-WorkOrder-Status Failures",
"Integration-BGE-SB-WorkOrder-Status-DataEnricher Failures",
"Integration-BGE-WorkOrder API Failures",
"integration-exceptions",
"integration-leaveofabsence-failure-events-WD",
"integration-pickconfirmation-deadletter-events",
"integration-premisesafety-risk-deadletter-events",
"integration-rejecttimeoff-failure-events-WD",
"integration-returnloa-failure-events-WD",
"integration-statuschange-dynamics-failed-events",
"integration-wostatus-outbound-digital-deadletter-events",
"Integration-wostatus-outbound-sap-deadletter-events",
"Integration-wostatus-outbound-sap-deadletter-events Snow Trigger",
"integration-wostatusdataenricher-deadletter-events",
"No records found in Parts order status",
"Routing API - Dependency failures",
"workorder-api-v2-createworkorder-failure",
"workorder-api-v2-dependency-failure"
)
foreach ($rule in $Alertrules)
 {
	$rg = "azsu-rg-Integration-prod-001"
	az config set extension.use_dynamic_install=yes_without_prompt
	az monitor scheduled-query update --disabled true --name "$rule" --resource-group "$rg"
 }	
