#! /usr/bin/env bash

cd /home/cnman/rj/

sha1sum * >/home/cnman/REEJI.sha1

echo "|FileName|FullName|PostScriptName|Family|SubFamily|Version|
|-------|-------|-------|-------|-------|-------|" >/home/cnman/REEJI.MD


ls | while read line
do
    otfinfo -i $line >/home/cnman/temp
    FULLNAME=`grep 'Full name' /home/cnman/temp| awk '{for (i=3;i<=NF;i++)printf("%s ", $i);print ""} ' | sed 's/[ \t]*$//g'`
    POSTSCRIPTNAME=`otfinfo -p $line`
    FAMILY=`otfinfo -a $line`
    SUBFAMILY=`grep 'Subfamily' /home/cnman/temp| awk '{for (i=2;i<=NF;i++)printf("%s ", $i);print ""}' | sed 's/[ \t]*$//g'`
    VERSION=`otfinfo -v $line | sed 's/Version //g'`
    echo "|$line|$FULLNAME|$POSTSCRIPTNAME|$FAMILY|$SUBFAMILY|$VERSION|" >>/home/cnman/REEJI.MD
done
