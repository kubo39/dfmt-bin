#!/bin/sh

set -ex

git pull

( cd dfmt && git pull )

test -z "$(git status -s)" || (
    git config user.name "Hiroki Noda"
    git config user.email "kubo39@gmail.com"

    git add dfmt
    git commit -m "update the dfmt submodule"

    set +x
    git push https://$(cat ~/.gh_token)@github.com/kubo39/dfmt-bin.git && echo OK
    set -x

    git tag -a v$(grep 'VERSION =' dfmt/src/dfmt/main.d | cut -d'"' -f2)-$(date +"%Y%m%d") -m "deploy"

    set +x
    git push https://$(cat ~/.gh_token)@github.com/kubo39/dfmt-bin.git --tags && echo OK
)
