#!/bin/bash

if [ -z $1 ]
then
  echo "Please set directory name.."
  echo "Usage : ./create-react-app-with-yarn-berry <directory name>"
  exit 0
fi

dir_name=$1

yarn create react-app $dir_name --template typescript

echo "Delete node_modules and lock file..."
cd $dir_name
rm -rf node_modules
rm -rf yarn.lock
rm -rf package-lock.json

echo "Set yarn berry..."
yarn set version berry

echo "Install packages..."
yarn

echo "Import typescript plugin..."
yarn plugin import typescript

echo "Set vscode sdk..."
yarn dlx @yarnpkg/sdks vscode

echo "Reinstall jest-dom..."
yarn remove @testing-library/jest-dom
yarn add -D @testing-library/jest-dom

read -p "Do you want to use zero-install? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo -e ".yarn/*\n!.yarn/cache\n!.yarn/patches\n!.yarn/plugins\n!.yarn/releases\n!.yarn/sdks\n!.yarn/versions" >> .gitignore
else
  echo -e ".pnp.*\n.yarn/*\n!.yarn/patches\n!.yarn/plugins\n!.yarn/releases\n!.yarn/sdks\n!.yarn/versions" >> .gitignore
fi

echo "Done."