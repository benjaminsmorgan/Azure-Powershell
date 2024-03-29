# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzASGNIC:               Function to list NICs with an application security group
} #>
<# Variables: {      
    :ListAzureASGNIC            Outer loop for managing function
    $ObjectList:                List containing all nic objects that have ASGs
    $ObjectArray:               Array holding all the NIC info
    $ASGNames:                  Array holding all ASG names names on current nic
    $ASGIDList:                 Current item .IPConfigurations.ApplicationSecurityGroups.ID   
    $ASGName:                   Current item ASG name
    $ASGList:                   Current item .ASGNames
} #>
<# Process Flow {
    function
        Call ListAzASGNIC > Get $null              
        End ListAzASGNIC
            Return function > Send $null
}#>
function ListAzASGNIC {                                                                     # Function to list NICs with an application security group 
    Begin {                                                                                 # Begin function
        :ListAzureASGNIC while ($true) {                                                    # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID}                          # Gets a list of all network interfaces with an application security group
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No network interfaces present with'                             # Write message to screen
                Write-Host 'application security groups attached'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureASGNIC                                                       # Breaks :ListAzureASGNIC
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGNames = @()                                                             # Creates $ASGNamesArray
                $ASGIDList = $_.IPConfigurations.ApplicationSecurityGroups.ID               # Isolates the application security group names
                foreach ($ID in $ASGIDList) {                                               # For each item in $ASGIDList
                    $ASGName = $ID                                                          # ASGName is equal to current item
                    $ASGName = $ASGName.Split('/')[-1]                                      # Isolates the ASG name
                    $ASGNames += $ASGName                                                   # Adds $ASGName to $ASGNames
                    $ASGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $ASGIDList)
                $ASGNames = $ASGNames | Select-Object -Unique | Sort-Object                 # Removes duplcate items from $ASGNames
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'NicName'=$_.Name;                                                      # Nic name
                    'NICRG'=$_.ResourceGroupName;                                           # Nic RG
                    'IPConCount'=$_.IPConfigurations.Count;                                 # IP configurations count
                    'ASGNames'=$ASGNames                                                    # ASG names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGNames = $null                                                           # Clears $var
            }                                                                               # End foreach ($_ in $ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'NIC Name:'$_.NicName                                            # Write message to screen
                $ASGList = $_.ASGNames                                                      # ASGList is equal to current item .ASGNames
                foreach ($Name in $ASGList) {                                               # For each item in $ASGList
                    Write-Host 'ASG Name:'$Name                                             # Write message to screen
                }                                                                           # End foreach ($Name in $ASGList)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureASGNIC                                                           # Breaks :ListAzureASGNIC
        }                                                                                   # End :ListAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzASGNIC