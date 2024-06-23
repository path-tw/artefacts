location="~/path/tools"
$arch=$(dpkg --print-architecture)

mkdir -p "$location"
cd "$location"

apt update -y
apt install wget curl -y

curl -s "https://github.com/path-tw/artefacts/releases/download/v0.1.1/devsetup-v0.1.1-linux-$arch" -o devsetup

./devsetup setup
