<#
  Local Windows build (same steps as .github/workflows/build-windows.yml).
  Run from the repository root in PowerShell:
      .\windows\build.ps1                 # exe + installer + portable zip
      .\windows\build.ps1 -SkipInstaller  # exe + portable zip only (no Inno Setup needed)
#>
param([switch]$SkipInstaller)
$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

$m = Select-String -Path appify -Pattern '^CURRENT_VERSION\s*=\s*"([^"]+)"'
if (-not $m) { throw "Could not read CURRENT_VERSION from ./appify" }
$version = $m.Matches[0].Groups[1].Value
Write-Host "Building Appify $version for Windows..."

python -m pip install --upgrade pip
python -m pip install -r requirements.txt "pyinstaller>=6.10,<7"

Remove-Item -Recurse -Force build, dist, release, build_src -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path build_src, release | Out-Null
Copy-Item appify build_src\appify_main.py      # PyInstaller wants a .py file name

pyinstaller --noconfirm --clean --windowed --name Appify `
    --icon "$PWD\windows\appify.ico" `
    --add-data "$PWD\windows\appify.png;." `
    --hidden-import winreg `
    --exclude-module tkinter `
    build_src\appify_main.py
if ($LASTEXITCODE -ne 0) { throw "PyInstaller failed" }

# Smoke test: builds the whole UI inside the packaged exe, then exits.
$out = Join-Path $PWD "selftest.txt"
Remove-Item $out -ErrorAction SilentlyContinue
$p = Start-Process -FilePath "dist\Appify\Appify.exe" -ArgumentList @("--selftest", $out) -PassThru -Wait
if (-not (Test-Path $out)) { throw "Self-test failed (exit code $($p.ExitCode))" }
Write-Host "Self-test: $(Get-Content $out)"
Remove-Item $out

Compress-Archive -Path dist\Appify\* -DestinationPath "release\Appify-$version-windows-portable.zip" -Force

if (-not $SkipInstaller) {
    $iscc = "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe"
    if (-not (Test-Path $iscc)) { throw "Inno Setup 6 not found. Install it (winget install JRSoftware.InnoSetup) or use -SkipInstaller." }
    & $iscc "/DMyAppVersion=$version" windows\appify.iss
    if ($LASTEXITCODE -ne 0) { throw "Inno Setup failed" }
}
Write-Host "`nDone. Output in .\release:"
Get-ChildItem release | Format-Table Name, Length
