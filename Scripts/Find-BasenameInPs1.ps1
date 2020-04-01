$module = 'PsWinAdmin'

$basenames = dir .\$module\*.ps1 -recurse | select -exp basename

$found = $basenames | %{$thisName = $_ ;  Get-String -Directory .\ -FileTypes ps1 -Pattern ($thisName -replace '\-','\-') | ? {($_.filename -replace '\.ps1$') -ne $thisName} }

$found| Export-Clixml -Path "$($env:DOWNLOADS)\found-$($module)-references.xml" -passthru

