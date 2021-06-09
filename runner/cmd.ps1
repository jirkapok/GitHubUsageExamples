
./config.cmd --url https://github.com/$env:GITHUBREPO_OR_ORG --token $env:GITHUBPAT

Start-Process -FilePath ".\run.cmd"

$failureCount = 0
$maxFailureCount = 3
while ($failureCount -lt $maxFailureCount) {
    Start-Sleep -Seconds 10;
    if ($Null -eq (get-process "Runner.Listener" -ea SilentlyContinue)) {
        $failureCount++;
        Write-Host "not running ($failureCount / $maxFailureCount)"
    }
    else {
        $failureCount = 0;
    }
}
