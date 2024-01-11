Write-Host " Enabling Defender - Workex SA"
$Workex_rglist = @( "azsu-rg-workexecution-preprod-001",
"azsu-rg-we-smt-001"
)
$wrkex_rg1_salist = @( "azsusawediagpprd001",
"ukfwestrpreprod001"
)

$wrkex_rg2_salist = @( "ukfwestrsmt001"
)
foreach ($rg in $Workex_rglist)
{
echo "update in $rg"
if ($rg -eq "azsu-rg-we-smt-001")
{
foreach ($SA in $wrkex_rg2_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
else{
foreach ($SA in $wrkex_rg1_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
}