#!/bin/bash
# This script is used to execute all the programs in the project
ex2="ex2"
ex3="ex3"
ex4="ex4"
ex5="ex5"

# location of binary files
BIN="bin"
# location of .gnu files
PLOT="plot"

if [ -z "$1" ]; then
  echo "Invalid argument. Use one of the following: $ex2 $ex3 $ex4 $ex5"
  exit 1
fi

make $BIN/$1

if [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ] && [ -z "$6" ] && [ -z "$7" ]; then
  echo "No arguments provided. Use the syntax: ./execute.sh $1 <dx> <dy> <nx> <ny> <dt> <tf>"
  # default values for ex2, ex3 and ex4
  if [ "$1" != "$ex5" ]; then
    echo "Executing the default command: ./$BIN/$1 0.1 0.1 5 5 0.001 0.1"
    ./$BIN/$1 0.1 0.1 5 5 0.001 0.1
  else
    echo "Executing the default command: ./$BIN/$1 0.01 0.01 100 100 0.001 1"
    ./$BIN/$1 0.01 0.01 100 100 0.001 1
  fi
else
  ./$BIN/$1 $2 $3 $4 $5 $6 $7
fi

# execute ./plot.sh in the exercice 5
if [ "$1" == "$ex5" ]; then
  ./plot.sh
fi
