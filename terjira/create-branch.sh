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
    sed -e "s/[\(\)<>-\:]/ /g" | 
    sed -e "s/[',]//g" |
    tr -s " " |
    sed -e "s/[[:space:]]/-/g" |
    sed -e "s/-$//g"`
fi

if [[ -z "$JIRA_USER" ]]; then
  echo ' THE JIRA_USER environment variable was not found'
  exit 1
else
  jira issue trans $1 "In Dev" >/dev/null
  jira issue assign $1 $JIRA_USER >/dev/null
fi

git checkout -b $BRANCHPREFIX/$1-$RESULT
