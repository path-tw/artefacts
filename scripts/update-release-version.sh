set -e -o pipefail

gh_token=${GITHUB_TOKEN}
repository=${GITHUB_REPOSITORY}

function fetchPreviousReleaseVersion {
  # Fetch the list of releases using GitHub API
  releases=$(curl -s -H "Accept: application/vnd.github.v3+json" \
            -H "Authorization: token ${gh_token}" \
            https://api.github.com/repos/${repository}/releases)

  # Extract the previous release version (second latest)
  previous_version=$(echo "$releases" | jq -r '.[1].tag_name')

  echo "$previous_version"
}

function replaceVersion {
  previous_version=$1
  current_version=$2
  file_name=$3

  sed -i "s/${previous_version}/${current_version}/g" "${file_name}"
}

function main {
  current_version=${TAG}
  previous_version=$(fetchPreviousReleaseVersion)
  replaceVersion $previous_version $current_version setup.sh
  replaceVersion $previous_version $current_version setup.ps1
}

main