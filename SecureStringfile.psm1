function New-SecuredStringToFile {
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

  param
  (
  [Parameter(Mandatory=$true)]
  [string] $OutputFile
  )
  $SecureString = Read-Host "Enter the string data to be secured" -AsSecureString
  $EncryptedPW = ConvertFrom-SecureString -SecureString $SecureString
  Set-Content -Path $OutputFile -Value $EncryptedPW
}


function Get-SecuredStringFromFile {
  <#
  .SYNOPSIS
   Extracts encrypted string, such as credentials or API keys, from a predetermined saved file and outputs unencrypted, plain text string.
  .DESCRIPTION
   
  .EXAMPLE
  get-SecuredStringFromFile "\\FileserverPath\SecuredCredential API Keys\SecuredFile.txt"
  .PARAMETER OutputFile
  Fully qualified path to input file
  #>

  param
  (
  [Parameter(Mandatory=$true)]
  [string] $InputFile
  )
  $EncryptedString = Get-Content -Path $InputFile
  $secureString = ConvertTo-SecureString -String $EncryptedString 
  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
  $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

  return $PlainPassword  
}

