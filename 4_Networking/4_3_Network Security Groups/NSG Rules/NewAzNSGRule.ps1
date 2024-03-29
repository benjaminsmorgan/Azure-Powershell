# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
    Add-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
    SetAzNSGRuleProtocol:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleProtocol.ps1
    SetAzNSGRuleAccess:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleAccess.ps1
    SetAzNSGRuleDirection:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDirection.ps1
    SetAzNSGRulePriority:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRulePriority.ps1
    SetAzNSGRuleSPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleSPortRange.ps1
    SetAzNSGRuleDPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDPortRange.ps1
    SetAzNSGRuleAddPrefix:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleAddPrefix.ps1  
    SetIPAddress:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetIPAddress.ps1
    SetCIDRAddress:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetCIDRAddress.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/GetAzASG.ps1
} #>
<# Functions Description: {
    NewAzNSGRule:               Function to create a new network security group rule
    GetAzNSG:                   Function to get a network security group
    SetAzNSGRuleProtocol:       Function to set a network security group rule protocol
    SetAzNSGRuleAccess:         Function to set a network security group rule access
    SetAzNSGRuleDirection:      Function to set a network security group rule direction
    SetAzNSGRulePriority:       Function to set a network security group rule priority
    SetAzNSGRuleSPortRange:     Function to set a network security rule source port range
    SetAzNSGRuleDPortRange:     Function to set a network security rule destination port range
    SetAzNSGRuleAddPrefix:      Function to set a network security rule address prefix     
    SetIPAddress:               Function to add an IP address to $var
    SetCIDRAddress:             Function to add a CIDR address to $var
    GetAzNSG:                   Function to get an application security group
} #>
<# Variables: {      
    :NewAzureNSGRule            Outer loop for managing function
    :ConfirmRule                Inner loop for confirming all settings on new rule
    $CallingFunction:           Name of this function or the one that called it
    $NSGObject:                 Network security group object
    $ObjectArray:               Array holding all info on existing rules on $NSGObject
    $CRules:                    List of all rules on $NSGObject
    $Direction:                 Current item .Direction
    $Priority:                  Current item .Priority
    $DirPri:                    Combination of $Direction and $Priority
    $ObjectInput:               $var used to load into into $ObjectArray
    $VName1st:                  Array of NSG rule name 1st characters
    $VNameElse:                 Array of NSG rule name body characters
    $VNameLast:                 Array of NSG rule name last characters
    $NSGRuleName:               Operator input for the NSG rule name
    $NSGNameArray:              $NSGRuleName converted to array
    $OpConfirm:                 Operator confirmation of values
    $NSGRuleProtocol:           NSG rule protocol
    $NSGRuleAccess:             NSG rule access
    $NSGRuleDirection:          NSG rule direction
    $NSGRulePriority:           NSG rule priority
    $NSGRuleSPRange:            NSG rule source port range
    $NSGRuleDPRange:            NSG rule destination port range
    NSGRuleAddPrefix:           NSG rule address prefix
    $NSGRuleSAPrefix:           NSG rule source address prefix
    $ASGObject:                 Application security group object
    $NSGRuleSAppSecG:           Source spplication security group object
    $NSGRuleDAPrefix:           NSG rule destination address prefix
    $NSGRuleDAppSecG:           Destination spplication security group object
    GetAzNSG{}                  Gets $NSGObject
    SetAzNSGRuleProtocol{}      Gets $NSGRuleProtocol
    SetAzNSGRuleAccess{}        Gets $NSGRuleAccess
    SetAzNSGRuleDirection{}     Gets $NSGRuleDirection
    SetAzNSGRulePriority{}      Gets $NSGRulePriority
    SetAzNSGRuleSPortRange{}    Gets $NSGRuleSPRange
    SetAzNSGRuleDPortRange{}    Gets $NSGRuleDPRange
    SetAzNSGRuleAddPrefix{}     Gets $NSGRuleAddPrefix
        SetIPAddress{}              Gets $IPAddress
        SetCIDRAddress{}            Gets $CIDRAddress
    GetAzASG{}                  Gets $ASGObject
} #>
<# Process Flow {
    function
        Call NewAzNSGRule > Get $null
            Call GetAzNSG > Get $NSGObject
            End GetAzNSG
                Return NewAzNSGRule > Send $NSGObject
            Call SetAzNSGRuleProtocol > Get $NSGRuleProtocol
            End SetAzNSGRuleProtocol
                Return NewAzNSGRule > Send $NSGRuleProtocol
            Call SetAzNSGRuleAccess > Get $NSGRuleAccess
            End SetAzNSGRuleAccess
                Return NewAzNSGRule > Send $NSGRuleAccess
            Call SetAzNSGRuleDirection > Get $NSGRuleDirection
            End SetAzNSGRuleDirection
                Return NewAzNSGRule > Send $NSGRuleDirection
            SetAzNSGRulePriority > Get $NSGRulePriority
            End SetAzNSGRulePriority
                Return NewAzNSGRule > Send $NSGRulePriority
            Call SetAzNSGRuleSPortRange > Get $NSGRuleSPRange
            End SetAzNSGRuleSPortRange
                Return NewAzNSGRule > Send $NSGRuleSPRange
            Call SetAzNSGRuleDPortRange > Get $NSGRuleDPRange
            End SetAzNSGRuleDPortRange
                Return NewAzNSGRule > Send $NSGRuleDPRange
            Call SetAzNSGRuleAddPrefix > Get $NSGRuleAddPrefix
                Call SetIPAddress > Get $IPAddress
                End SetIPAddress
                    Return SetAzNSGRuleAddPrefix > Send $IPAddress
                Call SetCIDRAddress > Get $CIDRAddress
                End SetCIDRAddress
                    Return SetAzNSGRuleAddPrefix > Send $CIDRAddress
            End SetAzNSGRuleAddPrefix
                Return NewAzNSGRule > Send $NSGRuleAddPrefix
            Call GetAzASG > Get $ASGObject
            End GetAzASG
                Return NewAzNSGRule > Send $ASGObject                
        End NewAzNSGRule
            Return function > Send $null
}#>
function NewAzNSGRule {                                                                     # Function to create a new network security group rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNSGRule'                                               # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureNSGRuleName while ($true) {                                            # Inner loop to set the rule name
                Write-Host 'NSG name must be between 1 and 80 characters'                   # Write message to screen
                Write-Host 'NSG name must begin with a letter or number'                    # Write message to screen
                Write-Host 'NSG name must end with a letter, number, or -'                  # Write message to screen
                Write-Host 'NSG name body must be a letter, number, or _ . -'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                if ($CRules) {                                                              # If $CRules has a value
                    Write-Host 'The following names are already in use on:'$NSGObject.Name  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CRules) {                                               # For each item in $CRules
                        Write-Host $_.name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $CRules)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CRules)
                Write-Host 'Enter the name of the new network security group rule'          # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                $NSGRuleName = Read-Host 'Name'                                             # Operator input for the NSG rule name
                Clear-Host                                                                  # Clears screen
                $NSGNameArray = $NSGRuleName.ToCharArray()                                  # Converts $NSGRuleName to array
                if ($NSGRuleName -in $CRules.Name) {                                        # If $NSGRuleName is in $CRules.Name
                    Write-Host $NSGRuleName' is already in use'                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGRuleName -in $CRules.Name)
                if ($NSGRuleName.Length -lt 1 -or $NSGRuleName.Length -gt 80) {             # If $NSGRuleName.Length less than 1 or $NSGRuleName.Length greater than 80
                    Write-Host 'NSG name must be between 1 and 80 characters'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGRuleName.Length -lt 1 -or $NSGRuleName.Length -gt 80)
                if ($NSGNameArray[0] -notin $VName1st) {                                    # If 0 position of $NSGNameArray is not in $VName1st
                    Write-Host  $NSGNameArray[0]' is not a valid start character'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGNameArray[0] -notin $VName1st)
                foreach ($_ in $NSGNameArray) {                                             # For each item in $NSGNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'NSG name cannot include any spaces'                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid body character'                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NSGRuleName = $null                                                # Clears $NSGRuleName
                    }                                                                       # End if ($_ -notin $VNameElse)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NSGNameArray[-1] -notin $VNameLast) {                                  # If last position of $NSGNameArray is not in $VNameLast
                    Write-Host  $NSGNameArray[-1]' is not a valid end character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGNameArray[-1] -notin $VNameLast)
                $NSGNameArray = $null                                                       # Clears $NSGNameArray
                if ($NSGRuleName) {                                                         # If $NSGRuleName has a value
                    Write-Host 'Use:'$NSGRuleName' as the NSG rule name'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the network security group name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureNSGRuleName                                           # Breaks :SetAzureNSGRuleName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureNSGRule                                               # Breaks :NewAzureNSGRule
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($NSGRuleName)
                else {                                                                      # Else if $NSGRuleName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NSGRuleName))
            }                                                                               # End :SetAzureNSGRuleName while ($true)
            $NSGRuleProtocol = SetAzNSGRuleProtocol                                         # Calls function and assigns output to $var
            if (!$NSGRuleProtocol) {                                                        # If $NSGRuleProtocol is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule    
            }                                                                               # End if (!$NSGRuleProtocol)
            $NSGRuleAccess = SetAzNSGRuleAccess                                             # Calls function and assigns output to $var
            if (!$NSGRuleAccess) {                                                          # If $NSGRuleAccess is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule    
            }                                                                               # End if (!$NSGRuleAccess)
            $NSGRuleDirection = SetAzNSGRuleDirection                                       # Calls function and assigns output to $var
            if (!$NSGRuleDirection) {                                                       # If $NSGRuleDirection is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleDirection)            
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            $NSGRulePriority = SetAzNSGRulePriority ($NSGObject, $NSGRuleDirection, $CRules)# Calls function and assigns output to $var
            if (!$NSGRulePriority) {                                                        # If NSGRulePriority is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                    
            }                                                                               # End if (!$NSGRulePriority)
            $NSGRuleSPRange = SetAzNSGRuleSPortRange                                        # Calls function and assigns output to $var
            if (!$NSGRuleSPRange) {                                                         # If $NSGRuleSPRange is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleSPRange)
            $NSGRuleDPRange = SetAzNSGRuleDPortRange                                        # Calls function and assigns output to $var
            if (!$NSGRuleDPRange) {                                                         # If $NSGRuleDPRange is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleDPRange)
            :SetNSGRuleSourceAdd while ($true) {                                            # Inner loop for setting the rule source config
                Write-Host 'Rule source config'                                             # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Address prefix'                                             # Write message to screen
                Write-Host '[2] App Sec Group'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the source type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if ($OpSelect equals '1'
                    $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)            # Calls function and assigns output to $var
                    if ($NSGRuleAddPrefix) {                                                # If $NSGRuleAddPrefix has a value                          
                        $NSGRuleSAPrefix = $NSGRuleAddPrefix                                # $NSGRuleSAPrefix is equal to $NSGRuleAddPrefix 
                        $NSGRuleAddPrefix = $null                                           # Clears $var
                        Break SetNSGRuleSourceAdd                                           # Breaks :SetNSGRuleSourceAdd           
                    }                                                                       # End if ($NSGRuleAddPrefix)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $ASGObject = GetAzASG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($ASGObject) {                                                       # If $ASGObject has a value
                        $NSGRuleSAppSecG = $ASGObject                                       # $NSGRuleSAppSecG is equal to $ASGObject
                        $ASGObject = $null                                                  # Clears $var
                        Break SetNSGRuleSourceAdd                                           # Breaks :SetNSGRuleSourceAdd           
                    }                                                                       # End if ($ASGObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetNSGRuleSourceAdd while ($true)
            :SetNSGRuleDestinAdd while ($true) {                                            # Inner loop for setting the rule source config
                Write-Host 'Rule destination config'                                        # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Address prefix'                                             # Write message to screen
                Write-Host '[2] App Sec Group'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the source type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if ($OpSelect equals '1'
                    $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)            # Calls function and assigns output to $var
                    if ($NSGRuleAddPrefix) {                                                # If $NSGRuleAddPrefix has a value                          
                        $NSGRuleDAPrefix = $NSGRuleAddPrefix                                # $NSGRuleDAPrefix is equal to $NSGRuleAddPrefix 
                        Break SetNSGRuleDestinAdd                                           # Breaks :SetNSGRuleDestinAdd           
                    }                                                                       # End if ($NSGRuleAddPrefix)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $ASGObject = GetAzASG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($ASGObject) {                                                       # If $ASGObject has a value
                        $NSGRuleDAppSecG = $ASGObject                                       # $NSGRuleDAppSecG is equal to $ASGObject
                        Break SetNSGRuleDestinAdd                                           # Breaks :SetNSGRuleDestinAdd           
                    }                                                                       # End if ($ASGObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetNSGRuleDestinAdd while ($true)
            :ConfirmRule while ($true) {                                                    # Inner loop for confirming all inputs
                Write-Host 'Create the following rule:'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'NSG Name:         '$NSGObject.name                              # Write message to screen
                Write-Host 'Rule Name:        '$NSGRuleName                                 # Write message to screen
                Write-Host 'Protocol:         '$NSGRuleProtocol                             # Write message to screen
                Write-Host 'Access:           '$NSGRuleAccess                               # Write message to screen
                Write-Host 'Direction:        '$NSGRuleDirection                            # Write message to screen
                Write-Host 'Priority:         '$NSGRulePriority                             # Write message to screen
                Write-Host 'Source Config:'                                                 # Write message to screen
                Write-Host '  Port:           '$NSGRuleSPRange                              # Write message to screen
                if ($NSGRuleSAPrefix) {                                                     # If $NSGRuleSAPrefix has a value
                    Write-Host '  Address Prefix: '$NSGRuleSAPrefix                         # Write message to screen
                }                                                                           # End if ($NSGRuleSAPrefix)
                else {                                                                      # Esle if $NSGRuleSAPrefix is $null
                    Write-Host '  App Sec Group:  '$NSGRuleSAppSecG.name                    # Write message to screen    
                }                                                                           # End if ($NSGRuleSAPrefix)
                Write-Host 'Destination Config:'                                            # Write message to screen
                Write-Host '  Port:           '$NSGRuleDPRange                              # Write message to screen
                if ($NSGRuleDAPrefix) {                                                     # If $NSGRuleDAPrefix has a value
                    Write-Host '  Address Prefix: '$NSGRuleDAPrefix                         # Write message to screen
                }                                                                           # End if ($NSGRuleDAPrefix)
                else {                                                                      # Esle if $NSGRuleDAPrefix is $null
                    Write-Host '  App Sec Group:  '$NSGRuleDAppSecG.name                    # Write message to screen    
                }                                                                           # End if ($NSGRuleDAPrefix)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to build the rule
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break ConfirmRule                                                       # Breaks :ConfirmRule
                }                                                                           # End if ($OpConfirm -eq 'y') 
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y') )
            }                                                                               # End :ConfirmRule while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the NSG Rule'                                          # Write message to screen
                if ($NSGRuleSAPrefix -and $NSGRuleDAPrefix) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceAddressPrefix $NSGRuleSAPrefix `
                        -DestinationAddressPrefix $NSGRuleDAPrefix `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAPrefix -and $NSGRuleDAPrefix)
                if ($NSGRuleSAppSecG -and $NSGRuleDAPrefix) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceApplicationSecurityGroupId $NSGRuleSAppSecG.ID `
                        -DestinationAddressPrefix $NSGRuleDAPrefix `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAppSecG -and $NSGRuleDAPrefix)
                if ($NSGRuleSAPrefix -and $NSGRuleDAppSecG) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceAddressPrefix $NSGRuleSAPrefix `
                        -DestinationApplicationSecurityGroupId $NSGRuleDAppSecG.ID `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAPrefix -and $NSGRuleDAppSecG)
                if ($NSGRuleSAppSecG -and $NSGRuleDAppSecG) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceApplicationSecurityGroupId $NSGRuleSAppSecG.ID `
                        -DestinationApplicationSecurityGroupId $NSGRuleDAppSecG.ID `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAppSecG -and $NSGRuleDAppSecG)
                Write-Host 'Saving the network security group'                              # Write message to screen
                Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves NSG config
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'An the NSG rule has been created'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureNSGRule                                                           # Breaks :NewAzureNSGRule
        }                                                                                   # End :NewAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End NewAzNSGRule
Function SetAzNSGRuleProtocol {                                                             # Function to set a network security group rule protocol
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleProtocol while ($true) {                                            # Inner loop to set the rule protocol
            Write-Host 'Select the rule protocol'                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] TCP'                                                            # Write message to screen
            Write-Host '[3] UPD'                                                            # Write message to screen
            Write-Host '[4] ICMP'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule port
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleProtocol                                               # Breaks :SetAzureNSGRuleProtocol
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleProtocol = '*'                                                      # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleProtocol = 'TCP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleProtocol = 'UDP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                $NSGRuleProtocol = 'ICMP'                                                   # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleProtocol) {                                                         # If $NSGRuleProtocol has a value
                Return $NSGRuleProtocol                                                     # Returns to calling function with $NSGRuleProtocol
            }                                                                               # End if ($NSGRuleProtocol)
        }                                                                                   # End :SetAzureNSGRuleProtocol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRuleProtocol
Function SetAzNSGRuleAccess {                                                               # Function to set a network security group rule access
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleAccess while ($true) {                                              # Inner loop to set the rule access
            Write-Host 'Select the rule access'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Allow'                                                          # Write message to screen
            Write-Host '[2] Deny'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule access
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAccess                                                 # Breaks :SetAzureNSGRuleAccess
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAccess = 'Allow'                                                    # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleAccess = 'Deny'                                                     # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleAccess) {                                                           # If $NSGRuleAccess has a value
                Return $NSGRuleAccess                                                       # Returns to calling funtion with $NSGRuleAccess
            }                                                                               # End if ($NSGRuleAccess)
        }                                                                                   # End :SetAzureNSGRuleAccess while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleAccess
Function SetAzNSGRuleDirection {                                                            # Function to set a network security group rule direction
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleDirection while ($true) {                                           # Inner loop to set the rule direction
            Write-Host 'Select the rule direction'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Inbound'                                                        # Write message to screen
            Write-Host '[2] Outbound'                                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule direction
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleDirection                                              # Breaks :SetAzureNSGRuleDirection
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleDirection = 'Inbound'                                               # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleDirection = 'Outbound'                                              # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))   
            if ($NSGRuleDirection) {                                                        # If $NSGRuleDirection has a value
                Return $NSGRuleDirection                                                    # Returns to calling function with $NSGRuleDirection
            }                                                                               # End if ($NSGRuleDirection)
        }                                                                                   # End :SetAzureNSGRuleDirection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleDirection
Function SetAzNSGRulePriority {                                                             # Function to set a network security group rule priority
    Begin {                                                                                 # Begin function
        if (!$CRules) {                                                                     # If $CRules is $null
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array 
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
        }                                                                                   # End if (!$CRules)
        $ValidArray = '0123456789'                                                          # Creates a string of valid characters
        $ValidArray = $ValidArray.ToCharArray()                                             # Loads all valid characters into array    
        :SetAzureNSGRulePriority while ($true) {                                            # Inner loop to set the rule priority
            Write-Host 'NSG Rule priority'                                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule priority must be between the values of 100 and 4096'           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($CRules.Direction -eq $NSGRuleDirection) {                                  # If $CRules.Direction equals $NSGRuleDirection
                Write-Host 'The following priorities are'                                   # Write message to screen
                Write-Host 'already in use for'$NSGRuleDirection' traffic'                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $CRules) {                                                   # For each item in $CRules
                    if ($_.Direction -eq $NSGRuleDirection) {                               # If current item .Direction equals $NSGRuleDirection
                        Write-Host $_.Priority                                              # Write message to screen
                    }                                                                       # if ($_.Direction -eq $NSGRuleDirection)
                }                                                                           # End foreach ($_ in $CRules)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($CRules.Direction -eq $NSGRuleDirection)
            $NSGRulePriority = Read-Host 'Rule priority'                                    # Operator input for the rule priority
            Clear-Host                                                                      # Clears screen
            $NSGRuleArray = $NSGRulePriority.ToCharArray()                                  # Converts $NSGRulePriority into array
            foreach ($_ in $NSGRuleArray) {                                                 # For each item in $NSGRuleArray
                if ($_ -notin $ValidArray) {                                                # If current item is not in $ValidArray
                    $NSGRulePriority = $null                                                # Clears $var
                }                                                                           # End if ($_ -notin $ValidArray)
            }                                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
            $NSGRuleArray = $null                                                           # Clears $var
            $NSGRuleDirPri = $NSGRuleDirection+' '+$NSGRulePriority                         # $NSGRuleDirPri is equal to $NSGRuleDirection and $NSGRulePriority                     
            if ($NSGRuleDirPri -in $ObjectArray.DirPri) {                                   # If $NSGRuleDirPri is in $ObjectArray.DirPri
                Write-Host 'This priority is already in use for'$NSGRuleDirection           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please select a different priority'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $NSGRulePriority = $null                                                    # Clears $var
            }                                                                               # End if ($NSGRuleDirPri -in $ObjectArray.DirPri)
            $NSGRuleInt = [INT]$NSGRulePriority                                             # Converts $NSGRulePriority to integer
            if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096) {                             # if $NSGRuleInt is not between 100 and 4096
                Write-Host 'Rule priority must be between the values of 100 and 4096'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                $NSGRulePriority = $null                                                    # Clears $var
                $NSGRuleInt = $null                                                         # Clears $var
                $NSGRuleDirPri = $null                                                      # Clears $var
                Clear-Host                                                                  # Clears screen
            }                                                                               # End if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096)                                                                    
            else {                                                                          # Else if $NSGRuleInt is between 100 and 4096
                Write-Host 'Use:'$NSGRulePriority' as the rule priority'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the rule priority
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Return $NSGRulePriority                                                 # Returns to calling function with $NSGRulePriority
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'e')
                else {                                                                      # All other inputs for $OpConfirm
                    $NSGRulePriority = $null                                                # Clears $var
                    $NSGRuleInt = $null                                                     # Clears $var
                    $NSGRuleDirPri = $null                                                  # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096))
        }                                                                                   # End :SetAzureNSGRulePriority while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRulePriority
Function SetAzNSGRuleSPortRange {                                                           # Function to set a network security rule source port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleSPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule source port range
                Write-Host 'NSG Rule Source Port Range'                                     # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the source port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleSPRange                                            # Breaks :SetAzureNSGRuleSPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleSPRange = '*'                                                   # Sets $NSGRuleSPRange
                    Return $NSGRuleSPRange                                                  # Returns to calling function with $NSGRuleSPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single source port
                        Write-Host 'Enter the source port'                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleSPRange = Read-Host 'Port #'                                # Operator input for the source port number
                        $NSGRuleArray = $NSGRuleSPRange.ToCharArray()                       # Converts $NSGRuleSPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            $NSGInt = [INT]$NSGRuleSPRange                                  # Converts $NSGRuleSPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleSPRange)
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleSPRange' as the source port'           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the source port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleSPRange)
                        else {                                                              # Else if $NSGRuleSPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleSPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleSPList = @()                                                    # Creates $NSGRuleSPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple source ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the source port'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleSPAdd = Read-Host 'Port #'                              # Operator input for the source port number
                            $NSGRuleArray = $NSGRuleSPAdd.ToCharArray()                     # Converts $NSGRuleSPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                $NSGInt = [INT]$NSGRuleSPAdd                                # Converts $NSGRuleSPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleSPAdd)
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleSPAdd' to source port list'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleSPRange)
                            else {                                                          # Else if $NSGRuleSPRange is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleSPRange))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleSPList += $NSGRuleSPAdd                                     # Adds $NSGRuleSPAdd to $NSGRuleSPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule source ports
                            Write-Host 'Current source port list:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleSPList) {                                # For each item in $NSGRuleSPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleSPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleSPRange = $NSGRuleSPList                            # $NSGRuleSPRange is equal to $NSGRuleSPList 
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleSPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a source port range
                        :SetAzureNSGRSPortStart while ($true) {                             # Inner loop for settings a source port start
                            Write-Host 'Enter the source port range start '                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the source port range start
                            $NSGRuleArray = $SPRangeStart.ToCharArray()                     # Converts $SPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                $NSGInt = [INT]$SPRangeStart                                # Converts $SPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeStart)
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeStart' for source port range start' # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortStart                            # Breaks :SetAzureNSGRSPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeStart)
                            else {                                                          # Else if $SPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeStart))
                        }                                                                   # End :SetAzureNSGRSPortStart while ($true)
                        :SetAzureNSGRSPortEnd while ($true) {                               # Inner loop for settings a source port end
                            Write-Host 'Enter the source port range end '                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the source port range end
                            $NSGRuleArray = $SPRangeEnd.ToCharArray()                       # Converts $SPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                $NSGInt = [INT]$SPRangeEnd                                  # Converts $SPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeEnd)
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeEnd' for source port range end'     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortEnd                              # Breaks :SetAzureNSGRSPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeEnd)
                            else {                                                          # Else if $SPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeEnd))
                        }                                                                   # End :SetAzureNSGRSPortEnd while ($true)
                        $NSGRuleSPRange = $SPRangeStart+'-'+$SPRangeEnd                     # $NSGRuleSPRange is equal to5 $SPRangeStart and $SPRangeEnd       
                        Write-Host 'Use'$NSGRuleSPRange' as the source port range'          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the source port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleSPRange                                          # Returns to calling function with $NSGRuleSPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleSPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleSPortRange
Function SetAzNSGRuleDPortRange {                                                           # Function to set a network security rule destination port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleDPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule destination port range
                Write-Host 'NSG Rule Destination Port Range'                                # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the destination port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleDPRange                                            # Breaks :SetAzureNSGRuleDPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleDPRange = '*'                                                   # Sets $NSGRuleDPRange
                    Return $NSGRuleDPRange                                                  # Returns to calling function with $NSGRuleDPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single destination port
                        Write-Host 'Enter the destination port'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleDPRange = Read-Host 'Port #'                                # Operator input for the destination port number
                        $NSGRuleArray = $NSGRuleDPRange.ToCharArray()                       # Converts $NSGRuleDPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            $NSGInt = [INT]$NSGRuleDPRange                                  # Converts $NSGRuleDPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleDPRange)
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleDPRange' as the destination port'      # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the destination port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleDPRange)
                        else {                                                              # Else if $NSGRuleDPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleDPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleDPList = @()                                                    # Creates $NSGRuleDPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple destination ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the destination port'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleDPAdd = Read-Host 'Port #'                              # Operator input for the destination port number
                            $NSGRuleArray = $NSGRuleDPAdd.ToCharArray()                     # Converts $NSGRuleDPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                $NSGInt = [INT]$NSGRuleDPAdd                                # Converts $NSGRuleDPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleDPAdd)
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleDPAdd' to destination port list'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleDPAdd)
                            else {                                                          # Else if $NSGRuleDPAdd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPAdd))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleDPList += $NSGRuleDPAdd                                     # Adds $NSGRuleDPAdd to $NSGRuleDPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule destination ports
                            Write-Host 'Current destination port list:'                     # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleDPList) {                                # For each item in $NSGRuleDPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleDPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleDPRange = $NSGRuleDPList                            # $NSGRuleDPRange is equal to $NSGRuleDPList 
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleDPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a destination port range
                        :SetAzureNSGRDPortStart while ($true) {                             # Inner loop for settings a destination port start
                            Write-Host 'Enter the destination port range start '            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the destination port range start
                            $NSGRuleArray = $DPRangeStart.ToCharArray()                     # Converts $DPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                $NSGInt = [INT]$DPRangeStart                                # Converts $DPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeStart)
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeStart' for destination port range start'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortStart                            # Breaks :SetAzureNSGRDPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeStart)
                            else {                                                          # Else if $DPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPRange))
                        }                                                                   # End :SetAzureNSGRDPortStart while ($true)
                        :SetAzureNSGRDPortEnd while ($true) {                               # Inner loop for settings a destination port end
                            Write-Host 'Enter the destination port range end '              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the destination port range end
                            $NSGRuleArray = $DPRangeEnd.ToCharArray()                       # Converts $DPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                $NSGInt = [INT]$DPRangeEnd                                  # Converts $DPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeEnd)
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeEnd' for destination port range end'       # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortEnd                              # Breaks :SetAzureNSGRDPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeEnd)
                            else {                                                          # Else if $DPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($DPRangeEnd))
                        }                                                                   # End :SetAzureNSGRDPortEnd while ($true)
                        $NSGRuleDPRange = $DPRangeStart+'-'+$DPRangeEnd                     # $NSGRuleDPRange is equal to5 $DPRangeStart and $DPRangeEnd       
                        Write-Host 'Use'$NSGRuleDPRange' as the destination port range'     # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the destination port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleDPRange                                          # Returns to calling function with $NSGRuleDPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleDPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleDPortRange
function GetAzNSG {                                                                         # Function to get a network security group
    Begin {                                                                                 # Begin function
        :GetAzureNSG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSG                                                           # Breaks :GetAzureNSG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'DrulesCount'=$_.DefaultSecurityRules.Count                             # Default security rules count
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureNSG while ($true) {                                                 # Inner loop for selecting the network security group
                Write-Host '[0]                  Exit'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                 "$_.Name                      # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]                "$_.Name                       # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:            '$_.RG                                  # Write message to screen
                    Write-Host 'Rule Loc:           '$_.Location                            # Write message to screen
                    Write-Host 'Sec Rules Count:    '$_.SrulesCount                         # Write message to screen
                    Write-Host 'Default Rules Count:'$_.DRulesCount                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the network security group for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the network security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNSG                                                       # Breaks :GetAzureNSG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full network security group object
                    Return $NSGObject                                                       # Returns to calling function with network security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureNSG while ($true)
        }                                                                                   # End :GetAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzNSG
Function SetAzNSGRuleAddPrefix {                                                            # Function to set a network security rule address prefix
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleAddPrefix while ($true) {                                           # Outer loop for managing function
            Write-Host 'NSG Rule Address Prefix'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] Single IP Address'                                              # Write message to screen
            Write-Host '[3] Multiple IP Addresses'                                          # Write message to screen
            Write-Host '[4] CIDR Block'                                                     # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the address prefix method
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAddPrefix                                              # Breaks :SetAzureNSGRuleAddPrefix
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAddPrefix = '*'                                                     # Sets $NSGRuleAddPrefix
                Return $NSGRuleAddPrefix                                                    # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for settings a single IP address prefix
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$IPAddress) {                                                      # If $IPAddress does not have a value
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$IPAddress)
                    else {                                                                  # If $IPAddress has a value
                        $NSGRuleAddPrefix = $IPAddress                                      # $NSGRuleAddPrefix is equal to $IPAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$IPAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleAddPrefix = @()                                                     # Creates $NSGRuleAddPrefix        
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for setting multiple address prefix values
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if ($IPAddress) {                                                       # If $IPAddress haa a value
                        Clear-Host                                                          # Clears screen
                        Write-Host 'Add:'$IPAddress' Address prefix list'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the address
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpSelect -eq 'y'
                            $NSGRuleAddPrefix += $IPAddress                                 # Adds $IPAddres to $NSGRuleAddPrefix
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpSelect -eq 'e'
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpConfirm -eq 'e')    
                    }                                                                       # End if ($IPAddress)
                    :ConfirmAddressPrefixList while ($true) {                               # Inner loop for confirming the IP address list
                        Write-Host 'Current IP addres prefix list'                          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        foreach ($_ in $NSGRuleAddPrefix) {                                 # For each item in $NSGRuleAddPrefix
                            Write-Host $_                                                   # Write message to screen
                        }                                                                   # End foreach ($_ in $NSGRuleAddPrefix)
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Add another IP address'                                 # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                     # Operator input to add another IP
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            Break ConfirmAddressPrefixList                                  # Breaks :ConfirmAddressPrefixList
                        }                                                                   # End if ($OpSelect -eq 'y')
                        elseif ($OpSelect -eq 'n') {                                        # Else if $OpSelect equals 'n'
                            Return $NSGRuleAddPrefix                                        # Returns to calling function with $var
                        }                                                                   # End elseif ($OpSelect -eq 'n')   
                        elseif ($OpSelect -eq 'e') {                                        # Else if $OpSelect equals 'e'        
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpSelect -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End :ConfirmAddressPrefixList while ($true)
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for getting a CIDR address
                $CIDRAddress = SetCIDRAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$CIDRAddress) {                                                    # If $CIDRAddress is $null
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$CIDRAddress)
                    else {                                                                  # If $CIDRAddress has a value
                        $NSGRuleAddPrefix = $CIDRAddress                                    # $NSGRuleAddPrefix is equal to $CIDRAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$CIDRAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :SetAzureNSGRuleAddPrefix while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleAddPrefix
function SetIPAddress {                                                                     # Function to add an IP address to $var
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContine'                                          # Turns off error reporting
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetIPAddressLoop while ($true) {                                                   # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-Host 'You are setting the IP for:'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            Write-Host 'Enter the IP address (Must be x.x.x.x)'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $IPAddress = Read-Host 'IP Address'                                             # Operator input for the starting IP address
            Clear-Host                                                                      # Clears screen
            if ($IPAddress -notlike '*.*.*.*') {                                            # If $IPAddress is not like '*.*.*.*'
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = $null                                                          # Clears $var
            }                                                                               # End if ($IPAddress -notlike '*.*.*.*') 
            if ($IPAddress) {                                                               # If $IPAddress has a value
                if ($IPAddress.Split('.')[4]) {                                             # If $IPAddress .Split 4th position has a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress.Split('.')[4])
            }                                                                               # End  if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $IPAddressArray = $IPAddress.ToCharArray()                                  # Converts $IPAddress to array
                foreach ($_ in $IPAddressArray) {                                           # For each item in $IPAddressArray
                    if ($_ -notin $ValidArray) {                                            # If current item not in $ValidArray
                        Write-Host $_' is not a valid character'                            # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $IPAddressArray)
                $IPAddressArray = $null                                                     # Clears $var
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $OctetCheck = $IPAddress.Split('.')                                         # $OctetCheck is equal to $IPAdress.Split '.'
                foreach ($_ in $OctetCheck) {                                               # For each item in $OctetCheck
                    $OctetInt = [INT]$_                                                     # $OctetInt is equal to current item converted to integer
                    if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                            # If $OctetInt less than 0 or  $OctetInt greater than 255
                        Write-Host $_' is not a valid octet'                                # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                    $OctetInt = $null                                                       # Clears $var
                }                                                                           # End foreach ($_ in $OctetCheck)
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                Write-Host 'Use'$IPAddress' as the IP'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP address
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break SetIPAddressLoop                                                  # Breaks :SetIPAddressLoop
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Return $IPAddress                                                       # Returns to calling function with $var  
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End if ($IPAddress)
            else {                                                                          # If $IPAddress is $null
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($IPAddress))
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetIPAddress
function SetCIDRAddress {                                                                   # Function to add a CIDR address to $var
    Begin {                                                                                 # Begin function
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetCIDRAddressLoop while ($true) {                                                 # Outer loop for managing function
            :SetIPAddress while ($true) {                                                   # Inner loop for setting the starting IP
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are setting the IP for:'$CallingFunction                # Write message to screen
                }                                                                           # End if ($CallingFunction)
                Write-Host 'Enter the starting IP address (Must be x.x.x.0)'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = Read-Host 'IP Address'                                         # Operator input for the starting IP address
                Clear-Host                                                                  # Clears screen
                if ($IPAddress -notlike '*.*.*.0') {                                        # If $IPAddress is not like '*.*.*.0'
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress -notlike '*.*.*.0') 
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    if ($IPAddress.Split('.')[4]) {                                         # If $IPAddress .Split 4th position has a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($IPAddress.Split('.')[4])
                }                                                                           # End  if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $IPAddressArray = $IPAddress.ToCharArray()                              # Converts $IPAddress to array
                    foreach ($_ in $IPAddressArray) {                                       # For each item in $IPAddressArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $IPAddressArray)
                    $IPAddressArray = $null                                                 # Clears $var
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $OctetCheck = $IPAddress.Split('.')                                     # $OctetCheck is equal to $IPAdress.Split '.'
                    foreach ($_ in $OctetCheck) {                                           # For each item in $OctetCheck
                        $OctetInt = [INT]$_                                                 # $OctetInt is equal to current item converted to integer
                        if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                        # If $OctetInt less than 0 or  $OctetInt greater than 255
                            Write-Host $_' is not a valid octet'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                        $OctetInt = $null                                                   # Clears $var
                    }                                                                       # End foreach ($_ in $OctetCheck)
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    Write-Host 'Use'$IPAddress' as the starting IP'                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetIPAddress                                                  # Breaks :SetIPAddress  
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($IPAddress)
                else {                                                                      # If $IPAddress is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($IPAddress))
            }                                                                               # End :SetIPAddress while ($true) 
            $ValidArray = '0123456789'                                                      # Creates $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to array
            :SetCIDRBlock while ($true) {                                                   # Inner loop for setting the CIDR block
                Write-Host 'Enter the CIDR Block (0-32)'                                    # Write message to screen
                Write-Host  ''                                                              # Write message to screen
                $CIDRBlock = Read-Host 'CIDR Block'                                         # Operator input for the CIDR block
                Clear-Host                                                                  # Clears screen
                $CIDRBlockArray = $CIDRBlock.ToCharArray()                                  # Converts $CIDRBlock to array
                foreach ($_ in $CIDRBlockArray) {                                           # For each item in $CIDRBlockArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $CIDRBlockArray)
                $CIDRBlockArray = $null                                                     # Clears $var
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    $CIDRBlockInt = [INT]$CIDRBlock                                         # Converts $CIDRBlock to integer
                    if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32) {                     # If $CIDRBlockInt is less than 0 or greater than 32)
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32)
                    $CIDRBlockInt = $null                                                   # Clears $var
                }                                                                           # End if ($CIDRBlock)
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    Write-Host 'Use'$CIDRBlock' as the CIDR block'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the CIDR block
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        $CIDRAddress = $IPAddress+'/'+$CIDRBlock                            # $CIDRAddress is equal to $IPAddress and $CIDRBlock
                        Return $CIDRAddress                                                 # Returns to calling function with $var
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($CIDRBlock)
                else {                                                                      # Else if $CIDRBlock is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($CIDRBlock))
            }                                                                               # End :SetCIDRBlock while ($true)
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetCIDRAddress
function GetAzASG {                                                                         # Function to get an application security group
    Begin {                                                                                 # Begin function
        :GetAzureASG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering application security group info'                          # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzApplicationSecurityGroup                                    # Gets a list of all application security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureASG                                                           # Breaks :GetAzureASG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGID = $_.ID                                                              # $ASGID is equal to current item .ID
                $NICList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGID}           # Gets a list of nics in $ASGID
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NICCount'=$NICList.Count                                               # Count of nic associated to the current application security group
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureASG while ($true) {                                                 # Inner loop for selecting the application security group
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:        '$_.RG                                      # Write message to screen
                    Write-Host 'Rule Loc:       '$_.Location                                # Write message to screen
                    if ($_.NicCount) {                                                      # If $NicCount has a value
                        Write-Host 'Associated NICS:'$_.NICCount                            # Write message to screen
                    }                                                                       # End if ($_.NicCount)
                    else {                                                                  # Else if $NicCount is $null
                        Write-Host 'Associated NICS: N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.NicCount))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the app security group for:'$CallingFunction     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the application security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureASG                                                       # Breaks :GetAzureASG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $ASGObject = Get-AzApplicationSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full application security group object
                    Return $ASGObject                                                       # Returns to calling function with application security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureASG while ($true)
        }                                                                                   # End :GetAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzASG