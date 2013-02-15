#cd ..\_classes
cls
if ($args[0])
  {exit}

Import-Module pscx

function ProcessFile($pSourceFile, $pOutputFile) {
  Write-Host "Processing" $pSourceFile
  [bool]$foundDocStart = $false  
  foreach ($line in Get-Content $pSourceFile) {
    if ($line.Contains("Omit('!!!Docs!!!')")) {
      $foundDocStart = $true
      continue # Skip this line though, we will get the next one
    }
    elseif ($line.Contains("!!!Docs!!!")) {
      $foundDocStart = $false
    }
    
    if ($foundDocStart -eq $false) { 
      continue
    }
    
    Add-Content $pOutputFile $line
  }
  Write-Host "Completed " $pOutputfile
}

# We assume we are going to process each inc/clw file in the current directory

$srcPath = (join-path -Path $(Get-Location) -ChildPath "_classes") 
$dstPath = (join-path -Path $(Get-Location) -ChildPath "_docs\source") 

get-childItem $srcPath -Include @("*.inc") -r | foreach-object {
    $dstName = [io.path]::GetFileNameWithoutExtension($_.Name)
    $dstFile = (Join-Path -Path $dstPath -ChildPath $($dstName + ".rst"))
    Remove-Item $dstFile
    # -ErrorAction SilentlyContinue
  }

get-childItem $srcPath -Include @("*.inc", "*.clw") -r | Sort -Descending | foreach-object {
    Write-Host "Source = " $_.FullName 
    $dstName = [io.path]::GetFileNameWithoutExtension($_.Name)
    $dstFile = (Join-Path -Path $dstPath -ChildPath $($dstName + ".rst"))
    Write-Host "Destination = " $dstFile
    #Write-Host "Name = " $dstName 
    ProcessFile $_.FullName $dstFile
  }

$originalPath = Get-Location
cd (join-path -Path $originalPath -ChildPath "_docs") 
Invoke-BatchFile make html 
cd $originalPath

<#

$originalPath = Get-Location
cd (join-path -Path $srcPath -ChildPath "Docs") 
Invoke-BatchFile make html 
cd $originalPath

$docsSource = $(Join-Path -Path $srcPath -ChildPath "Docs\_build\html") + "\*"
mkdir $dstPath
Copy-Item $docsSource $dstPath -Recurse

# Now, copy stuff for clarion developers to use...
$dstPath = "I:\clarion6\3rdParty\Docs\AutoTask\ClarionWrapper"
Remove-Item $dstPath -Force -Recurse -ErrorAction SilentlyContinue
mkdir $dstPath -Force
Copy-Item $docsSource $dstPath -Force -Recurse
$dstPath = "I:\clarion6\3rdParty\Docs\AutoTask\"
Copy-Item $(join-path -Path $(Get-Location) -ChildPath "_Docs\iSell.AutoTask.chm") $dstPath -Force

# Copy the classes
$dstPath = "I:\clarion6\3rdParty\LibSrc\"
$srcFiles = $srcPath + "\*.clw"
Copy-Item $srcFiles $dstPath -Force
$srcFiles = $srcPath + "\*.inc"
Copy-Item $srcFiles $dstPath -Force

# Copy the example app too
$dstPath = "I:\clarion6\3rdParty\Examples\AutoTask\"
Remove-Item $dstPath -Force -Recurse -ErrorAction SilentlyContinue
mkdir $dstPath -Force
$srcFiles = $srcPath + "\*.exe"
Copy-Item $srcFiles $dstPath -Force
$srcFiles = $srcPath + "\*.dll"
Copy-Item $srcFiles $dstPath -Force
#>