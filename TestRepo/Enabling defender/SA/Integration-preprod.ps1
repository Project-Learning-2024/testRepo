Write-Host " Enabling Defender - Integration SA"
$Integration_rglist = @( "azsu-rg-integration-datamigration-workorder-preprod-001",
"azsu-rg-integration-preprod-001",
"azsu-rg-integration-smt-001"
)
$Integ_rg1_salist = @( "azsusaintdatamgrtpreprod")

$Integ_rg2_salist = @( "azsusaintegrationpreprod",
"azsusaroutingpreprod001"
)
$Integ_rg3_salist = @( "azsusaintegrationsmt",
"azsusaroutingsmt001"
)
foreach ($rg in $Integration_rglist)
{
echo "update in $rg"
if ($rg -eq "azsu-rg-integration-preprod-001")
{
foreach ($SA in $Integ_rg2_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
elseif ($rg -eq "azsu-rg-integration-smt-001"){
foreach ($SA in $Integ_rg3_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
else{
foreach ($SA in $Integ_rg1_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
}