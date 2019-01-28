#!/bin/bash

jiraissue.sh $1

while true; do
  read -p "Type Y to open this ticket in a browser? " result
  case $result in
    [Yy]* ) jira issue open $1; break;;
    * ) break;
  esac
done
