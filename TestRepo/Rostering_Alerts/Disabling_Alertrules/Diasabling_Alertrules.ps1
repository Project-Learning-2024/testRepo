$Alertrules = @( "500 Error in Gap Resolution API",
"API Exceptions Capman Pre Prod"
)
foreach ($rule in $Alertrules)
 {
	$rg = "azsu-rg-rostering-preprod-001"
	az config set extension.use_dynamic_install=yes_without_prompt
	az monitor scheduled-query update --disabled true --name $rule"" --resource-group "$rg"
 }