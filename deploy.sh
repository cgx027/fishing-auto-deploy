git clone https://github.com/cgx027/fishing.git 2>/dev/null
cd fishing/
#git fetch
changed=0;sudo git pull| grep -q -v 'Already up-to-date.' && changed=1
#echo changed=$changed
if [  $changed = 1  ]; then
    echo "new commit found"
else
    echo "no new commit found"
fi
npm install
export PORT=4000; npm start
