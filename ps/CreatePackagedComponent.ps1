param ($componentId, $version)
#Creates a PackagedComponent for the specified componentId.  This PackagedComponent is then deployed in CreateDeployedPackage.
. ./ps/modules/Common.ps1

$resource = "PackagedComponent"

$body = @"
{  
	"componentId" : "$componentId", 
  	"packageVersion" : "$version"
}
"@

Write-Host $resource
Write-Host ($body | Format-Table | Out-String)
$response = Send-BoomiRestRequest $resource $body "POST"
Write-Host ($jsonResponse| Format-Table | Out-String)
$packageId = $response.packageId
#$packageId = "00278aa3-8914-4b72-bea7-08547839d866"
Write-Host "packageId "$packageId
Write-Host "##vso[task.setvariable variable=packageId;isOutput=true]"$packageId