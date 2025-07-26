#!/bin/sh -l

set -e

# set default value
if [ -z "${PUBLISH_DIR}" ]
then
  PUBLISH_DIR="./public"
fi

if [ -z "${BRANCH}" ]
then
  BRANCH="gh_pages"
fi

REPOSITORY_PATH="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

# deploy to 
echo "Deploy to ${GITHUB_REPOSITORY}"

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE

echo "apt install"
apt update -y
apt-get install -y pandoc

echo "npm install ..." 
npm install


echo "Clean folder ..."
./node_modules/hexo/bin/hexo clean

echo "Generate file ..."
./node_modules/hexo/bin/hexo generate

echo "Get Commit Message ..."
git config --global --add safe.directory $PWD
GIT_COMMIT_MSG=$(git log --pretty=format:"%s" -1)

cd $PUBLISH_DIR

echo "Config git ..."

# Configures Git.
git config --global init.defaultBranch ${BRANCH}
git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git remote add origin "${REPOSITORY_PATH}"

git add --all

echo 'Start Commit'
git commit --allow-empty -m "$GIT_COMMIT_MSG"

echo 'Start Push'
git push origin "${BRANCH}" --force

echo "Deployment succesful!"
