# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-6.2.1
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    New-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
    Remove-AzFirewallPolicy:                    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewallpolicy?view=azps-6.2.1
} #>
<# Required Functions Links: {
    NewAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/NewAzFWPolicy.ps1
    ListAzFWPolicy:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/ListAzFWPolicy.ps1
    RemoveAzFWPolicy:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/RemoveAzFWPolicy.ps1
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzFWPolicyRCG:        Function to manage firewall policy Rule Collection groups
    NewAzFWPolicy:              Function to create a new firewall policy
    ListAzFWPolicy:             Function to list all firewall policies
    RemoveAzFWPolicy:           Function to remove a firewall policy
    GetAzFWPolicy:              Function to get a firewall policy
    GetAzResourceGroup:         Function to get a resource group
} #>
<# Variables: {      
    :ManageAzureFWPolicyRCG     Outer loop for managing function
    $OpSelect:                  Operator input to select management function
    NewAzFWPolicy{}             Creates $FWPolicyObject
        GetAzResourceGroup{}        Gets $RGObject
    ListAzFWPolicy{}            Lists $FWPolicyObject
    RemoveAzFWPolicy{}          Removes $FWPolicyObject
        GetAzFWPolicy{}             Gets $FWPolicyObject  
} #>
<# Process Flow {
    function
        Call NewAzFWPolicy > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzFWPolicy > Send $RGObject
        End NewAzFWPolicy
            Return function > Send $null
}#>
function ManageAzFWPolicyRCG {                                                              # Function to manage firewall policy Rule Collection groups
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            Write-Host 'Manage Firewall Policy Rule Collection Groups'                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Policy RCG (In Dev)'                               # Write message to screen
            Write-Host '[2] List Firewall Policies RCG'                                     # Write message to screen
            Write-Host '[3] Remove Firewall Policy RCG'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicyRCG                                                # Breaks :ManageAzureFWPolicyRCG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall Policy RCG'                                        # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Policies RCG'                                     # Write message to screen
                ListAzFWPolicyRCG                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall Policy'                                         # Write message to screen
                RemoveAzFWPolicyRCG                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzFWPolicyRCG
function ListAzFWPolicyRCG {                                                                # Function to list all firewall policy rule collection group
    Begin {                                                                                 # Begin function
        :ListAzureFWPolicyRCG while ($true) {                                               # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collection groups'                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicyRCG                                                  # Breaks :ListAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $FWPolicyRCG = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicy.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicy.Name                             # Gets the current item rule collection group object
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$FWPolicyRCG.Name;                                           # Policy RCG name
                        'Priority'=$FWPolicyRCG.Properties.Priority;                        # Policy RCG priority
                        'RuleColl'=$FWPolicyRCG.Properties.RuleCollection;                  # Policy RCG rule collection
                        'PolicyName'=$FWPolicy.Name;                                        # Policy name
                        'RG'=$FWPolicy.ResourceGroupName;                                   # Policy resource group name
                        'Location'=$FWPolicy.Location;                                      # Policy location
                        'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                        # Policy threat intel mode
                        'FWName'=$FirewallObject.Name;                                      # Firewall name
                        'RCGList'=$RCGList;                                                 # Rule collection group names
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $RCGName = $null                                                        # Clears $var
                    $FWPolicyRCG = $null                                                    # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No firewall policy rule collection groups exist'                # Write messag to screen
                Write-Host ''                                                               # Write messag to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicyRCG                                                  # Breaks :ListAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'RCG Name:     '$_.Name                                          # Write message to screen
                Write-Host 'RCG Priority: '$_.Priority                                      # Write message to screen
                if ($_.RuleColl) {                                                          # If current item .RuleColl has a value
                    $RuleList = $_.RuleColl                                                 # $RuleList is equal to current item.RuleColl
                    Write-Host 'Rules        {'                                             # Write message to screen
                    foreach ($Name in $RuleList) {                                          # For each item in $RuleList
                        Write-Host '              '$Name.Name                               # Write message to screen
                    }                                                                       # End foreach ($Name in $RuleList)
                    Write-Host '             } '                                            # Write message to screen
                    $RuleList = $null                                                       # Clears $var
                }                                                                           # End if ($_.RuleColl)
                else {                                                                      # Else if current item .RuleColl is $null
                    Write-Host 'Rules:         None'                                        # Write message to screen
                }                                                                           # End else (if ($_.RuleColl))
                Write-Host 'Policy Name:  '$_.PolicyName                                    # Write message to screen
                Write-Host 'Policy RG:    '$_.RG                                            # Write message to screen
                Write-Host 'Policy Loc:   '$_.Location                                      # Write message to screen
                Write-Host 'Policy TIM:   '$_.ThreatIntelMode                               # Write message to screen                    
                if ($_.FWName) {                                                            # If current item .FWName has a value
                    Write-Host 'Firewall Name:'$_.FWName                                    # Write message to screen
                }                                                                           # End if ($_.FWName) 
                else {                                                                      # Else if current item .FWName is $null
                    Write-Host 'Firewall Name: Not Assigned'                                # Write message to screen
                }                                                                           # End else (if ($_.FWName))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureFWPolicyRCG                                                      # Breaks :ListAzureFWPolicyRCG
        }                                                                                   # End :ListAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPolicyRCG
function RemoveAzFWPolicyRCG {                                                              # Function to remove a firewall policy rule collection group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPolicyRCG'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            $FWPolicyRCGObject, $FWPolicyObject = GetAzFWPolicyRCG ($CallingFunction)       # Calls function and assigns output to $var
            if (!$FWPolicyRCGObject) {                                                      # If $FWPolicyRCGObject does not have a value
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyRCGObject) 
            $FirewallObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            Write-Host 'Remove Rule Collection Group:'$FWPolicyRCGObject.Name               # Write message to screen
            Write-Host 'From:'                                                              # Write message to screen
            Write-Host 'Firewall Policy:'$FWPolicyObject.name                               # Write message to screen
            if ($FirewallObject) {                                                          # If $FirewallObject has a value
                Write-Host 'Firewall Name:  '$FirewallObject.name                           # Write message to screen
                $VNetName = $FirewallObject.IPConfigurations.Subnet.ID.Split('/')[8]        # Isolates the Vnet name
                Write-Host 'VNet Name:      '$VNetName                                      # Write message to screen    
            }                                                                               # End if ($FirewallObject)
            else {                                                                          # Else if $FirewallObject is $null
                Write-Host 'Firewall Name:   N/A'                                           # Write message to screen
                Write-Host 'VNet Name:       N/A'                                           # Write message to screen        
            }                                                                               # End else (if ($FirewallObject))
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall policy rule collection group'             # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewallPolicyRuleCollectionGroup -Name `
                        $FWPolicyRCGObject.Name -ResourceGroupName `
                        $FWPolicyObject.ResourceGroupName -AzureFirewallPolicyName `
                        $FWPolicyObject.Name -Force -ErrorAction 'Stop' | Out-Null          # Removes the firewall policy rule collection group
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureFWPolicyRCG                                            # Breaks :RemoveAzureFWPolicyRCG    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy rule collection group has been removed'     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFWPolicyRCG
function GetAzFWPolicyRCG {                                                                 # Function to get firewall policy rule collection group
    Begin {                                                                                 # Begin function
        :GetAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collection groups'                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicyRCG                                                   # Breaks :GetAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $FWPolicyRCG = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicy.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicy.Name                             # Gets the current item rule collection group object
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$FWPolicyRCG.Name;                                           # Policy RCG name
                        'Priority'=$FWPolicyRCG.Properties.Priority;                        # Policy RCG priority
                        'RuleColl'=$FWPolicyRCG.Properties.RuleCollection;                  # Policy RCG rule collection
                        'PolicyName'=$FWPolicy.Name;                                        # Policy name
                        'RG'=$FWPolicy.ResourceGroupName;                                   # Policy resource group name
                        'Location'=$FWPolicy.Location;                                      # Policy location
                        'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                        # Policy threat intel mode
                        'FWName'=$FirewallObject.Name;                                      # Firewall name
                        'RCGList'=$RCGList;                                                 # Rule collection group names
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                    $RCGName = $null                                                        # Clears $var
                    $FWPolicyRCG = $null                                                    # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No firewall policy rule collection groups exist'                # Write messag to screen
                Write-Host ''                                                               # Write messag to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicyRCG                                                   # Breaks :GetAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFWPolicyRCG while ($true) {                                         # Inner loop for selecting the firewall policy rule collection group
                Write-Host '[0]            Exit'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]          "$_.Name                             # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'RCG Priority: '$_.Priority                                  # Write message to screen
                    if ($_.RuleColl) {                                                      # If current item .RuleColl has a value
                        $RuleList = $_.RuleColl                                             # $RuleList is equal to current item.RuleColl
                        Write-Host 'Rules        {'                                         # Write message to screen
                        foreach ($Name in $RuleList) {                                      # For each item in $RuleList
                            Write-Host '              '$Name.Name                           # Write message to screen
                        }                                                                   # End foreach ($Name in $RuleList)
                        Write-Host '             } '                                        # Write message to screen
                        $RuleList = $null                                                   # Clears $var
                    }                                                                       # End if ($_.RuleColl)
                    else {                                                                  # Else if current item .RuleColl is $null
                        Write-Host 'Rules:         None'                                    # Write message to screen
                    }                                                                       # End else (if ($_.RuleColl))
                    Write-Host 'Policy Name:  '$_.PolicyName                                # Write message to screen
                    Write-Host 'Policy RG:    '$_.RG                                        # Write message to screen
                    Write-Host 'Policy Loc:   '$_.Location                                  # Write message to screen
                    Write-Host 'Policy TIM:   '$_.ThreatIntelMode                           # Write message to screen                    
                    if ($_.FWName) {                                                        # If current item .FWName has a value
                        Write-Host 'Firewall Name:'$_.FWName                                # Write message to screen
                    }                                                                       # End if ($_.FWName) 
                    else {                                                                  # Else if current item .FWName is $null
                        Write-Host 'Firewall Name: Not Assigned'                            # Write message to screen
                    }                                                                       # End else (if ($_.FWName))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the firewall policy RCG for:'$CallingFunction    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall policy
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFWPolicyRCG                                               # Breaks :GetAzureFWPolicyRCG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FWPolicyRCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name `
                        $OpSelect.Name -ResourceGroupName $OpSelect.RG `
                        -AzureFirewallPolicyName $OpSelect.PolicyName                       # Pulls the full policy rule collection group object
                    $FWPolicyObject = Get-AzFirewallPolicy -Name $OpSelect.PolicyName `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full policy object
                    Return $FWPolicyRCGObject, $FWPolicyObject                              # Returns to calling function with $FWPolicyRCGObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFWPolicyRCG while ($true)
        }                                                                                   # End :GetAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzFWPolicyRCG