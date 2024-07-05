location=~/path/tools
arch=$(dpkg --print-architecture)

mkdir -p "$location"
cd "$location"

apt update -y
apt install wget curl -y

curl -Ls "https://github.com/path-tw/artefacts/releases/download/v0.1.6/devsetup-v0.1.6-linux-$arch" -o argus

chmod +x argus
./argus setup
