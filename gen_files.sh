#! /bin/bash
mkdir -p ~/temp # -p mean don't error if it exists in this case, it does other things too
cd ~/temp
touch file{1..10}.txt
echo done
