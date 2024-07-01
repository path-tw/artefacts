location=~/path/tools
arch=$(dpkg --print-architecture)

mkdir -p "$location"
cd "$location"

apt update -y
apt install wget curl -y

curl -Ls "https://github.com/path-tw/dev-setup/releases/download/v0.1.3/devsetup-v0.1.3-linux-$arch" -o argus

chmod +x argus
./argus setup
