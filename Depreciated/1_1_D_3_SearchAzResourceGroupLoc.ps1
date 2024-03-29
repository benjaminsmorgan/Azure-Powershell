# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroupLoc:   Gets a resource or resource group by location
    SearchAzResourceLoc:        Searches for resource using location matches on a resource
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :SearchAzureByLoc           Oiter loop for managing function
    :SelectAzureResource        Inner loop for selecting from a list of resources
    :SelectAzureRG              Inner loop for selecting from a list of resource groups
    $LocationObject:            Location object
    $CallingFunction:           Name of this function
    $OperatorSelect:            Operator input to select the search function, resource, or resource group
    $RSList:                    List of all matching resources
    $ListNumber:                $var used to select an item from $ListArray
    $ListArray:                 Array used to list an select a resource or resource group
    $ListInput:                 $var used to load info into $ListArray
    $Number:                    Current item .number used for formatting write to screen
    $RGObject:                  Resource group object
    $RGList:                    List of all matching resource groups
    SearchAzResourceLoc{}       Gets $RSObject
        GetAzLocation{}             Gets $LocationObject
    GetAzLocation{}             Gets $LocationObject
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroupLoc > Get $RGObject
            Call SearchAzResourceLoc > Get $RSObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return SearchAzResourceLoc > Send $LocationObject
            End SearchAzResourcLoc
                Return SearchAzResourceGroupLoc > Send $RSObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return SearchAzResourceGroupLoc > Send $LocationObject
        End SearchAzResourceGroupLoc
            Return Function > Send $RGObject
}#>
function SearchAzResourceGroupLoc {                                                         # Function to search for a resource group by resource or group location
    Begin {                                                                                 # Begin function
        :SearchAzureByLoc while ($true) {                                                   # Outer loop for managing function
            if (!$LocationObject) {                                                         # If $LocationObject does not have a value
                $CallingFunction = 'SearchAzResourceGroupLoc'                               # Creates $CallingFunction
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject does not have a value
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End (Inner) if (!$LocationObject)
            }                                                                               # End (Outer) if (!$LocationObject)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Find Resource'                                                  # Write message to screen
            Write-Host '[2] Find Resource Group'                                            # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for the search option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break SearchAzureByLoc                                                      # End Break SearchAzureByLoc
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                $RSObject = SearchAzResourceGroupLoc ($CallingFunction)                     # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureByLoc                                                  # Breaks :SearchAzureByLoc
                }                                                                           # End if (!$RSObject)
                else {                                                                      # If $RSObject does have a value
                    $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName       # Pulls the resource group object
                    Clear-Host                                                              # Clears the screen
                    Return $RGObject                                                        # Returns to calling function with $var
                }                                                                           # End else (if (!$RSObject))
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                $RGList = Get-AzResourceGroup | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Gets a list of all resources within the $LocationObject.Location
                if (!$RGList) {                                                             # If $RGList is $null
                    Write-Host 'No resource groups found in'$LocationObject.Location        # Write message to screen
                    Start-Sleep(5)                                                          # Pauses all actions for 5 seconds
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End if (!$RGList)
                elseif ($RGList.Count -gt 1) {                                              # If $RGList.Count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the $ListArray
                    foreach ($_ in $RGList) {                                               # For each $_ in $RGList
                        $ListInput = [PSCustomObject]@{'RG'=$_.ResourceGroupName; `
                            'Number'=$ListNumber}                                           # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $ProviderList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.number                                                 # $Number equals current item .Number
                        Write-Host "[$Number]" $_.RG                                        # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRG while ($true) {                                          # Inner loop for selecting a resource from list
                        $OperatorSelect = Read-Host 'Enter the resource group [#]'          # Operator input to select the resource
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals '0'
                        Break SearchAzureByLoc                                              # End Break SearchAzureByLoc
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -in $ListArray.Number) {                    # Else if $OperatorSelect -in $ListArray.Number
                            $RGObject = $ListArray | Where-Object `
                                {$_.Number -eq $OperatorSelect}                             # $RGObject equals $ListArray where $OperatorSelect equals $ListArray.Number
                            $RGObject = Get-AzResourceGroup -name $RGObject.RG              # Pulls the full resource group object
                            Clear-Host                                                      # Clears the screen
                            Return $RGObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End elseif ($OperatorSelect -in $ListArray.Number)
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzureRG while ($true) 
                }                                                                           # End elseif ($RGList.Count -gt 1)
                else {                                                                      # If $RGList has only a single item
                    $RGObject = Get-AzResourceGroup -name $RGList.Name                      # Pulls the full resource group object
                    Clear-Host                                                              # Clears the screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End else (if (!$RGList))
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # All other inputs for $OperatorSelect 
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :SearchAzureByLoc while ($true)
        Clear-Host                                                                          # Clears the screen 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End SearchAzResourceGroupLoc