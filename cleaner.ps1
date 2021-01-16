#infinite loop for calling  function   
$ScriptPath = $MyInvocation.MyCommand.Definition

# 2030 year error
$timeout = new-timespan -end (get-date -year 2030 -month 1 -day 1)
$sw = [diagnostics.stopwatch]::StartNew()
while ($sw.elapsed -lt $timeout){
    if (-Not (test-path  $ScriptPath)){
        write-host "v been renamed, quiting!"
        return
        }

    start-sleep -seconds 60
    # logic
$time=Get-Date
$maxdate = $time.AddMinutes(-120)
Get-WmiObject -Class Win32_UserProfile  | Foreach-Object {
    $path =  $_.LocalPath 
    if (-Not $path.Contains('Windows')){
    echo $path
    $Files = Get-ChildItem "$($path)\..\*\AppData\Local\Temp" -recurse | ?  {$_.LastWriteTime -lt $maxdate } |
     remove-item -force -recurse
    echo $Files 

    }
}   
}
