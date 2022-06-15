param ($processId, $runtimeId, $shouldForceFail)
Write-Host "ProcessId "$processId
#Executes a deployed process on the specified runtime
. ./ps/modules/Common.ps1

$resource = "ExecutionRequest"

$body=@"
{
    "@type": "ExecutionRequest",
    "processId": "$processId",
    "atomId": "$runtimeId",
    "DynamicProcessProperties": {
        "DynamicProcessProperty": [{
            "name":"DPP-ForceFail",
            "value":"$shouldForceFail"
        }]
    }
}
"@

Write-Host ($body | Format-Table | Out-String)
$response = Send-BoomiRestRequest $resource $body "POST"
Write-Host ($response| Format-Table | Out-String)
$recordUrl = $response.recordUrl
#$deploymentId = "DepoymentIdHardCode"
Write-Host "recordUrl "+$recordUrl
Write-Host "##vso[task.setvariable variable=recordUrl;isOutput=true]"+$recordUrl