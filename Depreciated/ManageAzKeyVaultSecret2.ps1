Function ManageAzKeyVaultSecret {
    Begin {

    } # End Begin
} # End Function ManageAzKeyVaultSecret
function GetAzKeyVaultSecretList { # Function to get a all secrets in a key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KVList = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName  # Collection of the key vault secret from the operator input
        $KVList | Select-Object Name, Enabled, Created | Format-Table # Outputs the name, Enable status, and date created. Can by changed to output other info
    } # End begin statement
} # End function
function GetAzKeyVaultSecret { # Function to get a key vault secret can pipe $KeyVaultSecret to another function.
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecret = $null # Clears $KeyVaultSecret from all previous use
        while (!$KeyVaultSecret) { # Loop to continue getting a key vault secret until the operator provided name matches an existing key vault secret
            if ($KeyVaultSecretInput) { # Check to see if a previous function passed along a secret name
                $KVSOperatorConfirm = Read-Host "Use" $KeyVaultSecretInput" secret?" # Writes the current value of $KeyVaultSecretInput
                if ($KVSOperatorConfirm -eq 'y' -or $KVSOperatorConfirm -eq 'yes') { # If statement if the operator wishes to use this secret (Statement makes no action)
                } # End of if statement
                else { # Else statement for operator to change $KeyVaultSecretInput
                    $KeyVaultSecretInput = Read-Host "KeyVault secret name" # Operator input for the key vault secret name
                } # End else statement
            }
            else { # Else statement if $KeyVaultSecretInput is empty because no value was passed, or this is a second loop
                $KeyVaultSecretInput = Read-Host "KeyVault secret name" # Operator input for the key vault secret name
            } # End else statement
            $KeyVaultSecret = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecretInput  # Collection of the key vault secret from the operator input
            if (!$KeyVaultSecret) { # Error reporting if input does not match and existing key vault secret
                Write-Host "The name provided does not match an existing key vault secret" # Error note
                Write-Host "This is the list of available key vault secrets" # Error note
                $KVSList = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName # Collects all key vault secret objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $KVSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $KeyVaultSecret = GetAzKeyVaultSecret
                Write-Host "" # Error reporting
                $KeyVaultSecretInput = $null # Reverts $KeyVaultSecretInput back to $null, used in case passed $KeyVaultSecretInput is not a valid name
            } # End if statement
            else { # Else if $KeyVaultSecret is assigned
                Write-Host $KeyVaultSecret.Name 'Has been assigned to "$KeyVaultSecret"' # Writes the key vault name secret to the screen before ending function 
            } # End else statement
        } # End while statement
        Return $KeyVaultSecret
    } # End begin statement
} # End function
function GetAzKeyVaultSecretValue { # Function to return the value of a key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $RGObject = GetAzResourceGroup
        $KeyVault = GetAzKeyVault($RGObject)
        $KeyVaultSecret = GetAzKeyVaultSecret ($KeyVault)  # Calls (Function) GetAzKeyVaultSecret to get $KeyVaultSecret
        $KeyVaultSecretValue = $null # Clears $KeyVaultSecretValue from all previous use
        $ssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KeyVaultSecret.SecretValue) # Provided by MS Azure
        try { # Provided by MS Azure
            $KeyVaultSecretValue = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ssPtr) # Provided by MS Azure
        } # Provided by MS Azure
        finally { # Provided by MS Azure
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ssPtr) # Provided by MS Azure
        } # Provided by MS Azure
        Write-Host "The value of"$KeyVaultSecret.Name "is:" $KeyVaultSecretValue # Prints secret name and value to screen
    } # End begin statement   
} # End function
function SetAzKeyVaultSecret { # Creates a new secret and value in existing key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
        $KeyVaultSecretValue = Read-Host "New key vault secret value"# Prompt for operator input for $KeyVaultSecretValue
        $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
        Set-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates new secret based off operator input
    } # End begin statement
} # End function
function RemoveAzKeyVaultSecret {
    Begin {
        #$ErrorActionPreference='silentlyContinue' # Disables errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecret = GetAzKeyVaultSecret ($KeyVault)
        $ConfirmDelete = Read-Host "Do you want to delete"$KeyVaultSecret.Name # Operator input to confirm delete
        if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
            Remove-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecret.Name -Force
            Write-Host $KeyVaultSecret.Name"has been deleted" # Confirmation message
            $KeyVaultSecret = $null # Clears $KeyVaultSecret once it has been deleted
        } # End if statement
        else { # If $ConfirmDelete is not 'y' or 'yes'
            Write-Host "No changes were made" # Confirmation message
            Break # Terminates script
        } # End else statement
    } # End begin statement
} # End function