# Set VM Name, Switch Name, and Installation Media Path.
$VMName = 'RTS-VM1'
$Switch = 'Private'
$InstallMedia = 'C:\ISO\14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.iso'

# Create New Virtual Machine
New-VM -Name $VMName -MemoryStartupBytes 2147483648 -Generation 2 -NewVHDPath "C:\VHD\$VMName.vhdx" -NewVHDSizeBytes 53687091200 -Path "c:\VM\$VMName" -SwitchName $Switch

# Add DVD Drive to Virtual Machine
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive