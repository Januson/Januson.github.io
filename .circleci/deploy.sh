#!/usr/bin/env bash

git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

git clone $CIRCLE_REPOSITORY_URL out

cd out
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
git rm -rf .
cd ..

zola build

cp -a public/. out/.

mkdir -p out/.circleci && cp -a .circleci/. out/.circleci/.

cd out

git add -fA
git status
git commit -m "Automated deployment to GitHub Pages: ${CIRCLE_SHA1}" --allow-empty

git push origin $TARGET_BRANCH

echo "deployed successfully"