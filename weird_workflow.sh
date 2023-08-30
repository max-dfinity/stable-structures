#!/bin/zsh
source ~/.shell.d/11-dfinity.sh
IC_REPO=/Users/maximiliansumme/gitlab/ic

update_bazel_file() {
  local REVISION=$1
  local F=$(mktemp)
  cat $IC_REPO/bazel/external_crates.bzl| sed "s/.*UPDATE_MARKER.*/rev=\"$REVISION\", # UPDATE_MARKER/"  > $F
  mv $F $IC_REPO/bazel/external_crates.bzl
}

main() {
push_up_then_reset
REVISION=$(git rev-parse origin/max-spm22-branch)
update_bazel_file "$REVISION"
pushd $IC_REPO
push_up_then_reset
popd
}


main

