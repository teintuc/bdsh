#!/bin/sh
# Pseudo client for bdsh

source ./bdsh.utils.sh
source ./bdsh.func.sh

function handle_command()
{
  # Check if we have commands
  if [ $# -eq 0 ]; then
    return 0
  fi

  # Run specific command depending of the command
  case $1 in
    select)
      do_select $2
    ;;
    insert)
      do_insert $2 $3
    ;;
    delete)
      do_delete $2 $3
    ;;
    quit)
      echo "Bye ... bye ..."
      exit 0
    ;;
    *)
      echo "Unknown command: "$1
    ;;
  esac
}

while :
do
	echo -n "> "
  read command
	handle_command $command
done
