## Matt Hansen 
## https://github.com/matthansen0
## Last Updated Nov 22, 2022
## This script will export all Hyper-V VMs to a specified location

#Set Variables
$date = Get-Date -Format "MM-dd-yyyy"
$base = "C:\backups\"
$logfile = "hyperv-export-job.log"
$log = $base + $logfile

# Start Logging
$logexists = Test-Path $log
If ($logexists -eq $True) {}
Else {New-Item -ItemType File -Path $base -Name $logfile}

Start-Transcript -Append $log

# Read in all VMs
$vms = Get-VM | ForEach-Object -MemberName Name

# Take new weekly snapshots
foreach ($vm in $vms){
    $backupfolder = $vm + $date
    $fullpath = $base + $backupfolder
    
    #Export VM(s)
    Export-VM -Name $vm -Path $fullpath -Passthru
    Write-Host -ForegroundColor Green "$vm export complete"
        }

Stop-Transcript

# Notification logic goes here, if desired. 