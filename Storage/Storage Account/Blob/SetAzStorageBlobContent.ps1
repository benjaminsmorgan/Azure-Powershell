<# 
Author - Benjamin Morgan benjamin.s.morgan@outlook.com 
Ref: {
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.1.0
    Get-AzureStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/azure.storage/get-azurestoragecontainer?view=azurermps-6.13.0
    Set-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-5.1.0
}
Required Functions: {
    GetAzResourceGroup:         Collects resource group object
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects the storage container object
}
Variables: {
    GetAzResourceGroup {
        $RGObject - Resource group object
        $RGObjectinput - Operator input for the resource group name
        $RGList - variable used for printing all resource groups to screen if needed
    }
    GetAzStorageAccount {
        $RGObject - Resource group object
        $StorageAccount - Storage account object
        $StorageAccointInput - Operator input for the sotrage account name
        $SAList - variable used for printing all storage accounts to screen if needed 
    }
    GetAzStorageContainer {
        $StorageAccount - Storage account object
        $StorageContainer - Storage container object
        $StorageContainerInput - Operator input for the storage container name
        $SCList - variable used for printing all storage containers to screen if needed 
    }
    SetAzStorageBlobContent {
        $SetTier - Operator input for access tier for blobs
        $LocalFileName - Operator input for current file location, name, and extension
        $BlobFileName - Operator input for the blob name in Azure
        $StorageContainer - Storage account object
        StorageAccount - Storage container object
    }
}
#>
Function SetAzStorageBlobContent { # Function to upload a blob (File) into an existing storage container
    Begin {
        $SetTier = $null # Clears $SetTier from all previous use
        While (-Not($SetTier -eq 'Cool' -or $SetTier -eq 'Hot')) { # Loop to continue getting an access tier that is used in azure
            $SetTier = Read-Host "Hot or Cool" # Operator input for $SetTier
            if (-Not($SetTier -eq 'Cool' -or $SetTier -eq 'Hot')) { # Error reporting if $SetTier does not match a valid value
                Write-Host "Invalid input" # Error reporting
            } # End if statment
        } # End while statement
        $LocalFileName = Read-Host "Full path and filename" # Collects the path to file, example: C:\users\Admin\Documents\Blobupload.txt
        $BlobFileName = Read-Host "New name and ext for this file" # Collects the new name and ext for the file that will be used in the storage account, example: SuperAwesomeBlob.jpg
        if (!$StorageContainer) { # Check to see if container needs to be assigned to $StorageContainer
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
            $StorageContainer = GetAzStorageContainer ($RGObject, $StorageAccount) # Calls function GetAzStorageContainer and assigns to $StorageContainer
        } # End if statment
        Set-AzStorageBlobContent -File $LocalFileName -Blob $BlobFileName -Container $StorageContainer.Name -Context $StorageAccount.Context -StandardBlobTier $SetTier # Uploads the file to azure
    } # End begin statement
} # End function
function GetAzStorageContainer { # Function to get a storage container, can pipe $StorageContainer to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        if (!$StorageAccount) { # Check to see if account needs to be assigned to $StorageAccount
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
        } # End if statement
        $StorageContainer = $null # Clears $StorageContainer from all previous use
        while (!$StorageContainer) { # Loop to continue getting a storage container until the operator provided name matches an existing container
            $StorageContainerInput = Read-Host "Storage container name" # Operator input of the storage container name
            $StorageContainer = Get-AzStorageContainer -Context $StorageAccount.Context -Name $StorageContainerInput # Collection of the storage container from the operator input
            if (!$StorageContainer) { # Error reporting if input does not match and existing container
                Write-Host "The name provided does not match an existing storage container" # Error reporting
                Write-Host "This is the list of available storage containers" # Error reporting
                $SCList = Get-AzStorageContainer -Context $StorageAccount.Context  # Collects all storage containers within $StorageAccount and assigns them to $SClist
                Write-Host "" # Error reporting
                Write-Host $SCList.Name -Separator `n # Write-host used so list is written to screen when function is used as $StorageContainer = GetAzStorageContainer
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else for when $StorageContainer is assigned
                Write-Host $StorageContainer.Name # Writes the storage account name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $StorageContainer # Returns $StorageContainer back to a calling function
    } # End of begin statement
} # End of function
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccount to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables errors
        if (!$RGObject) { # Check to see if resource group needs to be assigned to $RGObject
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        } # End if statement
        $StorageAccount = $null # Clears $StorageAccount from all previous use
        while (!$StorageAccount) { # Loop to continue getting a storage account until the operator provided name matches an existing account
            $StorageAccountInput = Read-Host "Storage account name" # Operator input of the storage account name
            $StorageAccount = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccountInput # Collection of the storage account from the operator input
            if (!$StorageAccount) { # Error reporting if input does not match and existing account
                Write-Host "The name provided does not match an existing storage account" # Error reporting
                $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts within $RGObject and assigns to $SAList
                Write-Host "" # Error reporting
                Write-Host $SAList.Storageaccountname -Separator `n # Write-host used so list is written to screen when function is used as $StorageAccount = GetAzStorageAccount
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else for when $StorageAccount is assigned
                Write-Host $StorageAccount.StorageAccountName 'Has been assigned to "$StorageAccount"' # Writes the storage account name to the screen before ending function
            } #End else statement
        } # End of while statement
        Return $StorageAccount # Returns $StorageAccount back to a calling function
    } # End of begin statement
} # End of function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function.
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        while (!$RGObject) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RGObject  # Returns the value of $RGObject to a function that called it
    } # End of begin statement
} # End of function