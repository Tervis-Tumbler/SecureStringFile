function New-SecureStringFile {
    <#
    .SYNOPSIS
     Converts plain text such as credentials or API keys to a secured string and outputs to a file.
    .DESCRIPTION
     Converts plain text such as credentials or API keys to a secured string and outputs to a file.
    .EXAMPLE
    New-SecuredStringToFile -OutputFile "\\FileserverPath\SecuredCredential API Keys\SecuredFile.txt"
    .PARAMETER OutputFile
    Fully qualified path to output file
    #>
    
    param(
        [Parameter(Mandatory)]
        [string]$OutputFile,
        
        [Parameter(Mandatory)]
        [System.Security.SecureString]$SecureString = $(Read-Host "Enter the string data to be secured" -AsSecureString)
    )
    $EncryptedPW = ConvertFrom-SecureString -SecureString $SecureString
    Set-Content -Path $OutputFile -Value $EncryptedPW
}


function Get-SecureStringFile {
    <#
    .SYNOPSIS
     Extracts encrypted string, such as credentials or API keys, from a predetermined saved file and outputs unencrypted, plain text string.
    .DESCRIPTION
     
    .EXAMPLE
    get-SecuredStringFromFile "\\FileserverPath\SecuredCredential API Keys\SecuredFile.txt"
    .PARAMETER OutputFile
    Fully qualified path to input file
    #>
    
    param(
        [Parameter(Mandatory)]
        [string]$InputFile
    )
    $EncryptedString = Get-Content -Path $InputFile
    $secureString = ConvertTo-SecureString -String $EncryptedString 
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
    $PlainString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    
    $PlainString  
}

function Get-ValueFromSecureString {
    param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        $SecureString
    )
    (New-Object System.Management.Automation.PSCredential 'N/A', $SecureString).GetNetworkCredential().Password
}
