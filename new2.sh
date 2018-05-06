#!/bin/bash
CONTAINER_ID=`docker container ls | grep -v grep |  grep mediawiki: |sed -n 1p |awk '{print $1}'`
if [ -z $CONTAINER_ID ]
then
    echo error:没找到正在运行的mediawiki容器
fi
rm -rf ./backup/extensions
docker cp ${CONTAINER_ID}:/var/www/html/extensions ./backup/
