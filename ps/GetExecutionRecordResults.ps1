param ($resultUrl)
Write-Host "ResultURL "$resultUrl
#Retrieves the results of the test run
. ./ps/modules/Common.ps1

#split the ExecutionRecord url
$parts = $resultUrl -csplit "ExecutionRecord" #this should be everything from Execution onwards, e.g. /async/executionrecord-7a16f4da-11c7-481a-8f76-c62cd708f514
Write-Host ($parts | Format-Table | Out-String)

$resource = "ExecutionRecord"+$parts[1];
Write-Host $resource
$response = Send-BoomiRestRequest $resource
Write-Host $response
Write-Host ($response| Format-Table | Out-String)
$status = $response.result[0].status #ERROR or COMPLETE
#$status = "ERROR"
Write-Host "Boomi Test Status "$status
Write-Host "##vso[task.setvariable variable=boomiTestStatus;isOutput=true]$status"