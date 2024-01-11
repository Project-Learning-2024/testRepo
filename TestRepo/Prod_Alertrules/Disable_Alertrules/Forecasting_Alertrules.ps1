Param(
    [string] $rg,
    [string] $Metric_Alertrule_name01,
    [string] $schd_qry_Alertrule_name01
)
az monitor metrics alert update --enabled false --name "$Metric_Alertrule_name01" --resource-group "$rg"
##################################################################
az config set extension.use_dynamic_install=yes_without_prompt
az monitor scheduled-query update --disabled true --name "$schd_qry_Alertrule_name01" --resource-group "$rg"
