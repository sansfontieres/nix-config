#!/bin/sh
# Ran by cron or launchctl, etc.

mbsync=$(which mbsync)
mbsync -a && notmuch new
