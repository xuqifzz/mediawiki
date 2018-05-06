#!/bin/bash
isVolExist=`docker volume ls | grep -v grep | grep mediawiki-images`
if [ -z "$isVolExist" ]; then
    echo error:未发现数据卷,请确认服务有没有正确部署
    exit 1
fi
rm -rf backup.tar.gz
docker run --rm -it -v mediawiki-images:/volume -v `pwd`/backup:/backup alpine tar -cjf /backup/images.tar.bz2 -C /volume ./
tar -czf backup.tar.gz ./backup