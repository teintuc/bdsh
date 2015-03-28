#!/bin/sh
## bdsh.sh for bdsh in /u/ept2/teintu_c/rendu/shell/bdsh
## 
## Made by charles teinturier
## Login   <teintu_c@epita.fr>
## 
## Started on  Wed Jan 17 13:48:15 2007 charles teinturier
## Last update Tue Jul  3 10:40:42 2007 charles teinturier
##
#!/bin/sh

error_and_leave()
{
	echo -e "Syntax error "
	exit 1
}

count_syntax()
{
	number=$1
	if [ $# -neq $number]
	then
		error_and_leave
	fi
}

if [ $# -eq 0 ]
then
	error_and_leave
fi
file=sh.db
delim="||"
for ARG in $@ $ARGS
do
  case $ARG in
      -f)
	  shift
	  file=$1
	  ;;
      put)
	  if [ $# -eq 3 ]
	      then
	      echo $3 | grep '^\$' > /dev/null
	      if [ $? -eq 0 ]
		  then
		  tmp=$(echo $3 | sed 's/^\$//')
		  result=$(grep $tmp $file | sed 's/.*||//')
		  echo $2$delim$result >> $file
	      else
		  echo $2$delim$3 >> $file
	      fi
	  else
		error_and_leave
	  fi
	  ;;
      del)
	  if [ $# -eq 3 ]
	      then
	      result=$(grep -v $2 $file)
	      echo -e "$result" > $file
	      exit 1
	  else
		error_and_leave
	  fi
	  ;;
      select)
	  if [ $# -eq 2 ]
	      then
	      grep $2 $file | sed 's/.*||//'
	  else
		error_and_leave
	  fi
	  ;;
  esac
done
