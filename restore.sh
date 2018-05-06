#!/bin/bash
if [ ! -f "backup.tar.gz" ]; then
    echo error:未找到备份文件
    exit 1
fi
isRunning=`docker stack ls | grep -v grep | grep mediawiki`
if [ ! -z "$isRunning" ]; then
    echo error:恢复前请先关闭服务
    exit 1
fi

rm -rf ./backup
tar -xzf backup.tar.gz
isVolExist=`docker volume ls | grep -v grep | grep mediawiki-images`
if [ -z "$isVolExist" ]; then
    docker volume create mediawiki-images
fi
docker run --rm -it -v mediawiki-images:/volume -v `pwd`/backup:/backup alpine \
    sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/images.tar.bz2"
rm -rf ./backup/images.tar.bz2
 



