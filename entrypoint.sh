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

echo "npm install ..." 
npm install


echo "Clean folder ..."
./node_modules/hexo/bin/hexo clean

echo "Generate file ..."
./node_modules/hexo/bin/hexo generate 

cd $PUBLISH_DIR

echo "Config git ..."

# Configures Git.
git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git remote add origin "${REPOSITORY_PATH}"

# Checks to see if the remote exists prior to deploying.
# If the branch doesn't exist it gets created here as an orphan.
# if [ "$(git ls-remote --heads "$REPOSITORY_PATH" "$BRANCH" | wc -l)" -eq 0 ];
# then
#   echo "Creating remote branch ${BRANCH} as it doesn't exist..."
#   git checkout --orphan $BRANCH
# fi

git checkout --orphan $BRANCH

git add --all

echo 'Start Commit'
git commit --allow-empty -m "Deploying to ${BRANCH}"

echo 'Start Push'
git push origin "${BRANCH}" --force

echo "Deployment succesful!"