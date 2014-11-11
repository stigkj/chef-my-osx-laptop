#!/bin/sh
set -e

# Can't use $HOME, because sometimes it's not set.
# Can't use ~, because it depends on $HOME to expand.
# Can't use ~$(whoami) directly, because it doesn't expand inline.
# So: write a string in which ~$(whoami) is expanded, and run it in a subshell.
home=$(sh -c "echo ~$(whoami)")
: ${me:=$(whoami)}

from="https://$me@github.com/stigkj/chef-my-osx-laptop.git
to="$home/dev/mine/babushka-my-machines

interactive=$([ -t 0 ] && echo 'true' || echo 'false')

true_with() { echo -e "\n$1"; true; }
false_with() { echo -e "\n$1"; false; }

has() {
  type "$1" >/dev/null 2>&1
}

pkg_manager() {
  managers="aptitude apt-get brew pacman yum pkg_add"
  for manager in ${managers}; do
    has "$manager" && echo "$manager" && exit
  done
}

update_manager() {
  case $(pkg_manager) in
    apt-get) sudo apt-get update -qqy ;;
    aptitude) sudo aptitude -y update ;;
    brew) brew update ;;
    pacman) sudo pacman --sync --refresh ;;
    yum) true ;;
    pkg_add) true ;;
    *)
  esac
}

install_pkgs() {
  case $(pkg_manager) in
    apt-get) sudo apt-get install -qqy $1 ;;
    aptitude) sudo aptitude -y install $1 ;;
    brew) brew install $1 ;;
    pacman) sudo pacman --sync --noconfirm --noprogressbar $1 ;;
    yum) sudo yum -y install $1 ;;
    pkg_add) sudo pkg_add -r $1 ;;
    *)
  esac
}

logo() {
cat <<"LOGO"

Something other - babushka-my-machines
,--,--'               .       ,.
`- | ,-. ,-. .  , ,-. |      / |   ,-. ,-.
 , | |   ,-| | /  |-' |     /~~|-. | | | |
 `-' '   `-^ `'   `-' `'  ,'   `-' |-' |-'
                                   |   |
                                   '   '
LOGO
}

can_install() {
  pkg=$1

  if ! has $(pkg_manager); then
    false_with "Sorry, you don't have $pkg installed, and I couldn't find a package manager I recognise."
  else
    true
  fi
}

check() {
  if [ "$interactive" = 'false' ]; then
    false_with "Sorry, initializing of your machine must be done in an interactive shell."
  else
    if ! has 'git'; then
      can_install 'git'
    elif ! has 'curl'; then
      can_install 'curl'
    else
      true
    fi
  fi
}

welcome() {
  echo ""
  echo "Welcome to my machine!"
  echo ""
  echo "Now we will just clone our git project and setup your machine"
  echo "so you can start developing."
  echo "You will be asked for your password several times. We swear it"
  echo "wont be used for anything bad."
  echo ""

  if has 'git'; then
    echo "- You already have git $(git --version | awk '{print $3}')."
  else
    echo "- You don't have git installed, so we'll install it (using $(pkg_manager))."
  fi

  if has 'curl'; then
    echo "- You already have curl."
  else
    echo "- You don't have curl installed, so we'll install it (using $(pkg_manager))."
  fi

  echo ""
  confirmed=""

  if [ -n "$ZSH_VERSION" ]; then
    vared -p "Sound good? [y/N] " confirmed
  elif [ -n "$BASH_VERSION" ]; then
    read -e -p "Sound good? [y/N] " confirmed
  else
    read -p "Sound good? [y/N] " confirmed
  fi

  case $confirmed in
    "y"*) true;;
    "Y"*) true;;
    *)    false;;
  esac
}

install_pkgs_if_required() {
  if has 'git' && has 'curl'; then
    true # already installed
  else
    pkgs="$(has 'git' || echo 'git') $(has 'curl' || echo 'curl')"
    echo ""
    echo "First we need to install $(echo $pkgs | sed 's/ / \& /') (via $(pkg_manager))."

    update_manager
    install_pkgs "$pkgs"

    if ! has 'git' || ! has 'curl'; then
      false_with "Argh, the install failed."
    else
      echo ""
      echo "- git $(git --version | awk '{print $3}') is present at $(which git)."
      echo "- curl is present at $(which curl)."
      true
    fi
  fi
}

clone_() {
  echo ""
  echo "Then we will clone our git project."
  echo ""
  git clone $from $to
}

on_clone_success() {

  echo ""
  echo "asdf?? is now cloned to $to."
  echo ""
  echo "Now we will setup your machine ???so it is ready for developing on the project."
  echo ""
  true
}

on_clone_failure() {
  echo ""
  echo "Something went wrong during git clone of the project."
  echo ""
  false
}

setup_devenv() {
  $to/tools/init/setup-devenv.sh
}

do_bootstrap() {
  install_pkgs_if_required &&
  clone_travelapp &&
  on_clone_success || on_clone_failure &&
  setup_devenv
}

main() {
  logo
  if check; then
    if welcome; then
      do_bootstrap
    else
      echo ""
      echo "OK, maybe another time. :)"
    fi
  fi
}
main
