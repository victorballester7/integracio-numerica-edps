#!/bin/bash
# This script is used to execute all the programs in the project
ex2="ex2"
ex3="ex3"
ex4="ex4"
ex5="ex5"

# location of binary files
BIN="bin"
if [ -z "$1" ] || ([ "$1" != "$ex2" ] && [ "$1" != "$ex3" ] && [ "$1" != "$ex4" ] && [ "$1" != "$ex5" ]); then
  echo "Invalid argument. Use one of the following: $ex2 $ex3 $ex4 $ex5"
  exit 1
fi

make $BIN/$1

if [ -z "$7" ]; then
  echo "No arguments provided. Use the syntax: ./execute.sh $1 <dx> <dy> <nx> <ny> <dt> <tf>"
  case $1 in
    $ex2)
      echo "Executing the default command: ./$BIN/$1 0.1 0.1 10 10 0.001 0.1"
      ./$BIN/$1 0.1 0.1 10 10 0.001 0.1
      ;;
    $ex3)
      echo "Executing the default command: ./$BIN/$1 0.1 0.1 10 10 0.1 1"
      ./$BIN/$1 0.1 0.1 10 10 0.1 1
      ;;
    $ex4)
      echo "Executing the default command: ./$BIN/$1 0.1 0.1 10 10 0.001 1"
      ./$BIN/$1 0.1 0.1 10 10 0.001 1
      ;;
    $ex5)
      echo "Executing the default command: ./$BIN/$1 0.01 0.01 100 100 0.01 1"
      ./$BIN/$1 0.01 0.01 100 100 0.01 1
      ;;
    *)
      echo "Invalid argument. Use one of the following: $ex2, $ex3, $ex4, $ex5"
      ;;
  esac
else
  ./$BIN/$1 $2 $3 $4 $5 $6 $7
fi

# execute ./plot.sh in the exercice 5
if [ "$1" == "$ex5" ]; then
  ./plot.sh
fi
