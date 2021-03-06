# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Set-AzureADUser:            https://docs.microsoft.com/en-us/powershell/module/azuread/set-azureaduser?view=azureadps-2.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1                
} #>
<# Functions Description: {
    UpdateAzADUserGName:        Updates an Azure AD account given name
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :UpdateAzureADUserGName     Outer loop for managing function
    :UpdateAzureADUserName      Inner loop for confirming the new name
    $CallingFunction:           Name of this function
    $ADUserObject:              Azure AD account object
    $OpConfirm:                 Operator confirmation to update
    $UpdatedName:               New given name for update
    GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call UpdateAzADUserGName > Get $null 
            Call GetAzADUser > Get $ADUserObject
            End GetAzADUser
                Return UpdateAzADUserGName > Send $ADUserObject
        End UpdateAzADUserGName
            Return function > Send $null
}#>
function UpdateAzADUserGName {                                                              # Function to update an Azure AD user account given name
    Begin {                                                                                 # Begin function
        $CallingFunction = 'UpdateAzADUserGName'                                            # Creates $CallingFunction
        :UpdateAzureADUserGName while ($true) {                                             # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break UpdateAzureADUserGName                                                # Breaks :UpdateAzureADUserGName
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Update account'$ADUserObject.UserPrincipalName                      # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to Enable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                :UpdateAzureADUserName while ($true) {                                      # Inner loop for setting the display name
                    $UpdatedName = Read-Host 'Enter new given (First) name'                 # Operator input for the new display name
                    Write-Host $UpdatedName'is correct'                                     # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of new name
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break UpdateAzureADUserGName                                        # Breaks :UpdateAzureADUserGName    
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                        $ADUSERObject.GivenName = $UpdatedName                              # Changes the $ADUserObject.GivenName to $Updated name
                        Break UpdateAzureADUserName                                         # Breaks :UpdateAzureADUserName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :UpdateAzureADUserName while ($true)
                Try {                                                                       # Try the following
                    Set-AzureADUser -ObjectId $ADUserObject.ID -GivenName `
                        $ADUserObject.GivenName -ErrorAction 'Stop'                         # Updates the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break UpdateAzureADUserGName                                            # Breaks :UpdateAzureADUserGName
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been updated'                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break UpdateAzureADUserGName                                                # Breaks :UpdateAzureADUserGName
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break UpdateAzureADUserGName                                                # Breaks :UpdateAzureADUserGName
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :UpdateAzureADUserGName while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function UpdateAzADUserGName