#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: ./make_jar.sh <Main Class> <jar name> <optional: input files>"
else
  # compile all .class files
  find src -name \*.java -print > file.list
  javac @file.list -d .
  # make manifest
  echo Main-Class: $1 >manifest.txt
  dir=".";
  if [[ $1 == *"."* ]]; then
    dir="$( cut -d '.' -f 1 <<< "$1" )";
    mv manifest.txt $dir
  fi
  manifest="$dir/manifest.txt"
  # make jar with manifest, .class files, and any additional inputs
  name="$2"
  shift
  shift
  jar cfmv $name.jar $manifest */*.class $@
  # remove generated files
  rm $manifest
  rm -rf $(find . -name *.class -execdir pwd \;)
  rm file.list
fi
