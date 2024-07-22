set -e -o pipefail

gh_token=${GITHUB_TOKEN}
repository=${GITHUB_REPOSITORY}

function fetchReleaseVersion {
  index=$1
  # Fetch the list of releases using GitHub API
  releases=$(curl -s -H "Accept: application/vnd.github.v3+json" \
            -H "Authorization: token ${gh_token}" \
            https://api.github.com/repos/${repository}/releases)

  # Extract the previous release version (second latest)
  previous_version=$(echo "$releases" | jq -r ".[${index}].tag_name")

  echo "$previous_version"
}

function replaceVersion {
  previous_version=$1
  current_version=$2
  file_name=$3

  sed -i "s/${previous_version}/${current_version}/g" "${file_name}"
  cat ${file_name}
}

function main {
  action=${GITHUB_ACTION}
  current_version=${TAG}
  previous_version=$(fetchReleaseVersion 1)

  if [ "${action}" = "deleted" ]; then
    current_version=${fetchReleaseVersion 0}
    previous_version=$(TAG)
  fi

  echo "The current release version is ${current_version}"
  echo "The previous release version is ${previous_version}"

  replaceVersion $previous_version $current_version setup.sh
  replaceVersion $previous_version $current_version setup.ps1

  git config --global user.name "GH-ACTIONS"
  git config --global user.email "gh-actions@github.com"

  git add .
  git commit -m "Updating version to ${currect_version}"
  git push origin main
}

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
pushd "${PROJECT_DIR}" > /dev/null
  main
popd > /dev/null
