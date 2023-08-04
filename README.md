# Hyper-V Export Script
Simple script to export VMs from Hyper-V.

I run a lab environment in Hyper-V and it may not always be feasable to run a full MABS or SCDPM (though you should [read this](https://learn.microsoft.com/en-us/azure/backup/backup-overview#what-can-i-back-up) to see all the options).

While you can certainly use Windows Backup and [Hyper-V Checkpoints](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/checkpoints) sometimes exports just make sense for various reasons.

This script simply runs through all of the VMs in Hyper-V and exports and compresses them to a named location with an appended timestamp.