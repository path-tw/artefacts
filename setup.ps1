$location = "$env:USERPROFILE\path\tools"
$arch = "amd64"

if ([System.IntPtr]::Size -eq 4) {
  $arch = "386"
}

mkdir -p "$location" -ErrorAction SilentlyContinue
cd "$location"

Invoke-WebRequest "https://github.com/path-tw/artefacts/releases/download/v0.1.3/devsetup-v0.1.3-linux-$arch.exe" -OutFile argus.exe

Start-Process ".\argus.exe" -ArgumentList "setup" -Wait
