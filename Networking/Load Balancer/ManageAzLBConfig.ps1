# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    New-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0     
} #>
<# Required Functions Links: {
    NewAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLoadBalancer.ps1
    ListAzLoadBalancer:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/ListAzLoadBalancer.ps1
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
    RemoveAzLoadBalancer:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/RemoveAzLoadBalancer.ps1
    NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
    NewAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
    NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
    NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
    NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzLBConfig:           Function for managing load balancers
    NewAzLoadBalancer:          Creates a new load balancer    
    ListAzLoadBalancer:         Lists all existing load balancers
    GetAzLoadBalancer:          Gets an existing load balancer
    RemoveAzLoadBalancer:       Removes an existing load balancer
    NewAzLBFrontendIpConfig:    Creates a load balancer front end IP configuration
    NewAzPublicIpAddress:       Creates a new public IP addres
    GetAzPublicIpAddress:       Gets an existing IP address
    NewAzLBBackendIpConfig:     Creates a load balancer back end configuration
    NewAzLBProbeConfig:         Creates a load balancer probe configuration
    NewAzLBIBNatPoolConfig:     Creates inbound pool configuration for load balancer
    NewAzLBRuleConfig:          Creates a new load balancer rule
    GetAzResourceGroup:         Gets an existing resource group
} #>
<# Variables: {      
    :ManageAzureLoadBalancer    Outer loop for managing function
    $OpSelect:                  Operator input for selecting the management function
    AddAzLBFEPublicConfig{}            
    
} #>
<# Process Flow {
    function
        Call ManageAzLBConfig > Get $null

        End ManageAzLBConfig
            Return function > Send $null
}#>
function ManageAzLBConfig {                                                                 # Function to manage load balancer config
    Begin {                                                                                 # Begin function
        :ManageAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Manage Front End Config'                                        # Write message to screen
            Write-Host '[2] Manage Back End Config'                                         # Write message to screen
            Write-Host '[3] Manage Probe Config'                                            # Write message to screen
            Write-Host '[4] Mange Rule Config'                                              # Write message to screen
            Write-Host '[5] Mange Nat Pool Config'                                          # Write message to screen
            Write-Host '[6] Mange Nat Rule Config'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLoadBalancer                                               # Breaks :ManageAzureLoadBalancer
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                ManageAzLBFEConfig                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'New Back End Config'                                            # Write message to screen
                #NewAzLoadBalancer                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'New Probe Config'                                               # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'New Rule Config'                                                # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'New Nat Pool Config'                                            # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Mange Nat Rule Config'                                          # Write message to screen
                ManageAzLBNatRuleConfig                                                     # Calls function
            }                                                                               # elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBConfig
function ManageAzLBFEConfig {                                                               # Function to manage front end configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBFEConfig while ($true) {                                              # Outer loop for managing function
            Write-Host 'Manage Load Balancer Front End'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Private IP Config'                                          # Write message to screen
            Write-Host '[2] Add Public IP Config'                                           # Write message to screen
            Write-Host '[3] List IP configs'                                                # Write message to screen
            Write-Host '[4] Remove IP config'                                               # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBFEConfig                                                 # Breaks :ManageAzureLBFEConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Private IP Config'                                          # Write message to screen
                AddAzLBFEPrivateConfig                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Add Public IP Config'                                           # Write message to screen
                AddAzLBFEPublicConfig                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List IP configs'                                                # Write message to screen
                ListAzLBFEConfigs                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove IP config'                                               # Write message to screen
                RemoveAzLBFEConfig                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBFEConfig
function AddAzLBFEPrivateConfig {                                                           # Function to add a load balancer public IP front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBFEPrivateConfig'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID) {          # If $LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID has a value
                Write-Host 'This load balancer is currently referencing a public IP'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to add a private config to a load'           # Write message to screen
                Write-Host 'balancer configured with a public IP front end'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID)
            :NewAzureLBFrontEnd while ($true) {                                             # Inner loop for setting the type of front end config
                Write-Host 'Select type of front end config'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private Dynamic'                                            # Write message to screen
                Write-Host '[2] Private Static'                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the IP type for front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer  
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FrontEndIPConfigObject = NewAzLBFEPriDynamicIpCon ($CallingFunction)   # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break SetAzureLoadBalancer                                          # Breaks :SetAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FrontEndIPConfigObject = NewAzLBFEPriStaticIpCon ($CallingFunction)    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break SetAzureLoadBalancer                                          # Breaks :SetAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($FrontEndIPConfigObject) {                                              # If $FrontEndIPConfigObject has a value
                    Break NewAzureLBFrontEnd                                                # Breaks :NewAzureLBFrontEnd
                }                                                                           # End if ($FrontEndIPConfigObject)
            }                                                                               # End :NewAzureLBFrontEnd while ($true)
            $SubnetName = $FrontEndIPConfigObject.Subnet.ID                                 # Isolates the subnet ID
            $SubnetName = $SubnetName.Split('/')[-1]                                        # Isolates the subnet name
            Write-Host 'Add the following:'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host 'Front end name:'$FrontEndIPConfigObject.Name                        # Write message to screen
            Write-Host 'Private IP add:'$FrontEndIPConfigObject.PrivateIpAddress            # Write message to screen
            Write-Host 'Private IP all:'$FrontEndIPConfigObject.PrivateIpAllocationMethod   # Write message to screen
            Write-Host 'Subnet Name:   '$SubnetName                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding load balancer front end config'                      # Write message to screen    
                    if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic') {  # If $FrontEndIPConfigObject.PrivateIpAllocationMethod equals 'Dynamic'                  
                        $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                        Write-Host 'Saving load balancer front end config'                  # Write message to screen
                        $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -ErrorAction 'Stop' `
                            | Out-Null                                                      # Saves the load balancer config
                    }                                                                       # End if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic')
                    else {                                                                  # Else if $FrontEndIPConfigObject.PrivateIpAllocationMethod does not equal 'Dynamic'
                        $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -PrivateIpAddress `
                            $FrontEndIPConfigObject.PrivateIpAddress -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                        Write-Host 'Saving load balancer front end config'                  # Write message to screen
                        $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -PrivateIpAddress `
                            $FrontEndIPConfigObject.PrivateIpAddress -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                    }                                                                       # End else (if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic'))
                    Write-Host 'Saving load balancer config'                                # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the load balancer state
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The front end config has been added'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBFEPrivateConfig
function AddAzLBFEPublicConfig {                                                            # Function to add a load balancer public IP front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBFEPublicConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.FrontendIpConfigurations.Subnet.ID) {                   # If $LoadBalancerObject.FrontendIpConfigurations.Subnet.ID has a value
                Write-Host 'This load balancer is currently referencing a subnet'           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to add a public config to a load'            # Write message to screen
                Write-Host 'balancer configured with a private IP front end'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LoadBalancerObject.FrontendIpConfigurations.Subnet.ID)
            $FrontEndIPConfigObject = NewAzLBFEPubIPCon ($CallingFunction)                  # Calls function and assigns the output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $LBSku =  $LoadBalancerObject.Sku.name                                          # Gets the current load balance sku
            $PubIPID = $FrontEndIPConfigObject.PublicIPAddress.Id                           # Isloates the public IP ID
            $PubIPObject = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubIPID}        # Gets the public IP object
            $PubIPSku = $PubIPObject.Sku.Name                                               # Isloates the sku
            if ($PubIPObject.IpConfiguration.Id) {                                          # If $PubIPObject.IpConfiguration.Id has a value
                Write-Host 'This public IP sku is already in use'                           # Write message to screen
                Write-Host 'Please select an unused public IP sku'                          # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }
            if ($LBSku -ne $PubIPSku) {                                                     # If $LBSku does not equal $PubIPSku
                if ($LBSku -eq 'Basic') {                                                   # If $LBSku equals 'Basic'
                    Write-Host 'The load balancer is a basic SKU and'                       # Write message to screen
                    Write-Host 'can only use a basic public IP sku'                         # Write message to screen
                }                                                                           # End   
                else {                                                                      # If $LBSku does not equal 'Basic'                              
                    Write-Host 'The load balancer is a standard SKU and'                    # Write message to screen
                    Write-Host 'can only use a standard public IP sku'                      # Write message to screen
                }                                                                           # End else (if ($LBSku -eq 'Basic'))
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LBSku -ne $PubIPSku)
            Write-Host 'Add the following:'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host 'Front end name:'$FrontEndIPConfigObject.Name                        # Write message to screen
            Write-Host 'Public IP name:'$PubIPObject.Name                                   # Write message to screen
            Write-Host 'Public IP add: '$PubIPObject.IpAddress                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding load balancer front end config'                      # Write message to screen                         
                    $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                        $FrontEndIPConfigObject.Name -PublicIpAddressId `
                        $FrontEndIPConfigObject.PublicIPAddress.ID -ErrorAction 'Stop' `
                        | Out-Null                                                          # Adds the load balancer config
                    Write-Host 'Saving load balancer front end config'                      # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                        $FrontEndIPConfigObject.Name -PublicIpAddressId `
                        $FrontEndIPConfigObject.PublicIPAddress.ID -ErrorAction 'Stop' `
                        | Out-Null                                                          # Saves the load balancer config
                    Write-Host 'Saving load balancer config'                                # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the load balancer state
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The front end config has been added'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBFEPublicConfig
function ListAzLBFEConfigs {                                                                # Function to list all load balancer front end configs
    Begin {                                                                                 # Begin function
        :ListAzureLBFEConfigs while ($true) {                                               # Outer loop for managing function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Gets a list of all load balancers
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'There are no load balancers in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBFEConfigs                                                  # Breaks ListAzureLBFEConfigs
            }                                                                               # if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                Write-Host 'Gathering info on:'$_.name                                      # Write message to screen
                $LoadBalancerObject = Get-AzLoadBalancer -Name $_.Name                      # Gets the current load balancer object
                $ObjectList2 = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets the configs of the current load balancer
                foreach ($_ in $ObjectList2) {                                              # For each item in $ObjectList2
                    if ($_.Subnet.ID) {                                                     # If current item .subnet.id has a value
                        $SubnetID = $_.Subnet.ID                                            # Isolates the subnet ID
                        $SubnetID = $SubnetID.Split('/')[-1]                                # Isolates the subnet name
                    }                                                                       # End if ($_.Subnet.ID)
                    if ($_.PublicIPAddress.ID) {                                            # If current item .PublicIPAddress.ID 
                        $PublicIPID = $_.PublicIPAddress.ID                                 # Isolates the public IP ID 
                        $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                            {$_.ID -eq $PublicIPID}                                         # Gets the public IP object
                    }                                                                       # End if ($_.PublicIPAddress.ID)
                    $ObjectInput = [PSCustomObject]@{                                       # Custom object to be added to $ObjectArray
                        'Name'=$_.Name;'PriIP'=$_.PrivateIpAddress;`
                        'PriIP2'=$_.PrivateIpAllocationMethod;'Sub'=$SubnetID;`
                        'PubIP'=$PublicIPObject.IpAddress;`
                        'PubIP2'=$PublicIPObject.PublicIpAllocationMethod;`
                        'PubIP3'=$PublicIPObject.Sku.Name;'LB'=$LoadBalancerObject.Name     # Creates the item to loaded into array
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $SubnetID = $null                                                       # Clears $SubnetID
                    $PublicIPID = $null                                                     # Clears $PublicIPID
                    $PublicIPObject = $null                                                 # Clears $PublicIPObject
                }                                                                           # End foreach ($_ in $ObjectList2)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Config Name:'$_.Name                                            # Write message to screen
                Write-Host 'LB Name:    '$_.LB                                              # Write message to screen
                if ($_.PubIP) {                                                             # If current item .PubIP has a value
                    Write-host 'Config Type: Public'                                        # Write message to screen
                    Write-Host 'IP Address: '$_.PubIP                                       # Write message to screen
                    Write-Host 'Allocation: '$_.PubIP2                                      # Write message to screen
                    Write-Host 'Sku Name:   '$_.PubIP3                                      # Write message to screen
                }                                                                           # End if ($_.PubIP)
                else {                                                                      # Else if current item .PubIP is $null
                    Write-host 'Config Type: Private'                                       # Write message to screen
                    if ($_.PriIP) {                                                         # if current item .priIP has a value
                        Write-Host 'IP Address: '$_.PriIP                                   # Write message to screen
                    }                                                                       # End if ($_.PriIP)
                    Write-Host 'Allocation: '$_.PriIP2                                      # Write message to screen
                    Write-Host 'Subnet:     '$_.Sub                                         # Write message to screen
                }                                                                           # End else (if ($_.PubIP))
                Write-Host ''                                                               # Write message to screen                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBFEConfigs                                                      # Breaks :ListAzureLBFEConfigs
        }                                                                                   # End :ListAzureLBFEConfigs while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBFEConfigs
function GetAzLBFEConfig {                                                                  # Function to get a load balancer front end config
    Begin {                                                                                 # Begin function
        :GetAzureLBFEConfig while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Gets a list of all load balancers
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'There are no load balancers in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBFEConfig                                                    # Breaks GetAzureLBFEConfig
            }                                                                               # if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $ObjectNumber = 1
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                Write-Host 'Gathering info on:'$_.name                                      # Write message to screen
                $LoadBalancerObject = Get-AzLoadBalancer -Name $_.Name                      # Gets the current load balancer object
                $ObjectList2 = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets the configs of the current load balancer
                foreach ($_ in $ObjectList2) {                                              # For each item in $ObjectList2
                    if ($_.Subnet.ID) {                                                     # If current item .subnet.id has a value
                        $SubnetID = $_.Subnet.ID                                            # Isolates the subnet ID
                        $SubnetID = $SubnetID.Split('/')[-1]                                # Isolates the subnet name
                    }                                                                       # End if ($_.Subnet.ID)
                    if ($_.PublicIPAddress.ID) {                                            # If current item .PublicIPAddress.ID 
                        $PublicIPID = $_.PublicIPAddress.ID                                 # Isolates the public IP ID 
                        $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                            {$_.ID -eq $PublicIPID}                                         # Gets the public IP object
                    }                                                                       # End if ($_.PublicIPAddress.ID)
                    $ObjectInput = [PSCustomObject]@{                                       # Custom object to be added to $ObjectArray
                        'Number'=$ObjectNumber;`
                        'Name'=$_.Name;'PriIP'=$_.PrivateIpAddress;`
                        'PriIP2'=$_.PrivateIpAllocationMethod;'Sub'=$SubnetID;`
                        'PubIP'=$PublicIPObject.IpAddress;`
                        'PubIP2'=$PublicIPObject.PublicIpAllocationMethod;`
                        'PubIP3'=$PublicIPObject.Sku.Name;'LB'=$LoadBalancerObject.Name     # Creates the item to loaded into array
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $SubnetID = $null                                                       # Clears $SubnetID
                    $PublicIPID = $null                                                     # Clears $PublicIPID
                    $PublicIPObject = $null                                                 # Clears $PublicIPObject
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $ObjectList2)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLBFEConfig while ($true) {                                          # Inner loop for selecting the front end config
                Write-Host '[0]          Exit'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen    
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$number]         "$_.Name                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is more than 9
                        Write-Host "[$number]       "$_.Name                                # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB Name:    '$_.LB                                          # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        Write-host 'Config Type: Public'                                    # Write message to screen
                        Write-Host 'IP Address: '$_.PubIP                                   # Write message to screen
                        Write-Host 'Allocation: '$_.PubIP2                                  # Write message to screen
                        Write-Host 'Sku Name:   '$_.PubIP3                                  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    else {                                                                  # Else if current item .PubIP is $null
                        Write-host 'Config Type: Private'                                   # Write message to screen
                        if ($_.PriIP) {                                                     # if current item .priIP has a value
                            Write-Host 'IP Address: '$_.PriIP                               # Write message to screen
                        }                                                                   # End if ($_.PriIP)
                        Write-Host 'Allocation: '$_.PriIP2                                  # Write message to screen
                        Write-Host 'Subnet:     '$_.Sub                                     # Write message to screen
                    }                                                                       # End else (if ($_.PubIP))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the front end config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureLBFEConfig                                                # Breaks :GetAzureLBFEConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LB             # Gets the load balancer object
                    $FrontEndIPConfigObject = Get-AzLoadBalancerFrontendIpConfig `
                        -LoadBalancer $LoadBalancerObject -Name $OpSelect.Name              # Gets the front end IP config object
                    Return $FrontEndIPConfigObject,$LoadBalancerObject                      # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureLBFEConfig while ($true)
        }                                                                                   # End :GetAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBFEConfig
function RemoveAzLBFEConfig {                                                               # Function to remove a load balancer front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBFEConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBFEConfig while ($true) {                                              # Outer loop for managing function
            $FrontEndIPConfigObject,$LoadBalancerObject = GetAzLBFEConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End if (!$FrontEndIPConfigObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host 'Config Name:'$FrontEndIPConfigObject.Name                           # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'
                    Remove-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                        $LoadBalancerObject -Name $FrontEndIPConfigObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBFEConfig                                             # Breaks :RemoveAzureLBFEConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBFEConfig
function ManageAzLBNatRuleConfig {                                                          # Function to manage nat rule configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBNatRuleConfig while ($true) {                                         # Outer loop for managing function
            Write-Host 'Manage Load Balancer Nat Rules'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Nat Rule Config'                                            # Write message to screen
            Write-Host '[2] List Nat Rule Configs'                                          # Write message to screen
            Write-Host '[3] Add VM to Nat Rule Config'                                      # Write message to screen
            Write-Host '[4] Change Nat Rule Config'                                         # Write message to screen
            Write-Host '[5] Remove Nat Rule Config'                                         # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBNatRuleConfig                                            # Breaks :ManageAzureLBNatRuleConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Nat Rule Config'                                            # Write message to screen
                AddAzLBNatRuleConfig                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Nat Rule Configs'                                          # Write message to screen
                ListAzLBNatRuleConfig                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Add VM to Nat Rule Config'                                      # Write message to screen
                SetAzLBNatRuleVM                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Change Nat Rule Config'                                         # Write message to screen
                #ListAzLBFEConfigs                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Remove Nat Rule Config'                                         # Write message to screen
                RemoveAzLBNatRuleConfig                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBNatRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBFEConfig
function AddAzLBNatRuleConfig {                                                             # Function to add a nat rule configuration
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBNatRuleConfig'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBNatRule while ($true) {                                                  # Inner loop for setting the nat rule name
            $FrontEndIPConfigObject,$LoadBalancerObject = GetAzLBFEConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $vars
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break AddAzureLBNatRule                                                     # Breaks :AddAzureLBNatRule
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBRuleName while ($true) {                                             # Inner loop for setting the rule name
                Write-Host 'Enter a load balancer rule name'                                # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleName = Read-Host 'Name'                                              # Operator input for the pool name
                Clear-Host                                                                  # Clears screen
                $LBRuleNameArray = $LBRuleName.ToCharArray()                                # Loads $LBRuleNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleName.Length -ge 81) {                                            # If $LBRuleName.Length is greater or equal to 81
                    Write-Host 'The rule name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleName.Length -ge 80)
                if ($LBRuleNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $LBRuleNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                if ($LBRuleNameArray[-1] -notin $ValidLastChar) {                           # If last position of $LBRuleNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $LBRuleNameArray) {                                          # For each item in $LBRuleNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBRuleName = $null                                                 # Clears $LBRuleName
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBRuleName) {                                                          # If $LBRuleName has a value
                    Write-Host 'Use:'$LBRuleName' as the rule name'                         # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBNatRule                                             # Breaks :AddAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleName                                            # Breaks :NewAzureLBRuleName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleName)
                else {                                                                      # If $LBRuleName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleName))
            }                                                                               # End :NewAzureLBRuleName while ($true)
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host 'Inbound Nat Rule Protocol'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the rule protocol
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break AddAzureLBNatRule                                                 # Breaks :AddAzureLBNatRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBRuleProtocol = 'TCP'                                                 # Creates $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBRuleProtocol = 'UDP'                                                 # Creates $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBRulePort while ($true) {                                             # Inner loop for setting the rule port
                Write-Host 'Enter the nat rule port'                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRulePort = Read-Host 'Port #'                                            # Operator input for the front end rule port 
                $LBRuleArray = $LBRulePort.ToCharArray()                                    # Adds $LBRulePort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRulePort = $null                                                 # Clears $LBRulePort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRulePort) {                                                          # If $LBRulePort has a value
                    Write-Host 'Use:'$LBRulePort' as the rule port'                         # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBNatRule                                             # Breaks :AddAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRulePort                                            # Breaks :NewAzureLBRulePort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRulePort)
                else {                                                                      # Else if $LBRulePort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRulePort))
            }                                                                               # End :NewAzureLBRulePort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in minutes for this rule'               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout'                                    # Operator input for the rule idle timeout 
                $LBRuleIdleINT = [int]$LBRuleIdleTO                                         # Converts the operator input into an interger
                $LBRuleArray = $LBRuleIdleTO.ToCharArray()                                  # Adds $LBRuleIdleTO to array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleIdleINT -gt 30) {                                                # If $LBRuleIdleINT is greater than 30
                    Write-Host 'Rule time out max is 30 minutes'                            # Write message to screen
                    Write-Host 'Please choose a lower timeout'                              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleIdleTO = $null                                                   # Clears $LBRuleIdleTO
                }                                                                           # End if ($LBRuleIdleTO -gt 30)
                $LBRuleIdleINT =$null
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleIdleTO = $null                                               # Clears $LBRuleIdleTO
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleIdleTO) {                                                        # If $LBRuleIdleTO has a value
                    Write-Host 'Use:'$LBRuleIdleTO' as the rule idle time out'              # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the idle timeout
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBNatRule                                             # Breaks :AddAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleIdleTO)
                else {                                                                      # Else if $LBRuleIdleTO is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleIdleTO))
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Adding the nat rule to the load balancer'                       # Write message to screen
                Add-AzLoadBalancerInboundNatRuleConfig -LoadBalancer $LoadBalancerObject `
                    -FrontendIpConfigurationId $FrontEndIPConfigObject.ID `
                    -Name $LBRuleName  -Protocol $LBRuleProtocol -FrontendPort $LBRulePort `
                    -BackendPort $LBRulePort -IdleTimeoutInMinutes $LBRuleIdleTO `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the load balancer nat rule
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBNatRule                                                     # Breaks :AddAzureLBNatRule
            }                                                                               # End catch
            Write-Host 'Saving the configuration'
            $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'silentlyContinue' `
                | Out-Null                                                                  # Saves the changes
            Clear-Host                                                                      # Clears screen
            Write-Host 'The rule has been added'                                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBNatRule                                                         # Breaks :AddAzureLBNatRule
        }                                                                                   # End :AddAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBNatRuleConfig
function ListAzLBNatRuleConfig {                                                            # Function to list all load balancer nat rules
    Begin {                                                                                 # Begin function
        :ListAzureLBNatRule while ($true) {                                                 # Outer loop for managing function
            $LBList = Get-AzLoadBalancer                                                    # Gets a list of all load balancers
            Write-Host 'Gathering load balancer configurations'                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            if (!$LBList) {                                                                 # If $LBList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers present in this subscription'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBNatRule                                                    # Breaks :ListAzureLBNatRule
            }                                                                               # End if (!$LBList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $LBList) {                                                       # For each item in $LBList
                $LoadBalancerObject = $_                                                    # $LoadBalancerObject is equal to current item
                $LBRuleList = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets a list of load balancers nat rules on $LoadBalancerObject
                if ($LBRuleList) {                                                          # If $LBRuleList has a value
                    foreach ($_ in $LBRuleList) {                                           # For each item in $LBRuleList
                        $FrontEndID = $_.FrontendIpConfiguration.ID                         # Gets the rule front end ID
                        $FrontEndID = $FrontEndID.Split('/')[-1]                            # Isloates the front end config name
                        $FrontEnd = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                            $LoadBalancerObject -Name $FrontEndID                           # Gets the front end object
                        if ($FrontEnd.Subnet.ID) {                                          # If $FrontEnd.Subnet.ID has a value
                            $FrontEndSub = $FrontEnd.Subnet.ID                              # Isloates the front end subnet ID
                            $FrontEndSub = $FrontEndSub.Split('/')[-1]                      # Isolates the front end subnet name
                        }                                                                   # End if ($FrontEnd.Subnet.ID)
                        if ($FrontEnd.PublicIpAddress.ID) {                                 # If $FrontEnd.PublicIpAddress.ID has a value
                            $PubIPID = $FrontEnd.PublicIpAddress.ID                         # Isolates the public IP ID
                            $FEPublicIPObject = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubIPID}                                        # Gets the public ID sku object
                        }                                                                   # End if ($FrontEnd.PublicIpAddress.ID)
                        if ($_.BackendIpConfiguration.ID) {                                 # If current item .BackendIpConfiguration.ID has a value
                            $BackEndID = $_.BackendIpConfiguration.ID                       # Isolates the back end IP config ID
                            $BackEndNic = $BackEndID.Split('/')[8]                          # Isolates the back end NIC name
                            $BackEndName = $BackEndID.Split('/')[-1]                        # Isolates the back end IP config name
                            $BackEndNic = Get-AzNetworkInterface -Name $BackEndNic          # Gets the back end NIC
                            $BackEndConfig = Get-AzNetworkInterfaceIpConfig `
                                -NetworkInterface $BackEndNic -Name $BackEndName            # Gets the back end config NIC ip config
                            $BackEndSub = $BackEndConfig.Subnet.Id                          # Isolates the back end subnet ID
                            $BackEndSub = $BackEndSub.Split('/')[-1]                        # Isolates the back end subnet name
                        }                                                                   # End if ($_.BackendIpConfiguration.ID) 
                        $ObjectList = [PSCustomObject]@{                                    # Var used to load items into $ObjectArray
                            'Name'=$_.Name;'Proto'=$_.Protocol;`
                            'LBName'=$LoadBalancerObject.Name;`
                            'FEPort'=$_.FrontendPort;'BEPort'=$_.BackEndPort;`
                            'Idle'=$_.IdleTimeoutInMinutes;'FEName'=$FrontEnd.Name;`
                            'FEPriIP'=$FrontEnd.PrivateIpAddress;`
                            'FEPriAll'=$FrontEnd.PrivateIpAllocationMethod;`
                            'FESub'=$FrontEndSub;`
                            'FEPubIPName'=$FEPublicIPObject.Name;`
                            'FEPubIPAdd'=$FEPublicIPObject.IpAddress;`
                            'FEPubIPAll'=$FEPublicIPObject.PublicIpAllocationMethod;`
                            'BEPriIP'=$BackEndConfig.PrivateIpAddress;`
                            'BEPriIPAll'=$BackEndConfig.PrivateIpAllocationMethod;`
                            'BESub'=$BackEndSub                                             # Assoicates the items to $ObjectList         
                        }                                                                   # End $ObjectList = [PSCustomObject]@
                        $ObjectArray.Add($ObjectList) | Out-Null                            # Adds ObjectList to $ObjectArray
                        $FrontEndID = $null                                                 # Clears $var                     
                        $FrontEnd = $null                                                   # Clears $var
                        $FrontEndSub = $null                                                # Clears $var
                        $PubIPID = $null                                                    # Clears $var
                        $FEPublicIPObject = $null                                           # Clears $var
                        $BackEndID = $null                                                  # Clears $var
                        $BackEndNic = $null                                                 # Clears $var
                        $BackEndName = $null                                                # Clears $var
                        $BackEndConfig = $null                                              # Clears $var
                        $BackEndSub = $null                                                 # Clears $var
                    }                                                                       # End foreach ($_ in $LBRuleList)
                }                                                                           # End if ($LBRuleList)
            }                                                                               # End foreach ($_ in $LBList)
            Clear-Host                                                                      # Clears screen    
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No inbound nat rules are present in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBNatRule                                                    # Breaks :ListAzureLBNatRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Nat rule name: '$_.Name                                         # Write message to screen
                Write-Host 'LB name:       '$_.LBName                                       # Write message to screen
                Write-Host 'Protocol:      '$_.Proto                                        # Write message to screen
                Write-Host 'FE port:       '$_.FEPort                                       # Write message to screen
                Write-Host 'BE port:       '$_.BEPort                                       # Write message to screen
                Write-Host 'Idle TO in min:'$_.Idle                                         # Write message to screen
                Write-Host 'Front end name:'$_.FeName                                       # Write message to screen
                if ($_.FESub) {                                                             # If $_.FESub has a value
                    Write-Host 'FE private IP: '$_.FEPriIP                                  # Write message to screen
                    Write-Host 'FE IP method:  '$_.FEPriAll                                 # Write message to screen
                    Write-Host 'FE subnet:     '$_.FESub                                    # Write message to screen
                }                                                                           # End if ($_.FESub)
                if ($_.FEPubIPName) {                                                       # If $_.FEPubIPName has a value
                    Write-Host 'FE pub IP name:'$_.FEPubIPName                              # Write message to screen
                    Write-Host 'FE pub IP add: '$_.FEPubIPAdd                               # Write message to screen
                    Write-Host 'FE pub method: '$_.FEPubIPAll                               # Write message to screen
                }                                                                           # End if ($_.FEPubIPName)
                if ($_.BESub) {                                                             # If $_.BESub has a value
                    Write-Host 'BE private IP: '$_.BEPriIP                                  # Write message to screen
                    Write-Host 'BE IP method:  '$_.BEPriIPAll                               # Write message to screen
                    Write-Host 'BE subnet:     '$_.BESub                                    # Write message to screen
                }                                                                           # End if ($_.BESub)
                if ($_.BEPubIP) {                                                           # If $_.BEPubIP has a value
                    Write-Host 'BE public IP:  '$_.BEPubIP                                  # Write message to screen
                }                                                                           # End if ($_.BEPubIP)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBNatRule                                                        # Breaks :ListAzureLBNatRule
        }                                                                                   # End :ListAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBNatRuleConfig
function SetAzLBNatRuleVM {                                                                 # Function to associate a VM to a nat rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'SetAzLBNatRuleVM'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRuleVM while ($true) {                                                # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$LBNatRule)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$NicIPConfigObject)
            $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                           # Isloates the VM name
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Add:'                                                               # Write message to screen
            Write-Host 'VM Name:      '$VMName                                              # Write message to screen
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'To:'                                                                # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'Nat Rule:     '$LBNatRule.name                                      # Write message to screen
            Write-Host 'Nat Protocol: '$LBNatRule.Protocol                                  # Write message to screen
            Write-Host 'Nat FE Port:  '$LBNatRule.FrontendPort                              # Write message to screen
            Write-Host 'Nat BE Port:  '$LBNatRule.BackendPort                               # Write message to screen
            Write-Host 'Nat Idle TO:  '$LBNatRule.IdleTimeoutInMinutes                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding the IP config to nat rule'                           # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerInboundNatRuleId `
                        $LBNatRule.ID -ErrorAction 'Stop' | Out-Null                        # Adds the load balancer inbound nat rule
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBNatRuleVM                                               # Breaks :SetAzureLBNatRuleVM
                }                                                                           # End catch
                Write-Host 'Saving nic configuration'                                       # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'The changes have been made'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBNatRuleVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBNatRuleVM
Function GetAzLBNatRuleConfig {                                                             # Function to get a load balancer nat rule
    Begin {                                                                                 # Begin function
        :GetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBList = Get-AzLoadBalancer                                                    # Gets a list of all load balancers
            Write-Host 'Gathering load balancer configurations'                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            if (!$LBList) {                                                                 # If $LBList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers present in this subscription'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBNatRule                                                     # Breaks :GetAzureLBNatRule
            }                                                                               # End if (!$LBList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            foreach ($_ in $LBList) {                                                       # For each item in $LBList
                $LoadBalancerObject = $_                                                    # $LoadBalancerObject is equal to current item
                $LBRuleList = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets a list of load balancers nat rules on $LoadBalancerObject
                if ($LBRuleList) {                                                          # If $LBRuleList has a value
                    foreach ($_ in $LBRuleList) {                                           # For each item in $LBRuleList
                        $FrontEndID = $_.FrontendIpConfiguration.ID                         # Gets the rule front end ID
                        $FrontEndID = $FrontEndID.Split('/')[-1]                            # Isloates the front end config name
                        $FrontEnd = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                            $LoadBalancerObject -Name $FrontEndID                           # Gets the front end object
                        if ($FrontEnd.Subnet.ID) {                                          # If $FrontEnd.Subnet.ID has a value
                            $FrontEndSub = $FrontEnd.Subnet.ID                              # Isloates the front end subnet ID
                            $FrontEndSub = $FrontEndSub.Split('/')[-1]                      # Isolates the front end subnet name
                        }                                                                   # End if ($FrontEnd.Subnet.ID)
                        if ($FrontEnd.PublicIpAddress.ID) {                                 # If $FrontEnd.PublicIpAddress.ID has a value
                            $PubIPID = $FrontEnd.PublicIpAddress.ID                         # Isolates the public IP ID
                            $FEPublicIPObject = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubIPID}                                        # Gets the public ID sku object
                        }                                                                   # End if ($FrontEnd.PublicIpAddress.ID)
                        if ($_.BackendIpConfiguration.ID) {                                 # If current item .BackendIpConfiguration.ID has a value
                            $BackEndID = $_.BackendIpConfiguration.ID                       # Isolates the back end IP config ID
                            $BackEndNic = $BackEndID.Split('/')[8]                          # Isolates the back end NIC name
                            $BackEndName = $BackEndID.Split('/')[-1]                        # Isolates the back end IP config name
                            $BackEndNic = Get-AzNetworkInterface -Name $BackEndNic          # Gets the back end NIC
                            $BackEndConfig = Get-AzNetworkInterfaceIpConfig `
                                -NetworkInterface $BackEndNic -Name $BackEndName            # Gets the back end config NIC ip config
                            $BackEndSub = $BackEndConfig.Subnet.Id                          # Isolates the back end subnet ID
                            $BackEndSub = $BackEndSub.Split('/')[-1]                        # Isolates the back end subnet name
                        }                                                                   # End if ($_.BackendIpConfiguration.ID) 
                        $ObjectList = [PSCustomObject]@{                                    # Var used to load items into $ObjectArray
                            'Number'=$ObjectNumber;'Name'=$_.Name;'Proto'=$_.Protocol;`
                            'LBName'=$LoadBalancerObject.Name;`
                            'FEPort'=$_.FrontendPort;'BEPort'=$_.BackEndPort;`
                            'Idle'=$_.IdleTimeoutInMinutes;'FEName'=$FrontEnd.Name;`
                            'FEPriIP'=$FrontEnd.PrivateIpAddress;`
                            'FEPriAll'=$FrontEnd.PrivateIpAllocationMethod;`
                            'FESub'=$FrontEndSub;`
                            'FEPubIPName'=$FEPublicIPObject.Name;`
                            'FEPubIPAdd'=$FEPublicIPObject.IpAddress;`
                            'FEPubIPAll'=$FEPublicIPObject.PublicIpAllocationMethod;`
                            'BEPriIP'=$BackEndConfig.PrivateIpAddress;`
                            'BEPriIPAll'=$BackEndConfig.PrivateIpAllocationMethod;`
                            'BESub'=$BackEndSub                                             # Assoicates the items to $ObjectList         
                        }                                                                   # End $ObjectList = [PSCustomObject]@
                        $ObjectArray.Add($ObjectList) | Out-Null                            # Adds ObjectList to $ObjectArray
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber up by 1
                        $FrontEndID = $null                                                 # Clears $var                     
                        $FrontEnd = $null                                                   # Clears $var
                        $FrontEndSub = $null                                                # Clears $var
                        $PubIPID = $null                                                    # Clears $var
                        $FEPublicIPObject = $null                                           # Clears $var
                        $BackEndID = $null                                                  # Clears $var
                        $BackEndNic = $null                                                 # Clears $var
                        $BackEndName = $null                                                # Clears $var
                        $BackEndConfig = $null                                              # Clears $var
                        $BackEndSub = $null                                                 # Clears $var
                    }                                                                       # End foreach ($_ in $LBRuleList)
                }                                                                           # End if ($LBRuleList)
            }                                                                               # End foreach ($_ in $LBList)
            Clear-Host                                                                      # Clears screen    
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No inbound nat rules are present in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBNatRule                                                     # Breaks :GetAzureLBNatRule
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureLBNatRule while ($true) {                                           # Inner loop for selecting the nat rule
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'Protocol:      '$_.Proto                                    # Write message to screen
                    Write-Host 'FE port:       '$_.FEPort                                   # Write message to screen
                    Write-Host 'BE port:       '$_.BEPort                                   # Write message to screen
                    Write-Host 'Idle TO in min:'$_.Idle                                     # Write message to screen
                    Write-Host 'Front end name:'$_.FeName                                   # Write message to screen
                    if ($_.FESub) {                                                         # If $_.FESub has a value
                        Write-Host 'FE private IP: '$_.FEPriIP                              # Write message to screen
                        Write-Host 'FE IP method:  '$_.FEPriAll                             # Write message to screen
                        Write-Host 'FE subnet:     '$_.FESub                                # Write message to screen
                    }                                                                       # End if ($_.FESub)
                    if ($_.FEPubIPName) {                                                   # If $_.FEPubIPName has a value
                        Write-Host 'FE pub IP name:'$_.FEPubIPName                          # Write message to screen
                        Write-Host 'FE pub IP add: '$_.FEPubIPAdd                           # Write message to screen
                        Write-Host 'FE pub method: '$_.FEPubIPAll                           # Write message to screen
                    }                                                                       # End if ($_.FEPubIPName)
                    if ($_.BESub) {                                                         # If $_.BESub has a value
                        Write-Host 'BE private IP: '$_.BEPriIP                              # Write message to screen
                        Write-Host 'BE IP method:  '$_.BEPriIPAll                           # Write message to screen
                        Write-Host 'BE subnet:     '$_.BESub                                # Write message to screen
                    }                                                                       # End if ($_.BESub)
                    if ($_.BEPubIP) {                                                       # If $_.BEPubIP has a value
                        Write-Host 'BE public IP:  '$_.BEPubIP                              # Write message to screen
                    }                                                                       # End if ($_.BEPubIP)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the nat rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the nat rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureLBNatRule                                                 # Breaks :GetAzureLBNatRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # OpSelect is equal to $ObjectArray where $Opselect equals $ObjectArray.Number
                    $LoadBalancerObject = Get-AzLoadBalancer -name $OpSelect.LBName         # Pulls the load balancer
                    $LBNatRule = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer rule
                    Return $LBNatRule, $LoadBalancerObject                                  # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBNatRule while ($true)
        }                                                                                   # End :GetAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBNatRuleConfig
Function RemoveAzLBNatRuleConfig {                                                          # Function to remove a load balancer nat rule configuration
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBNatRuleConfig'                                    # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBNatRule while ($true) {                                               # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $vars
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break RemoveAzureLBNatRule                                                  # Breaks :RemoveAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            Write-Host 'Remove the following'                                               # Write message to screen
            Write-Host 'Nat Rule Config:'$LBNatRule.Name                                    # Write message to screen
            Write-Host 'Load Balancer:  '$LoadBalancerObject.Name                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation of action
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBNatRule.Name -ErrorAction 'Stop' `
                        | Out-Null                                                          # Removes the nat rule
                    Set-AzLoadBalancer -LoadBalancer $LoadBalancerObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Saves the load balancer config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBNatRule                                              # Breaks :RemoveAzureLBNatRule
                }                                                                           # End catch
                Write-Host 'The nat rule has been removed'                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBNatRule                                                  # Breaks :RemoveAzureLBNatRule
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBNatRule                                                  # Breaks :RemoveAzureLBNatRule
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function RemoveAzLBNatRuleConfig
# Functions required for ManageAzLBConfig
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLoadBalancer                                                  # Breaks GetAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                if ($_.BackendAddressPools.BackendIpConfigurations.id) {                    # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                    $VmssID = $_.BackendAddressPools.BackendIpConfigurations.id             # Isolates .BackendAddressPools.BackendIpConfigurations.id
                    $VmssRG = $VmssID.Split('/')[4]                                         # Isolates the Vmss resource group
                    $VmssName = $VmssID.Split('/')[8]                                       # Isolates the Vmss name
                }                                                                           # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RGName'=$_.ResourceGroupName;`
                    'LOC'=$_.Location;'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name; `
                    'VmssName'=$VmssName;'VmssRG'=$VmssRG                                   # Gets current item info
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB loc:        '$_.loc                                      # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'LB SKU:        '$_.Sku                                      # Write message to screen
                    if ($_.Pubname) {                                                       # If $_.Pubname has a value
                        Write-Host 'Pub IP name:   '$_.Pubname                              # Write message to screen
                        Write-Host 'Pub IP address:'$_.PubAddress                           # Write message to screen
                        Write-Host 'Pub IP allocat:'$_.PubAllocation                        # Write message to screen
                    }                                                                       # End if ($_.Pubname)
                    if ($_.VmssName) {                                                      # If $_.VmssName has a value
                        Write-Host 'Vmss name:     '$_.VmssName                             # Write message to screen
                        Write-Host 'Vmss RG:       '$_.VmssRG                               # Write message to screen
                    }                                                                       # End if ($_.VmssName)
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the load balancer for:'$CallingFunction   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                Clear-Host                                                                  # Clears screen 
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.Name `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer
function NewAzLBFEPriDynamicIpCon {                                                         # Function to set up a private dynamic front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                $CurrentConfig = Get-AzLoadBalancerFrontendIpConfig `
                -LoadBalancer $LoadBalancerObject                                           # Gets the load balancer front end configurations
                if ($CurrentConfig.PrivateIpAllocationMethod) {                             # If $CurrentConfig.PrivateIpAllocationMethod has a value
                    Write-Host 'A subnet is currently in use by this load balancer'         # Write message to screen
                    Write-Host 'Getting subnet information'                                 # Write message to screen
                    $SubnetID = $CurrentConfig.Subnet.ID                                    # Isolates the subnet ID
                    $SubnetName = $SubnetID.Split('/')[-1]                                  # Isloates the subnet name
                    $VnetName = $SubnetID.Split('/')[8]                                     # Isloates the vnet name 
                    $VnetObject = Get-AzVirtualNetwork -Name $VnetName                      # Collects vnet object
                    $SubnetObject =  Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VnetObject -Name $SubnetName                                       # Collects subnet object
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($CurrentConfig.PrivateIpAllocationMethod)
            }                                                                               # End if ($LoadBalancerObject)
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null                                              
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$SubnetObject) {                                                       # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$SubnetObject) | Inner
            }                                                                               # End if (!$SubnetObject) | Outer
            $SubnetID = $SubnetObject.ID                                                    # Isloates the subnet id
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -SubnetId $SubnetID -ErrorAction 'Stop'             # Creates the load balancer front end config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFEPriDynamicIpCon
function NewAzLBFEPriStaticIpCon {                                                          # Function to set up a private static front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                $CurrentConfig = Get-AzLoadBalancerFrontendIpConfig `
                    -LoadBalancer $LoadBalancerObject                                       # Gets the load balancer front end configurations
                if ($CurrentConfig.PrivateIpAllocationMethod) {                             # If $CurrentConfig.PrivateIpAllocationMethod has a value
                    Write-Host 'A subnet is currently in use by this load balancer'         # Write message to screen
                    Write-Host 'Getting subnet information'                                 # Write message to screen
                    $SubnetID = $CurrentConfig.Subnet.ID                                    # Isolates the subnet ID
                    $SubnetName = $SubnetID.Split('/')[-1]                                  # Isloates the subnet name
                    $VnetName = $SubnetID.Split('/')[8]                                     # Isloates the vnet name 
                    $VnetObject = Get-AzVirtualNetwork -Name $VnetName                      # Collects vnet object
                    $SubnetObject =  Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VnetObject -Name $SubnetName                                       # Collects subnet object
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($CurrentConfig.PrivateIpAllocationMethod)
            }                                                                               # End if ($LoadBalancerObject)
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null                                              
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$SubnetObject) {                                                       # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$SubnetObject) | Inner
            }                                                                               # End if (!$SubnetObject) | Outer
            $SubnetID = $SubnetObject.ID                                                    # Isloates the subnet id
            Write-Host 'Getting list of IPs already in use'                                 # Write message to screen
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on $SubnetID
            $LBList = (get-azloadbalancer | Where-Object `
                {$_.FrontendIpConfigurations.subnet.ID -eq $SubnetID})                      # Gets a list of all load balancers configurations on $SubnetID
            $LBList = $LBList.FrontendIpConfigurations
            Clear-Host                                                                      # Clears screen
            :SetAzureLBIP while ($true) {                                                   # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $NicList) {                                                  # For each item in $NicList
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $NicList)
                foreach ($_ in $LBList) {                                                   # End foreach ($_ in $LBList)
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $LBList)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Other unlisted IP addresses may be reserved'                    # Write message to screen
                Write-Host 'Unlisted and unavailable addresses will be'                     # Write message to screen
                Write-Host 'checked after submitting the requested IP'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Enter the static IP address:'                                   # Write message to screen
                $IPInput = Read-Host 'IP'                                                   # Operator input for the new IP address
                Clear-Host                                                                  # Clears screen
                Try {                                                                       # Try the following
                    $IPAvailable = Test-AzPrivateIPAddressAvailability -VirtualNetwork `
                        $VnetObject -IPAddress $IPInput -ErrorAction 'Stop'                 # Checks IP availability
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    $IPInput = $null                                                        # Clears $IPInput
                    Write-Host 'That does not appear to be a valid IP'                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End catch
                $IPAvailable = $IPAvailable.Available                                       # Isolates Available
                if ($IPInput -and $IPAvailable -eq $false) {                                # If $IPInput has a value and $IPAvailable is equal to $false
                    Write-Host 'That IP address is already in use'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($IPInput -and $IPAvailable -eq $false)
                elseif($IPInput) {                                                          # Else if $IPInput has a value
                    Write-Host 'Use:'$IPInput ' for the load balancer front end'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm -eq 'y'
                        Break SetAzureLBIP                                                  # Breaks :SetAzureLBIP
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (If $IPInput is not like '*.*.*.*'))
            }                                                                               # End :SetAzureLBIP while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -SubnetId $SubnetID -PrivateIpAddress $IPInput `
                    -ErrorAction 'Stop'                                                     # Creates the load balancer front end config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFEPriStaticIpCon
function NewAzLBFEPubIPCon {                                                                # Function to set up the front end public IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzurePublicIP while ($true) {                                               # Inner loop for selecting the public IP sku
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$PublicIPObject)
                if ($PublicIPObject.Sku.Name -ne $LBSkuObject) {                            # If $PublicIPObject.Sku.Name does not equal $LBSkuObject 
                    if ($LBSkuObject -eq 'Basic') {                                         # If $LBSkuObject equals 'Basic
                        Write-Host 'The load balancer being built'                          # Write message to screen
                        Write-Host 'is a basic sku and requires a'                          # Write message to screen
                        Write-Host 'basic public IP sku'                                    # Write message to screen
                    }                                                                       # End if ($LBSkuObject -eq 'Basic')
                    else {                                                                  # Else if $LBSkuObject equals 'standard'
                        Write-Host 'The load balancer being built'                          # Write message to screen
                        Write-Host 'is a standard sku and requires a'                       # Write message to screen
                        Write-Host 'standard public IP sku'                                 # Write message to screen 
                    }                                                                       # End else (if ($LBSkuObject -eq 'Basic'))
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Select a different public IP sku?'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No'                                  # Operator selection to choose a new public IP sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'y') {                                                # If $OpSelect equals 'y'
                        $PublicIPObject = $null                                             # Clears $PublicIPObject
                    }                                                                       # End if ($OpSelect -eq 'y')
                    else {                                                                  # Else if $OpSelect does not equal 'y'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if ($OpSelect -eq 'y')
                }                                                                           # End if ($PublicIPObject.Sku.Name -ne $LBSkuObject)
                else {                                                                      # if $PublicIPObject.IpConfiguration.Id is $null
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($PublicIPObject.Sku.Name -ne $LBSkuObject))
                if ($PublicIPObject.IpConfiguration.Id) {                                   # If $PublicIPObject.IpConfiguration.Id has a value
                    Write-Host 'The selected public IP sku is already in use'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Select a different public IP sku?'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No'                                  # Operator selection to choose a new public IP sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'y') {                                                # If $OpSelect equals 'y'
                        $PublicIPObject = $null                                             # Clears $PublicIPObject
                    }                                                                       # End if ($OpSelect -eq 'y')
                    else {                                                                  # Else if $OpSelect does not equal 'y'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if ($OpSelect -eq 'y')
                }                                                                           # End if ($PublicIPObject.IpConfiguration.Id)
                else {                                                                      # if $PublicIPObject.IpConfiguration.Id is $null
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($PublicIPObject.IpConfiguration.Id))
            }                                                                               # End :SetAzurePublicIP while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -PublicIpAddress $PublicIPObject -ErrorAction `
                    'Stop'                                                                  # Creates the load balancer front end pool
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFEPubIPCon