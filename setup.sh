location="~/path/tools"
$arch = $(dpkg --print-architecture)

mkdir -p "$location"
cd "$location"

apt update -y
apt install wget curl -y

curl -s "https://github.com/path-tw/dev-setup/releases/download/v0.1.0/devsetup-v0.1.0-windows-$arch.exe" -o devsetup

./devsetup setup
