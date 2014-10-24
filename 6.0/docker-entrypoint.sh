#!/bin/bash
set -e

if [ "$1" = 'jira' ]; then
  chown -R atlassian "$JIRA_HOME"
  umask 0027
  exec gosu atlassian /opt/atlassian/bin/start-jira.sh -fg
fi

exec "$@"