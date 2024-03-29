# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Resize-AzVirtualNetworkGateway:             https://docs.microsoft.com/en-us/powershell/module/az.network/resize-azvirtualnetworkgateway?view=azps-6.3.0
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-6.3.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-6.3.0
    Add-AzVirtualNetworkGatewayIpConfig:        https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworkgatewayipconfig?view=azps-6.3.0
    Remove-AzVirtualNetworkGatewayIpConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworkgatewayipconfig?view=azps-6.3.0
    Set-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    ResizeAzVNGateway:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/Gateway%20Configs/ResizeAzVNGateway.ps1
    SetAzVNGatewayAA:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/Gateway%20Configs/SetAzVNGatewayAA.ps1
    GetAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/GetAzVNGateway.ps1
    NewAzVNGatewayIPcon:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/NewAzVNGatewayIPcon.ps1
} #>
<# Functions Description: {
    ResizeAzVNGateway:          Function to resize a gateway
    SetAzVNGatewayAA:           Function to enable or diable active-active
    GetAzVNGateway:             Function to get a virtual network gateway
    NewAzVNGatewayIPcon:        Function to create a new gateway ip configuration
} #>
<# Variables: {      
    :ManageAzureGateway         Outer loop for managing function
    $OpSelect:                  Operator input for selecting management function
    ResizeAzVNGateway{}         Updates $GatewayObject
        GetAzVNGateway{}            Gets $GatewayObject
    SetAzVNGatewayAA {}         Updates $GatewayObject
        GetAzVNGateway{}            Gets $GatewayObject
        NewAzVNGatewayIPcon{}       Gets $GatewayIPConfig
} #>
<# Process Flow {
    function
        Call ManageAzVNGWConfig > Get $null
            Call ResizeAzVNGateway > Get $null
                Call GetAzVNGateway > Get $GatewayObject            
                End GetAzVNGateway
                    Return ResizeAzVNGateway > Send $GatewayObject
            End ResizeAzVNGateway
                Return ManageAzVNGWConfig > Send $null
            Call SetAzVNGatewayAA > Get $null
                Call GetAzVNGateway > Get $GatewayObject            
                End GetAzVNGateway
                    Return SetAzVNGatewayAA > Send $GatewayObject
                Call NewAzVNGatewayIPcon >  Get $GatewayIPConfig
                End NewAzVNGatewayIPcon
                    Return SetAzVNGatewayAA > Send $GatewayIPConfig
            End SetAzVNGatewayAA
                Return ManageAzVNGWConfig > Send $null   
        End ManageAzVNGWConfig
            Return function > Send $null         
}#>
function ManageAzVNGWConfig {                                                               # Function to manage virtual network gateway configs
    Begin {                                                                                 # Begin function
        :ManageAzureGateway while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Gateway Configs'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Resize Gateway'                                                 # Write message to screen
            Write-Host '[2] Update Gateway Active-Active'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureGateway                                                    # Breaks :ManageAzureGateway
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Resize Gateway'                                                 # Write message to screen
                ResizeAzVNGateway                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Update Gateway Active-Active'                                   # Write message to screen
                SetAzVNGatewayAA                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')  
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNGWConfig
function ResizeAzVNGateway {                                                                # Function to resize a gateway
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'ResizeAzVNGateway'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ResizeAzureVNGateway while ($true) {                                               # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject is $null
                Break ResizeAzureVNGateway                                                  # Breaks :ResizeAzureVNGateway
            }                                                                               # End if (!$GatewayObject)
            :SetAzureVNGatewaySku while ($true) {                                           # Inner loop to set the gateway sku
                Write-Host 'Gateway VPN Generation:'$GatewayObject.VpnGatewayGeneration     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($GatewayObject.VpnGatewayGeneration -eq 'Generation1') {                # If $GatewayObject.VpnGatewayGeneration equals 'Generation1'
                    Write-Host 'New Gateway Sku'                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen                
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] VpnGw1'                                                 # Write message to screen
                    Write-Host '[2] VpnGw2'                                                 # Write message to screen
                    Write-Host '[3] VpnGw3'                                                 # Write message to screen
                    Write-Host '[4] VpnGw4 (Not Available)'                                 # Write message to screen
                    Write-Host '[5] VpnGw5 (Not Available)'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input to select new sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break ResizeAzureVNGateway                                          # Breaks :ResizeAzureVNGateway
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Else if $OpSelect -eq '1'
                        $GatewaySku = 'VpnGw1'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect -eq '2'
                        $GatewaySku = 'VpnGw2'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    elseif ($OpSelect -eq '3') {                                            # Else if $OpSelect -eq '3'
                        $GatewaySku = 'VpnGw3'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '3')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen 
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End if ($GatewayObject.VpnGatewayGeneration -eq 'Generation1')
                else {                                                                      # Else if $GatewayObject.VpnGatewayGeneration does not equal 'Generation1'
                    Write-Host 'New Gateway Sku'                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen                
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] VpnGw1 (Not Available)'                                 # Write message to screen
                    Write-Host '[2] VpnGw2'                                                 # Write message to screen
                    Write-Host '[3] VpnGw3'                                                 # Write message to screen
                    Write-Host '[4] VpnGw4'                                                 # Write message to screen
                    Write-Host '[5] VpnGw5'                                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input to select new sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break ResizeAzureVNGateway                                          # Breaks :ResizeAzureVNGateway
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect -eq '2'
                        $GatewaySku = 'VpnGw2'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    elseif ($OpSelect -eq '3') {                                            # Else if $OpSelect -eq '3'
                        $GatewaySku = 'VpnGw3'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '3')
                    elseif ($OpSelect -eq '4') {                                            # Else if $OpSelect -eq '4'
                        $GatewaySku = 'VpnGw4'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '4')
                    elseif ($OpSelect -eq '5') {                                            # Else if $OpSelect -eq '5'
                        $GatewaySku = 'VpnGw5'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '5')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen 
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End else (if ($GatewayObject.VpnGatewayGeneration -eq 'Generation1'))
                if ($GatewaySku) {                                                          # If $GatewaySku has a value
                    if ($GatewaySku -eq $GatewayObject.Sku.Name) {                          # If $GatewaySku equals $GatewayObject.Sku.Name
                        Write-Host 'The selected sku is already set'                        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ResizeAzureVNGateway                                          # Breaks :ResizeAzureVNGateway
                    }                                                                       # End if ($GatewaySku -eq $GatewayObject.Sku.Name)
                    Break SetAzureVNGatewaySku                                              # Breaks :SetAzureVNGatewaySku
                }                                                                           # End if ($GatewaySku)
            }                                                                               # End :SetAzureVNGatewaySku while ($true)
            :Confirm while ($true) {                                                        # Inner loop to confirm the changes
                Write-Host 'Make the following changes'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Gateway Name:    '$GatewayObject.Name                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Current Sku Name:'$GatewayObject.Sku.Name                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'New Sku Name:    '$GatewaySku                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to make this change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break ResizeAzureVNGateway                                              # Breaks :ResizeAzureVNGateway
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Resizing the gateway sku'                                       # Write message to screen
                Resize-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                    -GatewaySku $GatewaySku -ErrorAction 'Stop' | Out-Null                  # Resizes the gateway
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ResizeAzureVNGateway                                                  # Breaks :ResizeAzureVNGateway    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway has been resized'                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ResizeAzureVNGateway                                                      # Breaks :ResizeAzureVNGateway    
        }                                                                                   # End :ResizeAzureVNGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ResizeAzVNGateway
function SetAzVNGatewayAA {                                                                 # Function to enable or diable active-active
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzVNGatewayAA'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureVNGateway while ($true) {                                                  # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject is $null
                Break SetAzureVNGateway                                                     # Breaks :SetAzureVNGateway
            }                                                                               # End if (!$GatewayObject)
            if ($GatewayObject.IPConfigurations.count -eq '1' -and `
                $GatewayObject.ActiveActive -eq $false) {                                   # If $GatewayObject.IPConfigurations.count equals '1' and $GatewayObject.ActiveActive equals $false
                $GatewaySku = $GatewayObject.Sku.Name                                       # $GatewaySku is equal to $GatewayObject.Sku.Name
                if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or `
                    'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') {                      # If $GatewaySku equals  'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3Az' -or 'HighPerformance'
                    $GatewayIPConfigPri = $GatewayObject.IPConfigurations[0]                # $GatewayIPConfigPri is equal to $GatewayObject.IPConfigurations[0]
                    $RGObject = $GatewayIPConfigPri.Subnet.ID.Split('/')[4]                 # Isolates the resource group name
                    $VnetObject = $GatewayIPConfigPri.Subnet.ID.Split('/')[8]               # Isolates the Vnet name
                    $VnetObject = Get-AzVirtualNetwork -Name $VnetObject `
                        -ResourceGroupName $RGObject                                        # Pulls the full virtual network object
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' `
                        -VirtualNetwork $VnetObject                                         # Pulls the full subnet object    
                    :SetAzureGWActiveActive while ($true) {                                 # Inner loop for configuring an Active-Active gateway config
                        $GatewayIPConfig = NewAzVNGatewayIPcon ($SubnetObject, $GatewaySku) # Calls function and assigns output to $var
                        if (!$GatewayIPConfig) {                                            # If $GatewayIPConfig is $null
                            Break SetAzureVNGateway
                        }                                                                   # End if (!$GatewayIPConfig) 
                        if ($GatewayIPConfig) {                                             # If $GatewayIPConfig has a value
                            if ($GatewayIPConfig.Name -eq $GatewayIPConfigPri.Name) {       # If $GatewayIPConfig.Name equals $GatewayIPConfigPri
                                Write-Host 'Invalid configuration on secondary config'      # Write message to screen   
                                Write-Host 'Please use a different name for the IP config'  # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                $GatewayIPConfig = $null                                    # Clears $var
                            }                                                               # End if ($GatewayIPConfig.Name -eq $GatewayIPConfigPri.Name)
                            if ($GatewayIPConfigPri.PublicIPAddress.ID -eq `
                                $GatewayIPConfig.PublicIPAddress.ID) {                      # If $GatewayIPConfigPri.PublicIPAddress.ID equals $GatewayIPConfig.PublicIPAddress.ID
                                Write-Host 'Invalid configuration on secondary config'      # Write message to screen   
                                Write-Host 'Please use a different public IP config'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                $GatewayIPConfig = $null                                    # Clears $var
                            }                                                               # End if ($GatewayIPConfigPri.PublicIPAddress.ID -eq $GatewayIPConfig.PublicIPAddress.ID)
                        }                                                                   # End if ($GatewayIPConfig)    
                        Clear-Host                                                          # Clears screen
                        if ($GatewayIPConfig) {                                             # If $GatewayIPConfig has a value
                            Break SetAzureGWActiveActive                                    # Breaks :SetAzureGWActiveActive
                        }                                                                   # End if ($GatewayIPConfig) 
                    }                                                                       # End :SetAzureGWActiveActive while ($true)
                }                                                                           # End if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or 'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') 
                else {                                                                      # Else if $GatewaySku does not equal 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3Az' -or 'HighPerformance'
                    Write-Host 'This gateway sku is not compatible with active-active'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureVNGateway                                                 # Breaks :SetAzureVNGateway
                }                                                                           # End else (if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or 'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') )
            }                                                                               # End if ($GatewayObject.IPConfigurations.count -eq '1' -and $GatewayObject.ActiveActive -eq $false)
            :Confirm while ($true) {                                                        # Inner loop to confirm the changes
                Write-Host 'Make the following changes'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Gateway Name: '$GatewayObject.Name                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($GatewayObject.activeActive -eq $false) {                               # If $GatewayObject.activeActive equals $false
                    Write-Host 'Enable Active-Active'                                       # Write message to screen
                }                                                                           # End if ($GatewayObject.activeActive -eq $false)
                else {                                                                      # Else if $GatewayObject.activeActive does not equal $false
                    Write-Host 'Disable Active-Active'                                      # Write message to screen
                }                                                                           # End else (if ($GatewayObject.activeActive -eq $false))
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to make this change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureVNGateway                                                 # Breaks :SetAzureVNGateway
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true)
            Try {                                                                           # Try the following
                if ($GatewayObject.activeActive -eq $false) {                               # If $GatewayObject.activeActive equals $false
                    Write-Host 'Adding seconday IP config'                                  # Write message to screen
                    Add-AzVirtualNetworkGatewayIpConfig -VirtualNetworkGateway `
                        $GatewayObject -Name $GatewayIPConfig.Name -SubnetId `
                        $GatewayIPConfig.Subnet.Id -PublicIpAddressId `
                        $GatewayIPConfig.PublicIPAddress.ID | Out-Null                      # Adds the additional IP config
                    Write-Host 'Enabling Active-Active'                                     # Write message to screen
                    Write-Host 'This will take a while'                                     # Write message to screen
                    Set-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                        -EnableActiveActiveFeature -ErrorAction 'Stop'                      # Enables Active-Active 
                }                                                                           # End if ($GatewayObject.activeActive -eq $false)
                else {                                                                      # Else if $GatewayObject.activeActive does not equal $false
                    $GatewayIPConSec = $GatewayObject.IpConfigurations[1].Name              # Gets the secondary IP config      
                    Write-Host 'Removing seconday IP config'                                # Write message to screen
                    Remove-AzVirtualNetworkGatewayIpConfig -Name $GatewayIPConSec `
                        -VirtualNetworkGateway $GatewayObject -ErrorAction 'Stop' `
                        | Out-Null                                                          # Removes the secondary IP config 
                    Write-Host 'Disabling Active-Active'                                    # Write message to screen
                    Write-Host 'This will take a while'                                     # Write message to screen
                    Set-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                        -DisableActiveActiveFeature -ErrorAction 'Stop' | Out-Null          # Disables Active-Active
                }                                                                           # End else (if ($GatewayObject.activeActive -eq $false))
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureVNGateway                                                     # Breaks :SetAzureVNGateway    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway Active-Active Config has been updated'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureVNGateway                                                         # Breaks :SetAzureVNGateway    
        }                                                                                   # End :SetAzureVNGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzVNGatewayAA