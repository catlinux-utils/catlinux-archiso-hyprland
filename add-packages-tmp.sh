#!/bin/sh
basedir=$(pwd)
mkdir -p /tmp/pkgs
cd /tmp/pkgs
repo-add custom.db.tar.gz *.pkg.*
cd $basedir