Param(
    [string] $csv,
    [string] $kv
)
#Keyvault module import
Import-Module Az.KeyVault
# write-host($CSV)
    $KeyVault = $kv

#Loading Default Secrets
$secrets = Import-CSV $csv

Function New-RandomPassword() {
    param(
        [int]$Size
    )
    $minLength = 16 ## characters
    $maxLength = $Size ## characters
    $length = Get-Random -Minimum $minLength -Maximum $maxLength
    $nonAlphaChars = $minLength
    $password = [System.Web.Security.Membership]::GeneratePassword($length, $nonAlphaChars)
    return $password
}
foreach ($secret in $secrets) {
    If ($secret.secret -eq 'random') {
        $tmpSecret = ConvertTo-SecureString (New-RandomPassword -Size 24) -AsPlainText -Force
    } else {
        $tmpSecret = ConvertTo-SecureString $secret.secret -AsPlainText -Force
    }
    if ((Get-AzKeyvaultSecret -VaultName $KeyVault -name $secret.name) -and ($secret.secret -cne (Get-AzKeyvaultSecret -VaultName $KeyVault -name $secret.name -AsPlainText))) {
        $tmp = Set-AzKeyVaultSecret -VaultName $KeyVault -Name $secret.name -SecretValue $tmpSecret
        write-host "Secret name is already present in KeyVault and Secret Value has been updated"
    }
    elseif (!(Get-AzKeyVaultSecret -VaultName $KeyVault -name $secret.name) -and ($secret.secret -cne (Get-AzKeyVaultSecret -VaultName $KeyVault -name $secret.name -AsPlainText))) {
        $tmp = Set-AzKeyVaultSecret -VaultName $KeyVault -Name $secret.name -SecretValue $tmpSecret
        write-host "New Secret has been updated in KeyVault"
    } else {
        write-host "Secret is already present in KeyVault"
    }
        
}  