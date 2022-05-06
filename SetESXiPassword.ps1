Function Set-ESXiPassword {
   [CmdletBinding()]
   param (
      [String]$HostName,
      [String]$UserName,
      [String]$OldPassword,
      [String]$NewPassword
   )    
   try {
      $Connection = Connect-VIServer $HostName -User $UserName -Password $OldPassword
   } 
   catch {
      switch -wildcard ($error[0].Exception.ToString().ToLower()) {
         "*incorrect user*" { Write-Output "Incorrect username or password on host '$HostName'"; break }
         "*" { write-output $error[0].Exception.ToString().ToLower(); break }
      }
   }
   try {
      $change = Set-VMHostAccount -UserAccount $UserName -Password $NewPassword | out-string
      if ($change -like '*root*') {
         Write-Output "Success" 
      }
      else { 
         Write-Output "Failed" 
      }
      Disconnect-Viserver * -confirm:$false
   } 
   catch {
      switch -wildcard ($error[0].Exception.ToString().ToLower()) {
         "*not currently connected*" { Write-Output "It wasn't possible to connect to '$HostName'"; break }
         "*weak password*" { Write-Output "Failed to execute script correctly against Host '$HostName' for the account '$UserName'. It appears the new password did not meet the password complexity requirements on the host."; break }
         "*" { write-output $error[0].Exception.ToString().ToLower(); break }
         default { Write-Output "Got here" }
      }
   }
}
   
Set-ESXiPassword -HostName '[HostName]' -UserName '[UserName]' -OldPassword '[OldPassword]' -NewPassword '[NewPassword]'   