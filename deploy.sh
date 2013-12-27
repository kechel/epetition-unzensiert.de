#!/bin/sh
git push
ssh -p 53423 176.28.48.115 "cd /home/jan/epetition-unzensiert.de-git; ./deploy-local.sh;"
