#!/bin/sh

if [ -n "$DEBUG" ] ; then
  set -x
fi

if [ -n "$JAVA_HOME" ] ; then
  if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
    JAVACMD="$JAVA_HOME/jre/sh/java"
  else
    JAVACMD="$JAVA_HOME/bin/java"
  fi
  if [ ! -x "$JAVACMD" ] ; then
    echo "Error: JAVA_HOME is set to an invalid directory: $JAVA_HOME" >&2
    exit 1
  fi
else
  JAVACMD=java
  if ! command -v java >/dev/null 2>&1 ; then
    echo "Error: JAVA_HOME is not set and no 'java' command could be found in your PATH." >&2
    exit 1
  fi
fi

GRADLE_PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$GRADLE_PROJECT_ROOT/gradle/wrapper/gradle-wrapper.jar" ]; then
  exec "$JAVACMD" -jar "$GRADLE_PROJECT_ROOT/gradle/wrapper/gradle-wrapper.jar" "$@"
else
  echo "Error: Could not find gradle-wrapper.jar. Please ensure it exists in gradle/wrapper/." >&2
  exit 1
fi
