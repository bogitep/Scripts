param (
    [int]$ProjectStart=1,
    [int]$ProjectEnd=3,
    [int]$PhaseStart=1,
    [int]$PhaseEnd=3
)
if (-not (Test-Path -Path "C:\Scripts")) {
    New-Item -Path "C:\Scripts" -ItemType Directory
}


for ($project = $ProjectStart; $project -le $ProjectEnd; $project++) {
    $projectPath = "C:\Projects\Project$project"
    if (-not (Test-Path -Path $projectPath)) {
        New-Item -Path $projectPath -ItemType Directory
        Write-Host "Created project directory: $projectPath"
    }

    for ($phase = $PhaseStart; $phase -le $PhaseEnd; $phase++) {
        $phasePath = "$projectPath\Phase$phase"
        if (-not (Test-Path -Path $phasePath)) {
            New-Item -Path $phasePath -ItemType Directory
            Write-Host "Created phase subdirectory: $phasePath"
        } else {
            Write-Host "Phase directory already exists: $phasePath"
        }
    }
}
