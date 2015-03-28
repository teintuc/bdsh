#!/bin/sh
# Main function of bdsh

source ./bdsh.vars.sh
source ./bdsh.utils.sh

do_select () {
  if [ $# -eq 1 ]; then
    if [ "$1" == "all" ]; then
      result=$(cat $DATABASE_FILE)
    else
      result=$(grep $1 $DATABASE_FILE | sed 's/.*'$DELIMITER'//')
    fi
    if [ -z "$result" ]; then
        result="No result found"
    fi
    echo -e $result
  else
    error_parameters
  fi
}

do_insert () {
  if [ $# -eq 2 ]; then
    echo $1$DELIMITER$2 >> $DATABASE_FILE
  else
    error_parameters
  fi
}

do_delete () {
  if [ $# -eq 1 ]; then
    result=$(grep -v $1 $DATABASE_FILE)
    echo -e "$result" > $DATABASE_FILE
  else
    error_parameters
  fi
}
