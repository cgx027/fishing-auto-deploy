#!/bin/bash

export PORT=3000

git clone https://github.com/cgx027/fishing.git 2>/dev/null
cd fishing/

echo "Start process"
npm start &
current_pid=$!
echo "process started, pid="$current_pid

while :
do
    date
    #echo "checking for new commits"
    
    git fetch
    LOCAL=$(git log -p -1])
    #echo LOCAL = $LOCAL
    REMOTE=$(git log -p -1 origin/master)
    #echo REMOTE = $REMOTE
    
    if [ "$LOCAL" = "$REMOTE" ]; then
        echo "No new commit found"
    else        
        echo "New commit found"
        echo "Fetching new code"
        git fetch
        git rebase origin/master
        echo "Install packages"
        npm install
        echo "Stop existing running process"
        sudo kill $current_pid 2>/dev/null
        echo "Restart process"
        npm start &
        current_pid=$!
        echo "process started, pid="$current_pid
    fi
    
    echo
    echo
    
    sleep 10
done