Clear-Host
$langchoice = Read-Host @"
=====================<@Evilbytecode>=====================
88  dP 88 888888 888888 Yb  dP      dP""b8 88""Yb Yb  dP 88""Yb 888888 888888 88""Yb 
88odP  88   88     88    YbdP      dP   `" 88__dP  YbdP  88__dP   88   88__   88"Yb  
88"Yb  88   88     88     8P       Yb      88"Yb    8P   88"""    88   88""   88"Yb  
88  Yb 88   88     88    dP         YboodP 88  Yb  dP    88       88   888888 88  Yb 

=====================<@Evilbytecode>=====================

-------------
1: Powershell
2: Python
-------------

[INFO] Choose a programming language
"@

if ($langchoice -ne '1' -and $langchoice -ne '2') {
    Write-Host "[-] Error: Invalid choice. Please choose a valid programming language."
    Start-Sleep 10
    exit
}

$ToEncrypt = Read-Host "[+] Please enter the full path of the file you want to encrypt"

$ToEncrypt = $ToEncrypt -replace '^"|"$'

if (-not $ToEncrypt -or -not (Test-Path $ToEncrypt)) {
    Write-Host "[-] Error: The specified file path is invalid or does not exist." -ForegroundColor Red
    Start-Sleep 10
    exit
}

switch ($langchoice) {
    1 {
        if (Test-Path $ToEncrypt -PathType Leaf) {
            $scrcont = Get-Content $ToEncrypt -Raw
    
            $encscr = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($scrcont))
    
            function Base64-Obfuscator {
                [CmdletBinding()]
                Param (
                    [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline = $True)]
                    [string]$Data
                )
                
                PROCESS {
                    $Seed = Get-Random
                    $MixedBase64 = [Text.Encoding]::ASCII.GetString(([Text.Encoding]::ASCII.GetBytes($Data) | Sort-Object { Get-Random -SetSeed $Seed }))
            #notmyideabtwlol
                    $Var1 = -Join ((65..90) + (97..122) | Get-Random -Count ((1..12) | Get-Random) | % { [char]$_ })
                    $Var2 = -Join ((65..90) + (97..122) | Get-Random -Count ((1..12) | Get-Random) | % { [char]$_ })
                    
                    $obfedscr = "# Obfuscated by: https://github.com/EvilBytecode`n`n" +
                    "`$$($Var1) = [Text.Encoding]::ASCII.GetString(([Text.Encoding]::ASCII.GetBytes(`'$($MixedBase64)') | Sort-Object { Get-Random -SetSeed $($Seed) })); `$$($Var2) = [Text.Encoding]::ASCII.GetString([Convert]::FromBase64String(`$$($Var1))); IEX `$$($Var2)"
    
                    $putfile = "Obfuscated-" + ([System.IO.Path]::GetRandomFileName() -replace '\.', '') + ".ps1"
                    $obfedscr | Out-File -FilePath $putfile
    
                    Write-Host "[+] Obfuscated script saved as $putfile" -ForegroundColor Green
                    Start-Sleep 5
                }
            }
    
            Base64-Obfuscator -Data $encscr
        }
        else {
            Write-Host "[-] File not found at the specified path." -ForegroundColor Red
        }
    }
    2 {
        ##python lang that i dislike from bottom of my heart lol
        $randchr = [char](Get-Random -Minimum 65 -Maximum 91)
        $pyscr = Get-Content -Path $ToEncrypt -Raw
        $encscr = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($pyscr))
        $impr = "import base64;${randchr}='${encscr}';${randchr}=${randchr}.replace('*','${replace}');exec(base64.b64decode(${randchr}))"
        
        $pyput = "Obfuscated-" + ([System.IO.Path]::GetRandomFileName() -replace '\.', '') + ".py"
        $impr | Out-File -FilePath $pyput
        Write-Host "[+] Obfuscated script saved as $putfile" -ForegroundColor Green
        Start-Sleep 5
    }
}
