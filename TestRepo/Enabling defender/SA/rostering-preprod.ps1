Write-Host " Enabling Defender - Rostering SA"
$Rosterng_rglist = @( "azsu-rg-rostering-preprod-001",
"azsu-rg-rostering-smt-001"
)
$Roster_rg1_salist = @( "azsusacapmanadfpprd001",
"azsusacapmanarmpprd001",
"azsusacapmanattpprd001",
"azsusacapmandiagpprd001",
"azsusacapmanlogpprd001",
"azsusarostercsvpprd001",
"azsusarosteringfapprd001"
)
$Roster_rg2_salist = @( "azsusacapmanadfsmt001",
"azsusacapmanarmsmt001",
"azsusacapmanattsmt001",
"azsusacapmandiagsmt001",
"azsusacapmanlogsmt001",
"sqlvavuqzp4vrdwyds",
"azsusarostercsvsmt001",
"azsusarosteringfasmt001"
)
foreach ($rg in $Rosterng_rglist)
{
echo "update in $rg"
if ($rg -eq "azsu-rg-rostering-preprod-001")
{
foreach ($SA in $Roster_rg1_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
else{
foreach ($SA in $Roster_rg2_salist)
{
echo "Enabling defender for $SA"
az security atp storage update --resource-group $rg --storage-account $SA --is-enabled true
}
}
}