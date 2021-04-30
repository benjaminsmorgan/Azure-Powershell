# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Update-AzADUser:            https://docs.microsoft.com/en-us/powershell/module/az.resources/update-azaduser?view=azps-5.8.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    EnableAzADuser:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/EnableAzADUser.ps1 
    DisableAzADuser:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/DisableAzADUser.ps1
    UpdateAzADUserDName:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/UpdateAzADUserDName.ps1
    UpdateAzADUserGName:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/UpdateAzADUserGName.ps1
    UpdateAzADUserSName:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/UpdateAzADUserSName.ps1
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1                
} #>
<# Functions Description: {
    UpdateAzADUser:             Management function for UpdateAzADUser functions
    EnableAzADUser:             Enables an Azure AD account
    DisableAzADuser:            Disables an Azure AD account
    UpdateAzADUserDName:        Updates an Azure AD account display name
    UpdateAzADUserGName:        Updates an Azure AD account given name
    UpdateAzADUserSName:        Updates an Azure AD account surname
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :UpdateAzureADUser          Outer loop for managing function
    $OpSelect:                  Operator input for selecting function
    EnableAzADUser{}            Enables $ADUserObject
        GetAzADUser{}               Gets $ADUserObject
    DisableAzADUser{}           Disables $ADUserObject
        GetAzADUser{}               Gets $ADUserObject
    UpdateAzADUserDName{}       Updates $ADUserObject.DisplayName
        GetAzADUser{}               Gets $ADUserObject
    UpdateAzADUserGName{}       Updates $ADUserObject.GivenName
        GetAzADUser{}               Gets $ADUserObject
    UpdateAzADUserSName{}       Updates $ADUserObject.SurName    
        GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call UpdateAzADUser > Get $null
            Call EnableAzADUser > Get $null 
                Call GetAzADUser > Get $ADUserObject
                End GetAzADUser
                    Return EnableAzADUser > Send $ADUserObject
            End EnableAzADUser
                Return UpdateAzADUser > Send $null
            Call DisableAzADUser > Get $null 
                Call GetAzADUser > Get $ADUserObject
                End GetAzADUser
                    Return DisableAzADUser > Send $ADUserObject
            End DisableAzADUser
                Return UpdateAzADUser > Send $null
            Call UpdateAzADUserDName > Get $null 
                Call GetAzADUser > Get $ADUserObject
                End GetAzADUser
                    Return UpdateAzADUserDName > Send $ADUserObject
            End UpdateAzADUserDName
                Return UpdateAzADUser > Send $null
            Call UpdateAzADUserGName > Get $null 
                Call GetAzADUser > Get $ADUserObject
                End GetAzADUser
                    Return UpdateAzADUserGName > Send $ADUserObject
            End UpdateAzADUserGName
                Return UpdateAzADUser > Send $null
            Call UpdateAzADUserSName > Get $null 
                Call GetAzADUser > Get $ADUserObject
                End GetAzADUser
                    Return UpdateAzADUserSName > Send $ADUserObject
            End UpdateAzADUserSName
                Return UpdateAzADUser > Send $null
        End UpdateAzADUser
            Return function > Send $null
}#>
function UpdateAzADUser {                                                                   # Function to manage UpdateAzADUser functions
    Begin {                                                                                 # Begin function
        :UpdateAzureADUser while ($true) {                                                  # Outer loop for managing function
            Write-Host '[1] Enable user'                                                    # Write message to screen
            Write-Host '[2] Disable user'                                                   # Write message to screen
            Write-Host '[3] Change user display name'                                       # Write message to screen
            Write-Host '[4] Change user given name'                                         # Write message to screen
            Write-Host '[5] Change user surname'                                            # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the management function
            if ($OpSelect -eq 'Exit') {                                                     # If $OpSelect equals 'exit'
                Break UpdateAzureADUser                                                     # Breaks :UpdateAzureADUser 
            }                                                                               # End if ($OpSelect -eq 'Exit')
            elseif ($OpSelect -eq '1') {                                                    # If $OpSelect equals '1'
                EnableAzADUser                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # If $OpSelect equals '2'
                DisableAzADUser                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # If $OpSelect equals '3'
                UpdateAzADUserDName                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # If $OpSelect equals '4'
                UpdateAzADUserGName                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # If $OpSelect equals '5'
                UpdateAzADUserSName                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'Exit'))
        }                                                                                   # End :UpdateAzureADUser while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function UpdateAzADUser
function EnableAzADUser {                                                                   # Function to Enable an Azure AD user account
    Begin {                                                                                 # Begin function
        $CallingFunction = 'EnableAZADUser'                                                 # Creates $CallingFunction
        :EnableAzureADUser while ($true) {                                                  # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break EnableAzureADUser                                                     # Breaks :EnableAzureADUser
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Enable account'$ADUserObject.UserPrincipalName                      # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to Enable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Update-AzADUser -UPNOrObjectId $ADUserObject.UserPrincipalName `
                        -EnableAccount $true -ErrorAction 'Stop'                            # Enables the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break EnableAzureADUser                                                 # Breaks :EnableAzureADUser
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been enabled'                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break EnableAzureADUser                                                     # Breaks :EnableAzureADUser
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break EnableAzureADUser                                                     # Breaks :EnableAzureADUser
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :EnableAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function EnableAzADUser
function DisableAzADUser {                                                                  # Function to disable an Azure AD user account
    Begin {                                                                                 # Begin function
        $CallingFunction = 'DisableAZADUser'                                                # Creates $CallingFunction
        :DisableAzureADUser while ($true) {                                                 # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break DisableAzureADUser                                                    # Breaks :DisableAzureADUser
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Disable account'$ADUserObject.UserPrincipalName                     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to disable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Update-AzADUser -UPNOrObjectId $ADUserObject.UserPrincipalName `
                        -EnableAccount $false -ErrorAction 'Stop'                           # Disables the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break DisableAzureADUser                                                # Breaks :DisableAzureADUser
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been disabled'               # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break DisableAzureADUser                                                    # Breaks :DisableAzureADUser
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break DisableAzureADUser                                                    # Breaks :DisableAzureADUser
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :DisableAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function DisableAzADUser
function UpdateAzADUserDName {                                                              # Function to update an Azure AD user account display name
    Begin {                                                                                 # Begin function
        $CallingFunction = 'UpdateAzADUserDName'                                            # Creates $CallingFunction
        :UpdateAzureADUserDName while ($true) {                                             # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break UpdateAzureADUserDName                                                # Breaks :UpdateAzureADUserDName
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Update account'$ADUserObject.UserPrincipalName                      # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to Enable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                :UpdateAzureADUserName while ($true) {                                      # Inner loop for setting the display name
                    $UpdatedName = Read-Host 'Enter new display name'                       # Operator input for the new display name
                    Write-Host $UpdatedName'is correct'
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break UpdateAzureADUserDName                                        # Breaks :UpdateAzureADUserDName    
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {
                        Break UpdateAzureADUserName                                         # Breaks :UpdateAzureADUserName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :UpdateAzureADUserName while ($true)
                Try {                                                                       # Try the following
                    Update-AzADUser -UPNOrObjectId $ADUserObject.UserPrincipalName `
                        -DisplayName $UpdatedName -ErrorAction 'Stop'                       # Updates the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break UpdateAzureADUserDName                                            # Breaks :UpdateAzureADUserDName
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been updated'                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break UpdateAzureADUserDName                                                # Breaks :UpdateAzureADUserDName
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break UpdateAzureADUserDName                                                # Breaks :UpdateAzureADUserDName
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :UpdateAzureADUserDName while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function EnableAzADUser
# Additional functions for UpdateAzADUser
function GetAzADUser {                                                                      # Function to get an Azure AD user account
    Begin {                                                                                 # Begin function
        :GetAzureADUser while ($true) {                                                     # Outer loop for managing function
            $ObjectList = Get-AzADUser                                                      # Pulls a list of all user accounts
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;`
                    'UPN'=$_.UserPrincipalName;'Loc'=$_.UsageLocation;`
                    'GName'=$_.GivenName;'SName'=$_.Surname;'DName'=$_.DisplayName;`
                    'Mail'=$_.Mail;'Enabled'=$_.AccountEnabled;'ID'=$_.Id}                  # Adds info to current $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber +1                                            # Increments $ObjectNumber up by 1                                  
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # Foreach item in $ObjectArray
                $Number = $_.Number                                                         # $Number is equal to current item .Number
                Write-Host "[$Number]" $_.UPN                                               # Write message to screen
                Write-Host 'Display Name:'$_.DName                                          # Write message to screen
                Write-Host 'Given Name:  '$_.GName                                          # Write message to screen
                Write-Host 'Surname:     '$_.SName                                          # Write message to screen
                Write-Host 'Location:    '$_.Loc                                            # Write message to screen
                if ($_.Mail) {                                                              # If current item .Mail has a value
                    Write-Host 'Email:       '$_.Mail                                       # Write message to screen
                }                                                                           # End if ($_.Mail)
                Write-Host 'Enabled:     '$_.Enabled                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureADUser while ($true) {                                              # Inner loop for selecting the user account
                if ($CallingFunction) {                                                     # If $CallingFunction has a vale
                    Write-Host 'You are selecting a user account for:'$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Select user [#]'                                     # Operator input to select the user account
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureADUser                                                    # Breaks :GetAzureADUser
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Elseif $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.number
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        $ADUserObject = Get-AzADUser -ObjectId $OpSelect.ID                 # Pulls the full AD user object
                        Clear-Host                                                          # Clears screen 
                        Return $ADUserObject                                                # Returns to calling function with $ADUserObject
                    }                                                                       # End if ($CallingFunction)
                    else {                                                                  # If $CallingFunction does not have a value
                        Break GetAzureADUser                                                # Breaks :GetAzureADUser
                    }                                                                       # End else if ($CallingFunction)
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureADUser while ($true)
        }                                                                                   # End :GetAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzADUser