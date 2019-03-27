#!/bin/bash
set -eu
(exec goapps > /dev/null 2>&1)&

if [ $# -gt 0 ] ; then
  exec $@
fi

exec nginx -g "daemon off;"
