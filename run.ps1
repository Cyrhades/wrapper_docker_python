$version = "3.11"
$debugMode = $false
$scriptArgs = @()

function DebugWrite($message) {
    if ($debugMode) {
        Write-Host $message
    }
}

for ($i = 0; $i -lt $args.Length; $i++) {
    $arg = $args[$i]

    if ($arg -eq "-debug") {
        $debugMode = $true
    }
    elseif ($arg -like "-version*" -or $arg -like "--version*") {
        if ($arg -like "*=*") {
            $version = $arg.Split('=')[1]
        } else {
            if ($i + 1 -lt $args.Length) {
                $version = $args[$i + 1]
                $i++
            } else {
                DebugWrite "Erreur : option -version attend une valeur."
                exit 1
            }
        }
    } 
    else {
        $scriptArgs += $arg
    }
}

if ($scriptArgs.Length -lt 1) {
    DebugWrite "Erreur : veuillez fournir au moins le chemin du script python à exécuter."
    exit 1
}

$scriptPath = $scriptArgs[0]
$scriptParams = @()
if ($scriptArgs.Length -gt 1) {
    $scriptParams = $scriptArgs[1..($scriptArgs.Length - 1)]
}

DebugWrite "Version python demandée : $version"
DebugWrite "Exécution de $scriptPath avec arguments : $($scriptParams -join ', ')"

$AppPath = (Get-Location).Path + "\app"
$ImageName = "python:$version-slim"

docker run --rm -it -v "${AppPath}:/app" -w "/app" $ImageName python $scriptPath @scriptParams
