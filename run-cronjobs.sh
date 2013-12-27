#!/bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo cd $DIR
cd $DIR
rake petitionen_cache:update

