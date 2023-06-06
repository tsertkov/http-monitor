#!/bin/bash

exec /scripts/entrypoint.sh $EXECUTOR http_monitor.rb $@
