#!/bin/bash

echo "/path/to/serenity/ > " 
read pathToSerenity
#echo "pathToSerenity=$pathToSerenity" > .pathToSerenity

cd $pathToSerenity # IN CASE OF THE PATH DOESN'T
cd Build           # HAVE A "/" AT THE END

echo 'Pulling the latest changes from git'

startSerenity () {
	nohup make run > /dev/null 2>&1 &
}

if [[ $(git pull | grep -o "Already up to date.") = "Already up to date." ]]; then
	echo 'Serenity is already up to date'
	echo 'Starting...'
	startSerenity
else
	echo 'Building and running Serenity'
	make install
	make image
	startSerenity
fi
