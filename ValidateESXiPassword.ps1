Function Validate-ESXiPassword {
    [CmdletBinding()]
    param (
        [String]$HostName,
        [String]$UserName,
        [String]$CurrentPassword
    )   
    $ErrorActionPreference = "Stop"
       
    try {   
        $Connection = Connect-VIServer $HostName -User $UserName -Password $CurrentPassword 
        if ($Connection.isconnected) {
            Write-Output "Success" 
        }
        else { 
            Write-Output "Failed" 
        }
    }   
     
    catch {
        switch -wildcard ($error[0].Exception.ToString().ToLower()) {
            "*incorrect user*" {
                Write-Output "Incorrect username or password on host '$HostName'"; break
                Disconnect-VIServer $HostName -Force -Confirm:$false
            }
            default { Write-Output "Error is: $($error[0].Exception.message)" }                   
           
        }
    }
}
Validate-ESXiPassword -HostName '[HostName]' -UserName '[UserName]' -CurrentPassword '[CurrentPassword]'