# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
    Remove-AzVirtualNetworkGateway:             https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    NewAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/NewAzVNGateway.ps1
    ListAzVNGateway:            https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/ListAzVNGateway.ps1
    RemoveAzVNGateway:          https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/RemoveAzVNGateway.ps1
    GetAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/GetAzVNGateway.ps1
} #>
<# Functions Description: {
    ManageAzVNGateway:          Function to manage virtual network gateways
    NewAzVNGateway:             Function to create a virtual network gateway
    ListAzVNGateway:            Function to list virtual network gateways
    RemoveAzVNGateway:          Function to remove a virtual network gateway
    GetAzVNGateway:             Function to get virtual network gateway
} #>
<# Variables: {      
    :ManageAzureGateway         Outer loop for managing function
    $OpSelect:                  Operator input to select the management function
    NewAzVNGateway{}            Creates $GatewayObject
    ListAzVNGateway{}           Lists $GatewayObjects
    RemoveAzVNGateway{}         Removes $GatewayObject
        GetAzVNGateway{}            Gets $GatewayObject
} #>
<# Process Flow {
    function
        Call ManageAzVNGateway > Get $null
            Call NewAzVNGateway > Get $null

            End NewAzVNGateway
                Return ManageAzVNGateway > Send $null
            Call ListAzVNGateway > Get $null            
            End ListAzVNGateway
                Return ManageAzVNGateway > Send $null
            Call RemoveAzVNGateway > Get $null
                Call GetAzVNGateway > Get $GatewayObject            
                End GetAzVNGateway
                    Return RemoveAzVNGateway > Send $GatewayObject
            End RemoveAzVNGateway
                Return ManageAzVNGateway > Send $null                
            
        End ManageAzVNGateway
            Return function > Send $null
}#>
function ManageAzVNGateway {                                                                # Function to manage virtual network gateways
    Begin {                                                                                 # Begin function
        :ManageAzureGateway while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Gateways'                                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Gateway (In dev)'                                           # Write message to screen
            Write-Host '[2] List Gateways'                                                  # Write message to screen
            Write-Host '[3] Remove Gateway'                                                 # Write message to screen
            Write-Host '[4] Manage Gateway Configs (In dev)'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureGateway                                                    # Breaks :ManageAzureGateway
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Gateway'                                                    # Write message to screen
                #Function                                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Gateways'                                                  # Write message to screen
                ListAzVNGateway                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Gateway'                                                 # Write message to screen
                RemoveAzVNGateway                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Gateway Configs'                                         # Write message to screen
                #Function                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
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
}                                                                                           # End function ManageAzVNGateway
function ListAzVNGateway {                                                                  # Function to list all virtual network gateways
    Begin {                                                                                 # Begin function
        :GetAzureGateway while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering gateway info'                                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/virtualNetworkGateways'}            # Gets a list of all gateways
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No gateways present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'If the gateway was just created, please retry in 15 minutes'    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureGateway                                                       # Breaks :GetAzureGateway
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $CGateway = Get-AzVirtualNetworkGateway -Name $_.Name -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Gets current object gateway info
                $VNetName = $CGateway.IPConfigurations.Subnet.ID.Split('/')[8]              # Isolates the Vnet name
                $PubIPName = $CGateway.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]   # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$CGateway.Name;                                                  # Gateway name
                    'RG'=$CGateway.ResourceGroupName;                                       # Gateway resource group name
                    'Location'=$CGateway.Location;                                          # Gateway location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                    'GType'=$CGateway.GatewayType;                                          # Gateway type
                    'VPNType'=$CGateway.VPNType;                                            # Gateway VPN type
                    'EnableBgp'=$CGateway.EnableBgp;                                        # Gateway EnableBgp
                    'GDefaultSite'=$CGateway.GatewayDefaultSite;                            # Gateway default site
                    'SkuCap'=$CGateway.Sku.Capacity;                                        # Gateway sku capacity
                    'SkuName'=$CGateway.Sku.Name;                                           # Gateway sku name
                    'SkuTier'=$CGateway.Sku.Tier                                            # Gateway tier
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $CGateway = $null                                                           # Clears $var
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Gateway Name:   '$_.Name                                        # Write message to screen
                Write-Host 'Vnet Name:      '$_.VNet                                        # Write message to screen
                Write-Host 'Gateway RG:     '$_.RG                                          # Write message to screen
                Write-Host 'Gateway Loc:    '$_.Location                                    # Write message to screen
                Write-Host 'Pub IP Name:    '$_.PubIP                                       # Write message to screen
                Write-Host 'Gateway Type:   '$_.Gtype                                       # Write message to screen
                Write-Host 'GW VPN Type:    '$_.VPNtype                                     # Write message to screen
                Write-Host 'Gateway Sku:    '$_.SkuName                                     # Write message to screen
                if ($_.GDefaultSite) {                                                      # If $_.GDefaultSite has a value
                    Write-Host 'GW Default Site:'$_.GDefaultSite                            # Write message to screen
                }                                                                           # End if ($_.GDefaultSite) 
                else  {                                                                     # Else if $_.GDefaultSite is $null
                    Write-Host 'GW Default Site: N/A'                                       # Write message to screen
                }                                                                           # End if ($_.GDefaultSite) 
                Write-Host 'EnableBgp:      '$_.EnableBgp                                   # Write message to screen                    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureGateway                                                           # Breaks :GetAzureGateway
        }                                                                                   # End :GetAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzVNGateway
function GetAzVNGateway {                                                                   # Function to get a virtual network gateway
    Begin {                                                                                 # Begin function
        :GetAzureGateway while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering gateway info'                                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/virtualNetworkGateways'}            # Gets a list of all gateways
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No gateways present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'If the gateway was just created, please retry in 15 minutes'    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureGateway                                                       # Breaks :GetAzureGateway
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $CGateway = Get-AzVirtualNetworkGateway -Name $_.Name -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Gets current object gateway info
                $VNetName = $CGateway.IPConfigurations.Subnet.ID.Split('/')[8]              # Isolates the Vnet name
                $PubIPName = $CGateway.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]   # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$CGateway.Name;                                                  # Gateway name
                    'RG'=$CGateway.ResourceGroupName;                                       # Gateway resource group name
                    'Location'=$CGateway.Location;                                          # Gateway location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                    'GType'=$CGateway.GatewayType;                                          # Gateway type
                    'VPNType'=$CGateway.VPNType;                                            # Gateway VPN type
                    'EnableBgp'=$CGateway.EnableBgp;                                        # Gateway EnableBgp
                    'GDefaultSite'=$CGateway.GatewayDefaultSite;                            # Gateway default site
                    'SkuCap'=$CGateway.Sku.Capacity;                                        # Gateway sku capacity
                    'SkuName'=$CGateway.Sku.Name;                                           # Gateway sku name
                    'SkuTier'=$CGateway.Sku.Tier                                            # Gateway tier
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $CGateway = $null                                                           # Clears $var
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureGateway while ($true) {                                             # Inner loop for selecting the gateway
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
                    Write-Host 'Vnet Name:      '$_.VNet                                    # Write message to screen
                    Write-Host 'Gateway RG:     '$_.RG                                      # Write message to screen
                    Write-Host 'Gateway Loc:    '$_.Location                                # Write message to screen
                    Write-Host 'Pub IP Name:    '$_.PubIP                                   # Write message to screen
                    Write-Host 'Gateway Type:   '$_.Gtype                                   # Write message to screen
                    Write-Host 'GW VPN Type:    '$_.VPNtype                                 # Write message to screen
                    Write-Host 'Gateway Sku:    '$_.SkuName                                 # Write message to screen
                    if ($_.GDefaultSite) {                                                  # If $_.GDefaultSite has a value
                        Write-Host 'GW Default Site:'$_.GDefaultSite                        # Write message to screen
                    }                                                                       # End if ($_.GDefaultSite) 
                    else  {                                                                 # Else if $_.GDefaultSite is $null
                        Write-Host 'GW Default Site: N/A'                                   # Write message to screen
                    }                                                                       # End if ($_.GDefaultSite) 
                    Write-Host 'EnableBgp:      '$_.EnableBgp                               # Write message to screen                    
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the gateway for:'$CallingFunction         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the gateway
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureGateway                                                   # Breaks :GetAzureGateway
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $GatewayObject = Get-AzVirtualNetworkGateway -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full gateway object
                    Return $GatewayObject                                                   # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureGateway while ($true)
        }                                                                                   # End :GetAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzVNGateway
function RemoveAzVNGateway {                                                                # Function to remove a virtual network gateway
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVNGateway'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureGateway while ($true) {                                                 # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject does not have a value
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway
            }                                                                               # End if (!$GatewayObject)
            $VNetName = $GatewayObject.IPConfigurations.Subnet.ID.Split('/')[8]             # Isolates the Vnet name
            Write-Host 'Remove Gateway: '$GatewayObject.name                                # Write message to screen
            Write-Host 'From VNet:      '$VNetName                                          # Write message to screen
            Write-Host 'From RG:        '$GatewayObject.ResourceGroupName                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the gateway
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the gateway'                                           # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkGateway -Name $GatewayObject.Name `
                        -ResourceGroupName $GatewayObject.ResourceGroupName `
                        -Force -ErrorAction 'Stop' | Out-Null                               # Removes the gateway
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
                    Break RemoveAzureGateway                                                # Breaks :RemoveAzureGateway    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The gateway has been removed'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNGateway