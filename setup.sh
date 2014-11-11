#!/bin/sh
set -e

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(dirname $0)
readonly ARGS="$@"

install_babushka() {
  echo ""
  echo "Installing babushka..."
  echo ""

  # Need a version which supports Ubuntu 14.04
  sudo sh -c "`curl https://babushka.me/up/83cd1aa`" < /dev/null
}

install_babushka_if_missing() {
    command -v babushka >/dev/null 2>&1 \
        || install_babushka
}

install_devenv_tools() {
    echo ""
    echo "Installing devenv tools"
    echo ""

    cd $PROGDIR
    babushka "Travel App"
}

main() {
    install_babushka_if_missing
    install_devenv_tools
}
main