##
## Jason Kline
## CopyFiles-Bits.ps1
## 01/19/2015
##

function CopyFiles-Bits
{
    # Set Parameters
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Source,
        [Parameter(Mandatory=$true)]
        [String]$Destination
    )

    # Read all directories located in the sorce directory
    $folders = Get-ChildItem -Name -Path $source -Directory -Recurse

    # Start Bits Transfer for all items in each directory.  Create Each directory if they do not exist at destination.
    Start-BitsTransfer -Source $Source\*.* -Destination $Destination
    foreach ($i in $folders)
    {
        $exists = Test-Path $Destination\$i
        if ($exists -eq $false) {New-Item $Destination\$i -ItemType Directory}
        Start-BitsTransfer -Source $Source\$i\*.* -Destination $Destination\$i
    }

}