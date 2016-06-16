#!/bin/bash
set -e
node_modules/phantomjs/bin/phantomjs --wd > /dev/null &
pid=$!
trap "kill $pid" INT TERM EXIT
mix test --only integration