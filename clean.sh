#!/bin/bash
D=`dirname $0`

find $D -name "*.elc" -or -name "*~" -delete
rm -fr $D/backup/*
rm -fr $D/temp/*
rm -fr $D/el-get/el-get
