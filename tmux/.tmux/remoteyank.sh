#!/usr/bin/env bash

set -eu

# get data either form stdin or from file. "$@" returns array of every argument
buf=$(cat "$@")

# some nc need -c flag to close instantly after connection 
echo $buf | nc -q0 localhost 5556
