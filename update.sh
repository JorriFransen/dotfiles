#! /usr/bin/env bash

git submodule init
git submodule update

OPTIND=1

IGNORED_FOLDERS=""
TARGET=""

while getopts "t:i:" opt; do
    case ${opt} in

        i ) 
            if [ -z $IGNORED_FOLDERS ]; then
                IGNORED_FOLDERS=$OPTARG
            else
                IGNORED_FOLDERS="$IGNORED_FOLDERS,$OPTARG"
            fi

            ;;

        t )
            if [ ! -d $OPTARG ]; then
                echo "Target '$OPTARG' is not a folder" 1>&2
                exit 1
            else
                TARGET=$OPTARG
            fi
            ;;

        : )
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            exit 1
            ;;

        \? )
            echo "Invalid arguments"
            ;;
    esac
done

if [ -z $TARGET ]; then
    TARGET=$HOME
fi

for dir_name in ./*; do
    if [ -d $dir_name ]; then
        base_name=$(basename $dir_name)

        if [[ $IGNORED_FOLDERS == *"$base_name"* ]]; then
            echo "Ignoring folder: $dir_name"
        else
            echo "Stowing: $dir_name"
            stow -v --dotfiles -t $TARGET $base_name
        fi
    fi
done
