## Matt Hansen 
## https://github.com/matthansen0
## Last Updated Aug 4, 2023
## This script will export and 7z compress all Hyper-V VMs to a specified location

#Set Variables
$date = Get-Date -Format "MM-dd-yyyy"
$base = "C:\backups"
$logfile = "hyperv-export-job.log"
$log = $base + $logfile

# Start Logging
$logexists = Test-Path $log
If ($logexists -eq $False) {
    New-Item -ItemType File -Path $base -Name $logfile
}

Start-Transcript -Append $log

# Read in all VMs
$vms = Get-VM | ForEach-Object -MemberName Name

# Take new weekly snapshots
foreach ($vm in $vms){
    $backupfolder = $vm + $date
    $fullpath = $base + $backupfolder
    
    #Export VM(s)
    $exportJob = Export-VM -Name $vm -Path $fullpath -AsJob

    # Wait for the Export-VM job to complete before moving on
    $exportJob | Wait-Job
    Write-Host -ForegroundColor Green "$vm export complete"

    <# 7z the folder with specified options
    archive format: 7z
    compression level: fastest
    compression method: lzma2
    dictionary size: 64 KB
    word size: 32
    solid block size: 16 MB #>
    $zipPath = "$fullpath.7z"
    & 'C:\Program Files\7-Zip\7z.exe' a -t7z -mx=1 -m0=lzma2 -md=64k -mfb=32 -ms=16m $zipPath $fullpath\*
    Write-Host -ForegroundColor Green "$vm compress to 7z complete"

    # Delete the unzipped folder
    Remove-Item -Path $fullpath -Recurse
    Write-Host -ForegroundColor Green "$vm export cleanup complete"
}

Stop-Transcript

# Notification logic goes here, if desired.
