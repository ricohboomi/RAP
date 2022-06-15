$BOOMI_ACCOUNT=${Env:BOOMI_ACCOUNT}
$BASIC_AUTH=${Env:BASIC_AUTH}
$apiHost = 'https://api.boomi.com'
$apiBasePath = '/api/rest/v1/'

if ([string]::IsNullOrWhiteSpace($BOOMI_ACCOUNT)) { throw "BOOMI_ACCOUNT is not set" }
if ([string]::IsNullOrWhiteSpace($BASIC_AUTH))  { throw "BASIC_AUTH is not set" }

$apiBaseUrl = $apiHost+$apiBasePath+$BOOMI_ACCOUNT

function Send-BoomiRestRequest {
	[CmdletBinding()]
    param (
        $Resource, 
        $Body,
        $Method
    )
	Write-Host "METHOD - "$Method
    if ([string]::IsNullOrWhiteSpace($Method)) { $Method="GET" }
    
    $apiUrl = $apiBaseUrl+"/"+$resource;
	Write-Host "apiUrl - "$apiUrl
    $headers = @{
	    "Authorization" = "Basic $BASIC_AUTH"
	    "Content-Type" = "application/json"
	    "Accept" = "application/json"
	}
	#Write-Host $apiUrl+" - "+$Method
	$response = Invoke-RestMethod -Method $Method -Uri $apiUrl -Headers $Headers -Body $Body -Verbose
	
	return $response
}

#(Get-Command -Name Send-BoomiRestRequest).Parameters.Keys