# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1    
} #>
<# Functions Description: {
    NewAzLBFEPriDynamicIpCon:   Creates a load balancer front end private dynamic IP configuration
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
} #>
<# Variables: {      
    :NewAzureLBFEIpConfig       Outer loop for managing function
    :SetAzureLBFEName           Inner loop for setting the front end name
    $CallingFunction:           Name of the function that called this one
    $LoadBalancerObject:        Load balancer object if present
    $CurrentConfig:             Current front end config info on $LoadBalancerObject
    $SubnetName:                Name of the subnet used by $CurrentConfig
    $VnetName:                  Name of the virtual network used bt $CurrentConfig
    $SubnetObject:              Subnet object
    $VNetObject:                Virtual network object
    $SubnetID:                  $SubnetObject.ID 
    $ValidArray:                Array of valid non first/last characters to load balancer config
    $Valid1stChar:              Array of valid first characters to load balancer config
    $ValidLastChar:             Array of valid last characters to load balancer config
    $FrontEndNameArray:         $FrontEndNameObject converted to array
    $FrontEndNameObject:        Operator input for the front end name
    $OpConfirm:                 Operator confirmation of the front end name
    $FrontEndIPConfigObject:    Front end IP config object
    GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VNetObject
} #>
<# Process Flow {
    function
        Call NewAzLBFEPriDynamicIpCon > Get $FrontEndIPConfigObject
            Call GetAzVNetSubnetConfig > Get $SubnetObject, $VNetObject
            End GetAzVNetSubnetConfig 
                Return NewAzLBFEPriDynamicIpCon > Send $SubnetObject, $VNetObject
        End NewAzLBFEPriDynamicIpCon
            Return function > Send $FrontEndIPConfigObject
}#>
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