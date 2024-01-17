param(
  [Parameter(Mandatory=$true)]
  [string]$personalToken,
  [Parameter(Mandatory=$true)]
  [string]$memberId
)

try{
    ## https://app.vssps.visualstudio.com/_apis/profile/profiles/me?api-version=6.0

    $token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalToken)"))
    $header = @{authorization = "Basic $token" }
    $url = "https://app.vssps.visualstudio.com/_apis/accounts?api-version=6.0&memberId=$memberId"
    $adoOrganizationsResponse = Invoke-restmethod -uri $url -Headers $header -Method get -ContentType application/json

    #$adoOrganizations = ($adoOrganizationsResponse.value | Where-Object { $_.accountName -eq "CentricaSandbox" }).accountName
    $adoOrganizations = $adoOrganizationsResponse.value.accountName
    $adoOrganizations = $adoOrganizations | ? {$_ -ne "BA-Centrica-Dyno"}
    $userData = @()

    $dateNow = [datetime]::parseexact((get-date -Format "yyyy-MM-dd"),"yyyy-MM-dd",$null)
    $date7DaysOld = $dateNow.AddDays(-7)
    $date60DaysOld = $dateNow.AddDays(-60)
    $date30DaysOld = $dateNow.AddDays(-30)

    $adoOrganizations

    foreach ($adoOrganization in $adoOrganizations) {
        Write-Host "----------------------------------------------------"
        $adoOrganization
        Write-Host "----------------------------------------------------"
        $orgUrl = "https://vsaex.dev.azure.com/$adoOrganization/_apis/userentitlements?top=10000&select=project&api-version=6.0-preview.1"
        $userlist = (Invoke-RestMethod -uri $orgUrl -Headers $header -Method get -ContentType application/json -ErrorAction SilentlyContinue) 
        #$userlist.value #.accessLevel.licenseDisplayName

        #Loop through each user 
        foreach ($user in $userlist.value) { 
            $userDisplayName = $user.user.displayName 
            $userAccessLevel = $user.accessLevel.licenseDisplayName
            $lastAccessed = ($user.lastAccessedDate)            
            $dateCreated = ($user.dateCreated)

            $dateCreatedFormat = [datetime]::parseexact($dateCreated.split("T")[0], 'yyyy-MM-dd', $null)
            $lastAccessedFormat = [datetime]::parseexact($lastAccessed.split("T")[0], 'yyyy-MM-dd', $null)

            if (($lastAccessed -eq "0001-01-01T00:00:00Z" -and $userAccessLevel -ne "Stakeholder") -and ($lastAccessedFormat -lt $date30DaysOld -and $dateCreatedFormat -lt $date7DaysOld -and $userAccessLevel -ne "Stakeholder")) { #$lastAccessed -eq "0001-01-01T00:00:00Z"
                $userObject = [PSCustomObject]@{ 
                    Organization = $adoOrganization 
                    User         = $userDisplayName 
                    AccessLevel  = $userAccessLevel 
                    LastAccessed = $lastAccessed 
                    DateCreated = $dateCreated
                } 
                $userData += $userObject 
            }
        }
    }

    $userData.count
    # $userData | Format-Table
    # $userDetails = $userData
    $csvFilePath = $PSScriptRoot+"/UserReport.csv"
    $userData | Export-Csv -Path $csvFilePath -NoTypeInformation
}
catch{
    Write-Host "Some error occured : `n"$_
}
