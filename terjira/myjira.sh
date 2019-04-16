#!/bin/bash

#jira sprint active -b 7

jira issue jql "assignee = currentUser() AND resolution = Unresolved order by updated DESC"
