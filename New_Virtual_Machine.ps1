# VMの名前をセット, Switchの名前をセット, インストールするメディアのPathをセット.
$VMName = 'RTS-VM1'
$Switch = 'Private'
$InstallMedia = 'C:\ISO\xxxxxxxxxxxxxxxxxxxxxx'

# 新規仮想マシンを作成する
New-VM -Name $VMName -MemoryStartupBytes 2147483648 -Generation 2 -NewVHDPath "C:\VHD\$VMName.vhdx" -NewVHDSizeBytes 53687091200 -Path "c:\VM\$VMName" -SwitchName $Switch

# 仮想マシンをDVDドライブにセットする
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# インストールメディアにマウントする
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# 作成したインストールメディアから仮想マシンを生成する
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive