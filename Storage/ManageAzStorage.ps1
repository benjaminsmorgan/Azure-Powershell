# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    ManageAzStorageAccount:     TBD
    NewAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/NewAzStorageAccount.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    RemoveAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/RemoveAzStorageAccount.ps1
    ManageAzStorageContainer:   TBD
    NewAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/NewAzStorageContainer.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    RemoveAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/RemoveAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    ManageAzStorageAccount:     Management function for storage accounts
    NewAzStorageAccount:        Creates new storage account object
    GetAzStorageAccount:        Collects the storage account object
    RemoveAzStorageAccount:     Removes the selected storage account
    GetAzStorageAccount:        Collects the storage account object
    ManageAzStorageContainer:   Management function for storage containers
    NewAzStorageContainer:      Creates new storage container(s) in a storage account 
    GetAzStorageContainer:      Collects storage container in a storage account  
    RemoveAzStorageContainer:   Removes existing storage container
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    ManageAzStorage {
        ManageAzStorageAccount {
            :ManageAzureStorageAcc      Outer loop for function
            $ManageAzStorageAcc:        Operator input for choosing sub function
            NewAzStorageAccount{
                :NewAzureStorageAcc         Outer loop for function
                :SetAzureStorageAccName     Inner loop for setting name
                :SetAzureStorageAccSku      Inner loop for setting sku
                :SetAzureStorageAccLoc      Inner loop for setting location
                $OperatorConfirm:           Operator input to confirm previous inputs
                $RGObject:                  Resource group object
                $StorageAccNameInput:       Operator input for name
                $ValidSku:                  List of valid skus for storage accounts
                $StorageAccSkuInput:        Operator input for sku
                $ValidLocation:             List of valid azure locations
                $StorageAccLocInput:        Operator input for location
                $StorageAccObject:          New storage account object
                GetAzResourceGroup {
                    $RGObject:                  Resource group object
                    $RGObjectInput:             Operator input for the resource group name
                    $RGList:                    Variable used for printing all resource groups to screen if needed
                } End GetAzResourceGroup
            } End NewAzStorageAccount
            GetAzStorageAccount{
                :GetAzureStorageAccByName   Outer loop for managing funciton
                :GetAzureStorageAcc         Inner loop for getting the storage account
                $RGObject:                  Resource group object
                $StorageAccObjectInput:     Operator input for the name of the storage account
                $SAList:                    List of all storage accounts within $RGObject
                $StorageAccObject:          Storage account object    
                GetAzResourceGroup {
                    $RGObject:                  Resource group object
                    $RGObjectInput:             Operator input for the resource group name
                    $RGList:                    Variable used for printing all resource groups to screen if needed
                } End GetAzResourceGroup
            } End GetAzStorageAccount
            RemoveAzStorageAccount{
                :RemoveAzureStorageAcc      Outer loop for managing function
                $StorageAccObject:          Storage account object 
                $StoreAccName:              Storage account object name
                $OperatorConfirm:           Operator confirmation to remove the storage account
                $RSObject:                  Resource object
                $RGObject:                  Resource group object
                $Locks:                     Locks on the storage account   
                GetAzResourceGroup {
                    $RGObject:                  Resource group object
                    $RGObjectInput:             Operator input for the resource group name
                    $RGList:                    Variable used for printing all resource groups to screen if needed
                } End GetAzResourceGroup
                GetAzResourceLocksAll {
                    $RGObject:              Resource group object
                    $RSObject:              Resource object
                    $Locks:                 Locks object
                } End GetAzResourceLocksAll
                RemoveAzResourceLocks {
                    $Locks:                 Lock or locks object
                } End RemoveAzResourceLocks    
            } End RemoveAzStorageAccount
        } End ManageAzStorageAccount
        ManageAzStorageContainer {
            :ManageAzureStorageCon      Outer loop for function
            $ManageAzStorageCon:        Operator input for choosing sub function
            NewAzStorageContainer {
                :NewAzureStorageCon         Outer loop for function
                :SetAzureStorageConName     Inner loop for setting storage account name
                :SetAzureStorageConRights   Inner loop for setting the rights level
                $StorageAccObject:          Storage account object for new containers
                $StorageConNameInput:       Operator input for the container names
                $StorageConName:            Non-string $Var of $StorageConNameInput
                $StorageConNameSplit:       List of $StorageConName seperated by [Space]
                $ValidRights:               List of valid rights input
                $StorageConRightsInput:     Operator input for the rights level
                GetAzStorageAccount{
                    :GetAzureStorageAccByName   Outer loop for managing funciton
                    :GetAzureStorageAcc         Inner loop for getting the storage account
                    $RGObject:                  Resource group object
                    $StorageAccObjectInput:     Operator input for the name of the storage account
                    $SAList:                    List of all storage accounts within $RGObject
                    $StorageAccObject:          Storage account object    
                    GetAzResourceGroup {
                        $RGObject:                  Resource group object
                        $RGObjectInput:             Operator input for the resource group name
                        $RGList:                    Variable used for printing all resource groups to screen if needed
                    } End GetAzResourceGroup
                } End GetAzStorageAccount
            } End NewAzStorageContainer
            GetAzStorageContainer{
                :GetAzureStorageContainer   Outer loop for managing function
                :GetAzureStorageConName     Inner loop for getting the storage container
                $StorageAccObject:          Storage account object    
                $StorageConNameInput:       Operator input for the storage container name
                $StorageConObject:          Storage container object
                $StorageConList:            List of all containers in storage account
                GetAzStorageAccount{
                    :GetAzureStorageAccByName   Outer loop for managing funciton
                    :GetAzureStorageAcc         Inner loop for getting the storage account
                    $RGObject:                  Resource group object
                    $StorageAccObjectInput:     Operator input for the name of the storage account
                    $SAList:                    List of all storage accounts within $RGObject
                    $StorageAccObject:          Storage account object    
                    GetAzResourceGroup {
                        $RGObject:                  Resource group object
                        $RGObjectInput:             Operator input for the resource group name
                        $RGList:                    Variable used for printing all resource groups to screen if needed
                    } End GetAzResourceGroup
                } End GetAzStorageAccount
            } End GetAzStorageContainer
            RemoveAzStorageContainer{
                :RemoveAzureStorageCon      Outer loop for managing function
                $StorageConObject:          Storage container object
                $OperatorConfirm:           Operator confirmation to remove the storage container
                GetAzStorageContainer {
                    :GetAzureStorageContainer   Outer loop for managing function
                    :GetAzureStorageConName     Inner loop for getting the storage container
                    $StorageAccObject:          Storage account object    
                    $StorageConNameInput:       Operator input for the storage container name
                    $StorageConObject:          Storage container object
                    $StorageConList:            List of all containers in storage account
                    GetAzStorageAccount{
                        :GetAzureStorageAccByName   Outer loop for managing funciton
                        :GetAzureStorageAcc         Inner loop for getting the storage account
                        $RGObject:                  Resource group object
                        $StorageAccObjectInput:     Operator input for the name of the storage account
                        $SAList:                    List of all storage accounts within $RGObject
                        $StorageAccObject:          Storage account object    
                        GetAzResourceGroup {
                            $RGObject:                  Resource group object
                            $RGObjectInput:             Operator input for the resource group name
                            $RGList:                    Variable used for printing all resource groups to screen if needed
                        } End GetAzResourceGroup
                    } End GetAzStorageAccount
                } End GetAzStorageContainer
            } End RemoveAzStorageContainer      
        } End ManageAzStorageContainer
} #>
<# Process Flow {
    function
        Call ManageAzStorage > Get $null
            Call ManageAzStorageAccount > Get $null
                Call NewAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzStorageAccount > Send $RGObject
                End NewAzStorageAccount 
                    Return Function > Send $StorageAccObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return ManagageAzStorageAccount > Send $StorageAccObject
                Call RemoveAzStorageAccount > Get $null
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return RemoveAzStorageAccount > Send $StorageAccObject
                End RemoveAzStorageAccount
                    Return ManageAzStorageAccount > Send $Null
            End ManageAzStorageAccount
                Return ManageAzStorage > Send $null
            Call ManageAzStorageContainer > Get $null
                Call NewAzStorageContainer > Get $null
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return Function > Send $StorageAccObject
                    End NewAzStorageContainer 
                        Return ManageStorageContainer > Send $null
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return ManageAzStorageContainer > Send $StorageConObject, $StorageAccObject
                Call RemoveAzStorageContainer > Get $null
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                    End RemoveAzStorageContainer      
                        Return ManageAzStorageContainer > Send $null
                End ManageAzStorageContainer
                    Return ManageAzStorage > Send $null
            End ManageAzStorage
                Return Function > Send $null
}#>
function ManageAzStorage {
    Begin {
        :ManageAzureStorage while ($true) { # :ManageAzureStorage named loop to select search function
            Write-Host "Azure Storage Management" # Write message to screen
            Write-Host "1 Manage Storage Accounts" # Write message to screen
            Write-Host "2 Manage Storage Containers" # Write message to screen
            Write-Host "3 Manage Blobs" # Write message to screen
            Write-Host "4 Manage File Shares" # Write message to screen
            Write-Host "5 Manage Key Vaults" # Write message to screen
            Write-Host "6 Manage Disks" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorage = Read-Host "Option?" # Collects operator input on $ManageAzStorage option
            if ($ManageAzStorage -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorage # Ends :ManageAzureStorage loop, leading to return statement
            } # End if ($ManageAzStorage -eq 'exit')
            elseif ($ManageAzStorage -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Manage Storage Accounts" # Write message to screen
                $StorageAccObject = ManageAzStorageAccount ($RGObject, $RSObject)
            } # End elseif ($ManageAzStorage -eq '1')
            elseif ($ManageAzStorage -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Manage Storage Containers" # Write message to screen
                $StorageConObject = ManageAzStorageContainer ($RGObject, $RSObject, $StorageAccObject)
                Write-Host $StorageConObject
            } # End elseif ($ManageAzStorage -eq '2')
            elseif ($ManageAzStorage -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Manage Blobs" # Write message to screen
                
            } # End elseif ($ManageAzStorage -eq '3')
            elseif ($ManageAzStorage -eq '4') { # Elseif statement for managing file shares
                Write-Host "Manage File Shares" # Write message to screen
                
            } # End elseif ($ManageAzStorage -eq '4')
            elseif ($ManageAzStorage -eq '5') { # Elseif statement for managing keyvaults
                Write-Host "Manage Key Vaults" # Write message to screen
                
            } # End elseif ($ManageAzStorage -eq '5')
            elseif ($ManageAzStorage -eq '6') { # Elseif statement for managing disks
                Write-Host "Manage Disks" # Write message to screen
                
            } # End elseif ($ManageAzStorage -eq '6')
            Write-Host $RGObject.ResourceGroupName
            Write-Host $RSObject.Name
            Write-Host $StorageAccObject.StorageAccountName
            Write-Host $StorageConObject.Name
        } # End ManageAzureStorage while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function ManageAzStorageAccount {
    Begin {
        :ManageAzureStorageAcc while ($true) { # :ManageAzureStorageAcc named loop to select search function
            Write-Host "Azure Storage Account Management" # Write message to screen
            Write-Host "1 New Storage Account" # Write message to screen
            Write-Host "2 Get Storage Account" # Write message to screen
            Write-Host "3 Remove Storage Account" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageACC = Read-Host "Option?" # Collects operator input on $ManageAzStorageACC option
            if ($ManageAzStorageACC -eq 'exit') { # Exit if statement for this function
                if ($StorageAccObject) { # If $StorageAccObject is not $null
                    Return $StorageAccObject # Returns $StorageAccObject to calling function
                } # End if ($StorageAccObject)
                Break ManageAzureStorageAcc # Ends :ManageAzureStorageAcc loop, leading to return statement
            } # End if ($ManageAzStorageACC -eq 'exit')
            elseif ($ManageAzStorageACC -eq '1') { # Elseif statement for creating storage accounts
                Write-Host "New Storage Account" # Write message to screen
                $StorageAccObject = NewAzStorageAccount ($RSObject, $RGObject) # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '1')
            elseif ($ManageAzStorageACC -eq '2') { # Elseif statement for getting storage accounts
                Write-Host "Get Storage Account" # Write message to screen
                $StorageAccObject = GetAzStorageAccount ($RSObject, $RGObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '2')
            elseif ($ManageAzStorageACC -eq '3') { # Elseif statement for removing storage accounts
                Write-Host "Remove Storage Accounts" # Write message to screen
                RemoveAzStorageAccount  # Calls function
            } # End elseif ($ManageAzStorageACC -eq '3')
            elseif ($ManageAzStorageACC -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageACC -eq '0')
            else { # All other inputs for $ManageAzStorageAcc
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageACC -eq 'exit'))
        } # End ManageAzureStorageAcc while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageAccount
function NewAzStorageAccount { # Creates a new storage account
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureStorageAcc while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureStorageAccName while ($true) { # Inner loop for setting the storage account name
                $StorageAccNameInput = '000100000000001000000' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of account name
                    [ValidatePattern('^[a-z,0-9]+$')][ValidateLength (3, 24)]$StorageAccNameInput = [string](Read-Host "New storage account name").ToLower() # Operator input for the account name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The provided name was not valid characters in length and use numbers and lower-case letters only"} # Error message for failed try
                if ($StorageAccNameInput -eq 'exit') { # $StorageAccNameInput is equal to exit
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # if ($StorageAccNameInput -eq 'exit')
                elseif ($StorageAccNameInput -eq '000100000000001000000') {}# Elseif when Try statement fails
                else { # If Try statement input has value not equal to exit
                    Write-Host $StorageAccNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccName # Breaks SetAzureStorageAccName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($StorageAccNameInput -eq 'exit'))
            } # :SetAzureStorageAccName while ($true)
            $ValidSku = 'Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', 'Standard_ZRS', 'Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', 'Standard_RAGZRS' # Current list of all skus
            :SetAzureStorageAccSku while ($true) { # Inner loop for setting the sku
                $StorageAccSkuInput = Read-Host "New storage account sku" # Operator input for the sku
                if ($StorageAccSkuInput -eq 'exit') { # If $StorageAccSkuInput -eq 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageACC loop
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccSkuInput -cin $ValidSku) { # If $StorageAccSkuInput is in $ValidSku (Case sensitive)
                    Write-Host $StorageAccSkuInput # Writes $StorageAccSkuInput to screen
                    $OperatorConfirm = Read-Host "Is the Sku correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccSku # Breaks :SetAzureStorageAccSku
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccNameInput -iin $ValidSku)
                else { # Else for all other inputs 
                    Write-Host "The Sku name provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidSku -Separator `n # Write $ValidSku list to screen
                } # End else (if ($StorageAccNameInput -iin $ValidSku))
            } # End :SetAzureStorageAccSku while
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureStorageAccLoc while ($true) { # Inner loop for setting the account location
                $StorageAccLocInput = Read-Host "New storage account location" # Operator input for the account location
                if ($StorageAccLocInput -eq 'exit') { # If $StorageAccLocInput is 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageAcc
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccLocInput -iin $ValidLocation.Location) { # if $StorageAccLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $StorageAccLocInput # Write $StorageAccLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccLoc # Breaks :SetAzureStorageAccLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccLocInput -iin $ValidLocation)
                else { # All other inputs for $StorageAccLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($StorageAccLocInput -iin $ValidLocation))
            } # End :SetAzStorageAccLoc while ($true)
            $StorageAccObject = New-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Location $StorageAccLocInput -Name $StorageAccNameInput -SkuName $StorageAccSkuInput # Creates the new storage account and assigns to $StorageAccObject
            Return $StorageAccObject # Returns $var to calling function
        } # End :NewAzureStorageAcc while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzStorageAccount
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            :GetAzureStorageAcc while ($true) { # Loop to continue getting a storage account until the operator provided name matches an existing account
                $StorageAccObjectInput = Read-Host "Storage account name" # Operator input of the storage account name
                if ($StorageAccObjectInput -eq 'exit') { # If $StorageAccObjectInput is 'exit
                    Break GetAzureStorageAccByName # Break :GetAzureStorageAccByName
                } # Endif ($StorageAccObjectInput -eq 'exit')
                $StorageAccObject = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccObjectInput # Collection of the storage account from the operator input
                if (!$StorageAccObject) { # Error reporting if input does not match and existing account
                    Write-Host "The name provided does not match an existing storage account" # Error reporting
                    $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts within $RGObject and assigns to $SAList
                    Write-Host "" # Error reporting
                    Write-Host $SAList.Storageaccountname -Separator `n # Write-host used so list is written to screen when function is used as $StorageAccObject = GetAzStorageAccount
                    Write-Host "" # Error reporting
                } # End (!$StorageAccObject)
                else { # Else for when $StorageAccObject is assigned
                    Write-Host $StorageAccObject.StorageAccountName 'Has been assigned to "$StorageAccObject"' # Writes the storage account name to the screen before ending function
                    Return $StorageAccObject # Returns $var to calling function
                } #End else ((!$StorageAccObject))
            } # End :GetAzureStorageAcc while ($true)
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function RemoveAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :RemoveAzureStorageAcc while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            else { # Else for when $StorageAccObject is assigned
                $StoreAccName = $StorageAccObject.StorageAccountName # Collects the name of the storage account and assigns to own $var
                $OperatorConfirm = Read-Host "Remove the following storage account" $StorageAccObject.StorageAccountName "in" $StorageAccObject.ResourceGroupName # Operator confimation to remove the storage account
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                Write-Host "Checking for resource locks" # Write message to screen
                $RSObject = Get-AzResource -Name $StorageAccObject.StorageAccountName -ResourceGroupName $StorageAccObject.ResourceGroupName # Collects the $RSObject 
                $RGObject = Get-AzResourceGroup -Name $StorageAccObject.ResourceGroupName # Collects the $RGObject
                $Locks = GetAzResourceLocksAll ($RSObject, $RGObject) #Calls function and assigns to $var
                if ($Locks) { # If $Locks is not $null
                    RemoveAzResourceLocks ($Locks) # Calls function assigns $null
                } # End if ($Locks)
                else { # If $Locks is $null
                    Write-Host "No locks present on this storage account" # Write message to screen
                } # End else (if ($Locks))
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageAccount -ResourceGroupName $StorageAccObject.ResourceGroupName -AccountName $StorageAccObject.StorageAccountName -Force -ErrorAction Stop # Removes storage account, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "The storage account was not deleted" # Write message to screen
                    if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope) { # If a lock exists on the resource group
                        Write-Host "There are locks on the resource group that must be removed before this storage account can be removed" # Write message to screen
                    } # End if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope)
                    else { # All other results for failing to remove the storage account
                        Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    } # End else (if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope))
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreAccName" has been removed" # Write message to screen
                Return # Returns to calling function
            } # End else ((!$StorageAccObject))
        } # End :RemoveAzureStorageAcc while ($true)
        Write-Host "No changes made"
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function ManageAzStorageContainer {
    Begin {
        :ManageAzureStorageCon while ($true) { # :ManageAzureStorageCon named loop to select search function
            Write-Host "Azure Storage Container Management" # Write message to screen
            Write-Host "1 New Storage Container" # Write message to screen
            Write-Host "2 Get Storage Container" # Write message to screen
            Write-Host "3 Remove Storage Container" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageCon = Read-Host "Option?" # Collects operator input on $ManageAzStorageCon option
            if ($ManageAzStorageCon -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageCon # Ends :ManageAzureStorageCon loop, leading to return statement
            } # End if ($ManageAzStorageCon -eq 'exit')
            elseif ($ManageAzStorageCon -eq '1') { # Elseif statement for creating storage Containers
                Write-Host "New Storage Container" # Write message to screen
                NewAzStorageContainer ($RSObject, $RGObject, $StorageAccObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageCon -eq '1')
            elseif ($ManageAzStorageCon -eq '2') { # Elseif statement for getting storage Containers
                Write-Host "Get Storage Container" # Write message to screen
                $StorageAccObject = GetAzStorageContainer ($RSObject, $RGObject, $StorageAccObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageContainerName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageCon -eq '2')
            elseif ($ManageAzStorageCon -eq '3') { # Elseif statement for removing storage Containers
                Write-Host "Remove Storage Containers" # Write message to screen
                RemoveAzStorageContainer  # Calls function
            } # End elseif ($ManageAzStorageCon -eq '3')
            elseif ($ManageAzStorageCon -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageCon -eq '0')
            else { # All other inputs for $ManageAzStorageCon
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageCon -eq 'exit'))
        } # End ManageAzureStorageCon while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageContainer
function NewAzStorageContainer { # Creates new storage container(s) in a storage account
    Begin {
        :NewAzureStorageCon while ($true) { # Outer loop for function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) { # Inner loop for setting storage account name
                Try { # First validation of the storage container name or names
                    Write-Host "Storage container names must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    Write-Host "To create multiple containers in this storage account, enter each name seperated by a [Space]" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = [string](Read-Host "Storage account name or names").ToLower() # Operator input for the container names
                } # End Try 
                catch { # Catch for failing to meet character validation of the container names
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name(s) were not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $StorageConNameInput = '0' # Sets $StorageConNameInput value to a failed check to reset loop
                } # End Catch
                if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($StorageConNameInput -eq '0')
                elseif ($StorageConNameInput.Length -le 2) { # If unsplit $StorageConNameInput is 2 or less characters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                } # End elseif ($StorageConNameInput.Length -le 2)
                else { # Inital validation checks passed, performing secondary validation
                    $StorageConName = $StorageConNameInput # Creats $StorageConName $Var
                    if ($StorageConName -eq 'exit') { # If $StorageConName equals exit
                        Break NewAzStorageAccount # Breaks :NewAzStorageAccount
                    } # End if ($StorageConNameInput -eq 'exit')
                    $StorageConNameSplit = $StorageConName.split() # Creates $StorageConNameSplit, a list of names for each space in $StoreConName
                    foreach ($_ in $StorageConNameSplit) { # Performs length check on all names in list
                        if ($_.length -le 2) { # If $StoreConNameSplit.listitem is 2 or less charaters
                            Write-Host "***Error***" # Write message to screen
                            Write-Host $_ "is not a valid name" # Write message to screen
                            Write-Host "***Error***" # Write message to screen
                            $StorageConNameInput = '0'# Sets $StorageConNameInput value to a failed check to reset loop
                            $StorageConNameSplit = $null # Sets $StorageConNameSplit to $null
                        } # End if ($_.length -le 2)
                    } # End foreach ($_ in $StorageConNameSplit) 
                    if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                        Write-Host " " # Writes a message to screen, last action before restarting loop
                    } # End if ($StorageConNameInput -eq '0')
                    else { # All validation passed
                        if ($StorageConNameSplit.count -gt 1) { # If $StorageConNameSplit has more than one value
                            Write-Host "Create multiple storage containers with the following names" # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n # Writes all names to screen
                        } # End if ($StorageConNameSplit.count -gt 1)
                        else { # If $StorageConNameSplit has 1 value
                            Write-Host "Create a single storage account named"$StorageConName # Write message to screen
                            $StorageConNameSplit = $null  # Sets $StorageConNameSplit to $null
                        } # End else (if ($StorageConNameSplit.count -gt 1))
                        $OperatorConfirm = Read-Host "Yes or No" # Operator input for approving the name
                        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                            Break SetAzureStorageConName # Breaks :SetAzureStorageConName
                        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    } # End else (if ($StorageConNameInput -eq '0'))
                } # End else (if ($StorageConNameInput -eq '0'))
            } # End :SetAzureStorageConName while ($true)
            Write-Host "Container - Provides full read access to a container and its blobs." # Write message to screen
            Write-Host "Blob      - Provides read access to blob data throughout a container through" # Write message to screen
            Write-Host "            anonymous request, but does not provide access to container data." # Write message to screen
            Write-Host "Off       - Which restricts access to only the storage account owner." # Write message to screen
            $ValidRights = 'Container', 'Blob', 'Off' # List of valid rights input
            :SetAzureStorageConRights while ($true) { # Inner loop for setting the rights level
                $StorageConRightsInput = Read-Host "Container rights level" # Operator input for the rights level
                if ($StorageConRightsInput -eq 'exit') { # If $StorageConRightsInput is equal to 'exit'
                    Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                } # End if ($StorageConRightsInput -eq 'exit')
                elseif ($StorageConRightsInput -iin $ValidRights) { # If $StorageConRightsInput is in $ValidRights list
                    Break SetAzureStorageConRights # Breaks :SetAzureStorageConRights
                } # End elseif ($StorageConRightsInput -iin $ValidRights)
                else { # All other inputs for $StorageConRightsInput
                    Write-Host 'That was not a valid input'# Write message to screen
                    Write-Host 'please select from the following'# Write message to screen
                    Write-Host $ValidRights -Separator `n # Writes $ValidRights list to screen
                } # End else (if ($StorageConRightsInput -eq 'exit'))
            } # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit) { # If StorageConNameSplit is not $null
                Write-Host "Creating storage containers, this may take a minute"# Write message to screen
                $StorageConNameSplit | New-AzStorageContainer -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates the storage containers
            } # End if ($StorageConNameSplit) 
            else { # If $StorageConNameSplit is $null
                New-AzStorageContainer -Name $StorageConName -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates to storage container
            } # End else (if ($StorageConNameSplit) )
            Return # Returns to calling function empty
        } # End :NewAzureStorageCon while ($true)
    } # End begin
} # End NewAzStorageContainer
function GetAzStorageContainer { # Collects storage container in a storage accoun
    Begin {
        $ErrorActionPreference='silentlyContinue'
        $StorageConObject = $null # Clears $StorageConObject from all previous use
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :GetAzureStorageConName while ($true) { # Inner loop for getting the storage container
                if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) { # Checks for a ReadOnly lock on the owning resource group
                    Write-Host "There is a ReadOnly lock on"$StorageAccObject.ResourceGroupName"that is preventing the search of the storage container" # Write message to screen
                    Write-Host "This will need to be removed or converted to a CanNotDeleteLock" # Write message to screen
                    Break GetAzureStorageContainer # Break :GetAzureStorageContainer
                } # End if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) 
                $StorageConNameInput = Read-Host "Storage container name" # Operator input for the storage container name
                if ($StorageConNameInput -eq 'exit') { # If $StorageConNameInput is 'exit'
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($StorageConNameInput -eq 'exit')
                if (!$StorageConNameInput) { # If $StorageConNameInput is $null
                    $StorageConNameInput = '0' # Sets a value that cannot be an existing storage container name
                } # End if (!$StorageConNameInput)
                $StorageConObject = Get-AzStorageContainer -Name $StorageConNameInput -Context $StorageAccObject.Context # Gets the storage container and assigns to $StorageConObject
                if ($StorageConObject) { # If $StorageConObject has a value
                    Return $StorageConObject, $StorageAccObject # Returns $StorageConObject to calling function
                } # End if ($StorageConObject)
                else { # If $StorageConObject is empty
                    Write-Host "The name provided does not match and existing storage container" # Write message to screen
                    $StorageConList = Get-AzStorageContainer -Context $StorageAccObject.Context # Gets list of all containers in storage account
                    Write-Host $StorageConList.Name -Separator `n # Writes $StorageConList list to screen
                    Write-Host " " # Write message to screen
                    Write-Host "Please re-enter the storage container name" # Write message to screen
                } # End else (if ($StorageConObject))
            } # End :GetAzureStorageConName while ($true)
        } # End :GetAzureStorageContainer while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzStorageContainer
function RemoveAzStorageContainer { # Removes existing storage container
    Begin {
        :RemoveAzureStorageCon while ($true) { # Outer loop for function
            <#if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject) #>
            if (!$StorageConObject) { # If $StorageConObject is $null
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                    if (!$StorageConObject) { # If $StorageConObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            Write-Host "***WARNING RESOURCELOCKS WILL NOT PROTECT THIS STORAGECONTAINER FROM BEING DELETED***"
            $OperatorConfirm = Read-Host "Remove the following storage container" $StorageConObject.Name "in" $StorageAccObject.StorageAccountName # Operator confimation to remove the storage container
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageCon
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                $StoreConName = $StorageConObject.Name
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name $StorageConObject.Name -Force -ErrorAction Stop # Removes storage container, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreConName" has been removed" # Write message to screen
                Return # Returns to calling function
        } # End :RemoveAzureStorageCon while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzStorageContainer
function ManageAzStorageBlob { # Manages storage blob functions
    Begin {
        :ManageAzureStorageBlob while ($true) { # :ManageAzureStorageBlob named loop to select search function
            Write-Host "Azure Storage Blob Management" # Write message to screen
            Write-Host "1 Add Storage Blob" # Write message to screen
            Write-Host "2 List Storage Blobs" # Write message to screen
            Write-Host "3 Download Storage Blobs" # Write message to screen
            Write-Host "4 Remove Storage Blobs" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageBlob = Read-Host "Option?" # Collects operator input on $ManageAzStorageBlob option
            if ($ManageAzStorageBlob -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageBlob # Ends :ManageAzureStorageBlob loop, leading to return statement
            } # End if ($ManageAzStorageBlob -eq 'exit')
            elseif ($ManageAzStorageBlob -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Add Storage Blob" # Write message to screen
                $StorageBlobObject = SetAzStorageBlobContent ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '1')
            elseif ($ManageAzStorageBlob -eq '2') { # Elseif statement for managing storage containers
                Write-Host "List Storage Blobs" # Write message to screen
                $StorageBlobObject, $StorageAccObject, $StorageConObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '2')
            elseif ($ManageAzStorageBlob -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Download Storage Blobs" # Write message to screen
                $StorageBlobObject = GetAzStorageBlobContent ($StorageAccObject, $StorageConObject, $StorageBlobObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '3')
            elseif ($ManageAzStorageBlob -eq '4') { # Elseif statement for managing file shares
                Write-Host "Remove Storage Blobs" # Write message to screen
                RemoveAzStorageBlob ($StorageAccObject, $StorageConObject, $StorageBlobObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageBlob -eq '4')
            elseif ($ManageAzStorageBlob -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageConObject) { # If $var is not $null
                Write-Host "Clearing" $StorageConObject.Name # Write message to screen
                $StorageConObject = $null # Sets $var to $null
                } # End if ($StorageConObject)
                if ($StorageBlobObject) { # If $var is not $null
                Write-Host "Clearing" $StorageBlobObject.Name # Write message to screen
                $StorageBlobObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageBlob -eq '0')
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageConObject) { # If $var is not $null
                Write-Host "Current Storage Container: " $StorageConObject.Name # Write message to screen
            } # End if ($StorageConObject)
            if ($StorageBlobObject) { # If $var is not $null
                Write-Host "Current Storage Blob(s):   " $StorageBlobObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageBlob while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function SetAzStorageBlobContent {
    Begin {
        :SetAzureBlobContent while ($true) { # Outer loop for managing function
            if (!$StorageConObject) { # If $var is $null
                $StorageConObject, $StorageAccObject = GetAzStorageContainer # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break SetAzureBlobContent
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetAzureBlobTier while($true) { # Inner loop for setting access tier
                $BlobTierInput = Read-Host "Hot or Cool" # Operator input for $BlobTierInput
                if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool') { # If $Var is a valid entry
                    Break SetAzureBlobTier
                } # End if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool')
                elseif ($BlobTierInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End elseif ($BlobTierInput -eq 'exit')
                else { # Else if no valid entry for $Var
                    Write-Host "Please enter hot or cool" # Write message to screen
                } # End else (if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool'))
            } # End :SetAzureBlobTier while($true)
            :SetLocalFileName while ($true) {
                $LocalFileNameInput = Read-Host "Full path and filename" # Collects the path to file, example: C:\users\Admin\Documents\Blobupload.txt
                if ($LocalFileNameInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End if ($LocalFileNameInput -eq 'exit')
                Write-Host "This is the file to be uploaded" # Write message to screen
                Write-Host $LocalFileNameInput
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFileName while ($true)
            :SetAzureBlobName while ($true) {
                $BlobFileNameInput = Read-Host "New name and ext for this file" # Collects the new name and ext for the file that will be used in the storage account, example: SuperAwesomeBlob.jpg
                if ($BlobFileNameInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End if ($BlobFileNameInput -eq 'exit')
                Write-Host "This will be the file name in the container" # Write message to screen
                Write-Host $BlobFileNameInput # Write message to screen
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetAzureBlobName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureBlobName while ($true)
            $StorageBlobObject = Set-AzStorageBlobContent -File $LocalFileNameInput -Blob $BlobFileNameInput -Container $StorageConObject.Name -Context $StorageAccObject.Context -StandardBlobTier $BlobTierInput
            Return $StorageBlobObject 
        } # End  :SetAzureBlobContent while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function SetAzStorageBlobContent
function ListAzStorageBlob {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :ListAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageConObject) { # If $var is $null
                $StorageConObject, $StorageAccObject = GetAzStorageContainer # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break ListAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            $OperatorSelect = Read-Host "Search for a named blob [Y] or [N]"
            if ($OperatorSelect -eq 'y' -or $OperatorSelect -eq 'yes') {
                :GetAzureBlob while ($true) {
                    $StorageBlobNameInput = Read-Host "Blob name (Case Sensitive)"
                    if ($StorageBlobNameInput -eq 'exit') { # If $Var is 'exit'
                        Break ListAzureBlobs
                    } # End if ($StorageBlobNameInput -eq 'exit')
                    $StorageBlobObject = Get-AzStorageBlob -Blob $StorageBlobNameInput -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                    if (!$StorageBlobObject) { # If $Var is $null
                        Write-Host "No blobs names matched" # Write message to screen
                        Write-Host "Please chose from the following" # Write message to screen
                        $StorageBlobList = Get-AzStorageBlob -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                        Write-Host $StorageBlobList.Name -Separator `n # Write message to screen
                        Write-Host "" # Write message to screen
                    } # End if (!$StorageBlobObject)
                    else {
                        Write-Host $StorageBlobObject.Name $StorageBlobObject.Length $StorageBlobObject.LastModified $StorageBlobObject.AccessTier # Write message to screen 
                        Return $StorageBlobObject, $StorageAccObject, $StorageConObject
                    } # End else (if (!$StorageBlobObject))
                } # End :GetAzureBlob while ($true)
            } # End if ($OperatorSelect -eq 'y' -or $OperatorSelect -eq 'yes')
            else {
                $StorageBlobObject = Get-AzStorageBlob -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                foreach ($Name in $StorageBlobObject) {
                    Write-Host $Name.Name $Name.Length $Name.LastModified $Name.AccessTier # Write message to screen
                } # End foreach ($Name in $StorageBlobList)
                Return $StorageBlobObject, $StorageAccObject, $StorageConObject
            } # End else (if ($StorageBlobNameInput))
        } # End :ListAzureBlobs while
        Return # Returns to calling function empty
    } # End Begin
} # End function GetAzStorageBlob
function GetAzStorageBlobContent {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :GetAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageBlobObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
                $StorageBlobObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var
                if (!$StorageBlobObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetLocalFilePath while ($true) {
                $LocalFileDownloadPath = Read-Host "Path to download file to" # Operator input for the destination folder
                if ($LocalFileDownloadPath -eq 'exit') { # If $Var is 'exit'
                    Break GetAzureBlobs
                } # End if ($LocalFileDownloadPath -eq 'exit')
                Write-Host "Download blobs to"$LocalFileDownloadPath # Write message to screen
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFilePath
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFilePath while ($true)
            Try {
                foreach ($Name in $StorageBlobObject) {
                    Get-AzStorageBlobContent -Context $StorageAccObject.context -Container $StorageConObject.Name -Blob $Name.Name -Destination $LocalFileDownloadPath
                } # End foreach ($Name in $StorageBlobObject)
            }
            catch {Write-Host "An error has occured"}
            Return $StorageBlobObject
        } # End while statement
        Return # Returns to calling function
    } # End Begin
} # End function GetAzStorageBlobContent
function RemoveAzStorageBlob {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :RemoveAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageBlobObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
                $StorageBlobObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var
                if (!$StorageBlobObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            foreach ($Name in $StorageBlobObject) {
                $ConfirmDelete = Read-Host "Do you want to delete"$Name.Name # Operator input to confirm delete
                if ($ConfirmDelete -eq 'exit') { # If $Var is 'exit'
                    Break RemoveAzureBlobs
                } # End if ($ConfirmDelete -eq 'exit')
                if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
                    Remove-AzStorageBlob -Blob $Name.Name -Container $StorageConObject.Name -Context $StorageAccObject.Context # Removes the selected blob
                    Write-Host $Name.Name"has been deleted"  # Write message to screen
                } # End if statement
                else { # If $ConfirmDelete is not 'y' or 'yes'
                    Write-Host $Name.Name "was not deleted"  # Write message to screen
                } # End else statement
            } # End foreach ($Name in $StorageBlobObject)
            $StorageBlobObject = $null # Sets $var to $null
            Return
        } # End RemoveAzureBlobs
        Return
    } # End Begin
} # End function RemoveAzStorageBlob
function RemoveAzResourceLocks { # Function to remove resource locks, No input validation is done
    Begin {
        if (!$Locks) { # If statement if $Locks is $null
            $Locks = GetAzResourceLocks # Calls GetAzResourceLocks and assigns to $Locks
            if(!$Locks) { # If statement if $Locks is $null after calling function to assign
                Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
                Return $Locks # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks.Name # Writes all names contained in $Locks
        $OperatorConfirm = Read-Host "Type 'Y' or 'Yes' to remove these locks" # Operator confirmation to remove the listed locks
        if (!($OperatorConfirm -ceq 'Y' -or $OperatorConfirm -ceq 'Yes')) { # If $Operatorconfirm is not (Equal to 'Y' or 'Yes') statement
            $Locks = $null # $Locks is set to $null
            Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
            Return $Locks # Return to calling function
        } # End if statement
        else { # Else statement if $Operatorconfirm is (Equal to 'Y' or 'Yes')
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            } # End foreach loop
            $Locks = $null # Clears $Locks prior to returning to calling function
            Return $Locks # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceLocksAll { # Function to get all locks assigned to a resource, can pipe $Locks to another function
    Begin {
        if (!$RSObject) {
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if (!$RGObject)
            $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if if (!$RSObject)
        } # End if (!$RSObject)
        $Locks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource" # Write message to screen
            Write-Host "The GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function   
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        :GetAzureResourceGroup while ($true) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            if ($RGObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroup function was terminated"
                Break GetAzureResourceGroup # Ends :GetAzureResourceGroup loop
            } # End if statement
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
                Return $RGObject
            } # End of else statement
        } # End of while statement
        Return # Returns to calling function
    } # End of begin statement
} # End of function