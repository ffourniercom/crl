
<#
.SYNOPSIS
    Copy Certificate and Certificate Revocation List files to repository folder

.DESCRIPTION
    This script copies certificate (.crt) and certificate revocation list (.crl) files
    from the Windows certificate enrollment directory to a specified repository folder.
    Used for maintaining certificate authority files in a centralized location.

.INPUTS
    None. This script does not take pipeline input.

.OUTPUTS
    Log: Console output with success/error messages
    Files: Certificate and CRL files copied to C:\Repository\crl

.EXAMPLE
    PS> .\CRT.ps1
    Copies all .crt and .crl files from certenroll directory to repository folder.

.NOTES
    Author: DevOps Team
    Created: 2026-02-15
    Version: 1.0.0
    Last Updated: 2026-02-15

    Prerequisites:
    - Destination folder C:\Repository\crl must exist
    - Script must run with appropriate permissions to access certificate enrollment directory
    - Windows Certificate Services must be installed and configured

.LINK
    https://docs.microsoft.com/en-us/windows-server/identity/ad-cs/
#>
$Destination = 'C:\Repository\crl\src'
Write-Output 'Testing destination folder'

if (Test-Path $Destination) {

    try {
        Copy-Item C:\Windows\system32\certsrv\certenroll\*.crt $Destination -Verbose
        Write-Output "`tCRT file successfully copied"
    } catch {
        Write-Error 'Unable to copy CRT file'
        exit 1
    }
    try {
        Copy-Item C:\Windows\system32\certsrv\certenroll\*.crl $Destination -Verbose
        Write-Output "`tCRl file successfully copied"
    } catch {
        Write-Error 'Unable to copy CRL file'
        exit 2
    }
} else {
    Write-Error 'Destination folder "C:\Repository\crl" does not exist'
    Write-Error 'Please review documentation to create and clone require directory'

}
Write-Output 'CRT and CRLs copied successfully'
