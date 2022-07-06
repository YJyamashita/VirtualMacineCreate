# VMの名前をセット, Switchの名前をセット, インストールするメディアのPathをセット.
$VMName = 'RTS-VM1'
$Switch = 'Private'
$InstallMedia = 'C:\ISO\xxxxxxxxxxxxxxxxxxxxxx'

# 新規仮想マシンを作成する
New-VM -Name $VMName -MemoryStartupBytes 2147483648 -Generation 2 -NewVHDPath "C:\VHD\$VMName.vhdx" -NewVHDSizeBytes 53687091200 -Path "c:\VM\$VMName" -SwitchName $Switch

# Add DVD Drive to Virtual Machine
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive