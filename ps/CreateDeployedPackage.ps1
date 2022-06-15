param ($packageId, $destinationEnv, $notes)
#Deploys the PackagedComponent created in CreatePackagedComponent
. ./ps/modules/Common.ps1

$resource = "DeployedPackage"

$body=@"
{  
  "packageId" : "$packageId",
  "environmentId" : "$destinationEnv",
  "notes" : "$notes"
}
"@

Write-Host ($body | Format-Table | Out-String)
$response = Send-BoomiRestRequest $resource $body "POST"
Write-Host ($response| Format-Table | Out-String)
$deploymentId = $response.deploymentId
#$deploymentId = "DepoymentIdHardCode"
Write-Host "deploymentId "+$deploymentId
Write-Host "##vso[task.setvariable variable=deploymentId;isOutput=true]"+$deploymentId