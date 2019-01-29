#!/bin/bash

if [[ -z "$BRANCHPREFIX" ]]; then
  echo 'The BRANCHPREFIX environment variable was not found'
  exit 1
else
  RESULT=`jira issue $1 |
    head -n 4 |
    tail -n 1 |
    sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" |
    cut -c 5- | 
    sed -e "s/..$//g" |
    tr "[:upper:]" "[:lower:]" |
    sed -e "s/[\(\)<>-\:]/ /g" | #Replace these characters with spaces
    sed -e "s/[',]//g" | #Replace these characters with nothing
    tr -s " " | #Collapse spaces
    sed -e "s/[[:space:]]/-/g" | #Convert spaces to -
    sed -e "s/-$//g"` #Remove last - if at end of line
fi

git checkout -b $BRANCHPREFIX/$1-$RESULT
