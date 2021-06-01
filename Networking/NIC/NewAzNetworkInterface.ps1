# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    NewAzNetworkInterface:      Creates a new network interface
    GetAzResourceGroup:         Gets an azure resource group
    GetAzLocation:              Gets an azure location
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
} #>
<# Variables: {
    :NewAzureNIC                Outer loop for managing function
    :SetAzureNicName            Inner loop for setting the Nic name
    $CallingFunction:           Name of this function
    $RGObject:                  Resource group object
    $LocationObject:            Azure location object
    $SubnetObject:              The subnet object
    $NicName:                   Operator input for name of $NicObject
    $OpConfirm:                 Operator confirmation of the nic name
    $OpSelect:                  Operator input for returning with $NICObject
    $NicObject:                 Network interface object
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
    GetAzVNetSubnetConfig{}     Gets $SubnetObject
} #>
<# Process Flow {
    Function
        Call NewAzNetworkInterface > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzNetworkInterface > Send $RGObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzNetworkInterface > Send $LocationObject
            Call GetAzVNetSubnetConfig > Get $SubnetObject
            End GetAzVNetSubnetConfig
                Return NewAzNetworkInterface > Send $SubnetObject
            End NewAzNetworkInterface
                Return function > Send $null
}#>
function NewAzNetworkInterface {                                                            # Creates a new network interface
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNetworkInterface'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNIC while ($true) {                                                        # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureNIC                                                       # Breaks :NewAzureNIC
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject is $null
                    Break NewAzureNIC                                                       # Breaks :NewAzureNIC
                }                                                                           # End if (!$LocationObject)
            }                                                                               # End if (!$LocationObject)
            $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)           # Calls function and assigns output to $var
            if ($SubnetObject) {                                                            # If $SubnetObject has a value
                Break GetAzureSubNet                                                        # End Break GetAzureSubNet
            }                                                                               # End if ($SubnetObject)
            :SetAzureNicName while ($true) {                                                # Inner loop for setting the nic name
                Write-Host 'Provide a name for the new NIC'                                 # Write message to screen
                $NicName = Read-Host 'NIC name'                                             # Operator input for the nic name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$NicName' as the NIC name'                                 # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                    Break SetAzureNicName                                                   # Breaks :SetAzureNicName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureNicName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating NIC'                                                   # Write message to screen
                $NICObject = New-AzNetworkInterface -Name $NicName -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $LocationObject.location `
                    -Subnet $SubnetObject  -ErrorAction 'Stop'                              # Creates the object and assigns to $var
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write mesage to screen
                Write-Host 'You may not have permissions to create this object'             # Write mesage to screen
                Write-Host 'The resource group maybe locked'                                # Write mesage to screen
                Write-Host 'The name provided may not be valid'                             # Write mesage to screen
                Pause                                                                       # Pauses all action for operator input
                Break NewAzureNIC                                                           # Breaks :NewAzureNIC
            }                                                                               # End Catch
            Write-Host 'NIC has been created'                                               # Write mesage to screen
            if ($CallingFunction -and $CallingFunction -ne 'NewAzNetworkInterface') {       # If $CallingFunction has a value and not equal to 'NewAzNetworkInterface'
                Write-Host 'Return to calling function with $NicObject'                     # Write message to screen
                $OpSelect = Read-Host '[Y] Yes [N] No'                                      # Operator input to return with values
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq 'y') {                                                    # If $OpSelect equals 'y'
                    Return $NICObject, $SubnetObject, $VNetObject                           # Returns $vars to calling function
                }                                                                           # End if ($OpSelect -eq 'y')
                else {                                                                      # All other inputs for $OpSelect
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End else (if ($OpSelect -eq 'y'))
            }                                                                               # End if ($CallingFunction -and $CallingFunction -ne 'NewAzNetworkInterface')
            Break NewAzureNic                                                               # Breaks :NewAzureNic
        }                                                                                   # End :NewAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End funciton NewAzNetworkInterface