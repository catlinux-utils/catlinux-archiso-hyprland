#!/bin/bash
base=$(pwd)
packages=()
mkdir -p /tmp/pkgs
cd /tmp/pkgs
if [ "$1" == "--skip" ]; then
    for package in "${packages[@]}"; do
        basedir=$(pwd)
        builddir=$basedir/$package
        git clone https://aur.archlinux.org/$package.git
        cd $package
        if [[ -f $builddir/*.pkg.* ]]; then
            echo "Package already exist"
            continue
        fi
        makepkg -sr --skippgpcheck
        cp $builddir/*.pkg.* $basedir
        cd $basedir
        #rm -fr $builddir
    done
else
    for package in "${packages[@]}"; do
        basedir=$(pwd)
        builddir=$basedir/$package
        git clone https://aur.archlinux.org/$package.git
        cd $package
        read -p "Build $package? (y/n) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [[ -f $builddir/*.pkg.* ]]; then
                echo "Package already exist"
                continue
            fi
            makepkg -sr --skippgpcheck
            cp $builddir/*.pkg.* $basedir
        fi
        cd $basedir
        #rm -fr $builddir
    done
fi
cd $base
