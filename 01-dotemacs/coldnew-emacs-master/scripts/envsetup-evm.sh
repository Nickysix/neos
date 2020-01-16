#!/bin/sh

# From: https://gist.githubusercontent.com/rejeep/ebcd57c3af83b049833b/raw

# This script will setup Evm (Emacs Version Manager) and Cask on
# Travis to use for Emacs Lisp testing.
#
# In .travis.yml, add this:
#
#  - curl -fsSkL https://gist.github.com/rejeep/ebcd57c3af83b049833b/raw > x.sh && source ./x.sh
#
# Emacs 24.3 is installed in the above script because Cask requires
# Emacs 24 to be installed. Because of this, when installing other
# environments in the .travis.yml configuration, use the --skip
# option, for example:
#
#  - evm install $EVM_EMACS --use --skip

export PATH="$HOME/.evm/bin:$PATH"
export PATH="$HOME/.cask/bin:$PATH"

git clone https://github.com/rejeep/evm.git $HOME/.evm
evm config path /tmp
evm install emacs-24.3-travis --use --skip

#curl -fsSkL https://raw.github.com/cask/cask/master/go | python