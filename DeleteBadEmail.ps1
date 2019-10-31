#Pre-Req - Install S&C PSH Module "Install-Module O365SecurityAndComplianceShell"#

#Set Search Name#
$BadEmail = Read-Host -Prompt 'Insert Compliance Search Name'

#Set Subject#
$Subject = Read-Host -Prompt 'Insert bad email subject'

#Connect to S&C Center#
Connect-O365SecurityAndComplianceShell

#Show me what's happening#
Set-PSDebug -Trace 1

#Setup Search#
New-ComplianceSearch -Name "$BadEmail" -ExchangeLocation All -ContentMatchQuery subject:"$Subject"

#Run Search#
Start-ComplianceSearch -Identity "$BadEmail"

#Wait#
Start-Sleep -Seconds 60

#Purge Bad Email#
New-ComplianceSearchAction -SearchName "$BadEmail" -Purge -PurgeType SoftDelete

#Wait#
Start-Sleep -Seconds 60

#Get Results#
Get-ComplianceSearch -Identity "$BadEmail"