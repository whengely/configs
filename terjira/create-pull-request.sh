#!/bin/bash
branch="$(git branch-name)"
ticket="$(echo $branch | cut -d / -f 2 | cut -d - -f 1,2)"

vsts code pr create --auto-complete --delete-source-branch -t master "$@" >/dev/null

ticket_number_pattern="[0-9]"
ticket_number="$(echo $ticket | cut -d - -f 2)"

if [[ $ticket_number =~ $pattern ]]; then
  jira issue trans $ticket "Resolved" >/dev/null
fi
