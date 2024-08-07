#!/bin/bash

source "$(dirname "$0")/utils.sh"

print_usage() {
  echo "Usage: $0 [smartphone|computer]"
  exit 1
}

if [ $# -ne 1 ]; then
  print_usage()
fi

case "$1" in
  smartphone)
    customize_smartphone()
    ;;
  computer)
    customize_computer()
  *)
    print_usage()
