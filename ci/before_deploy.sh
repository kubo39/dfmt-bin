set -ex

main() {
    local src=$(pwd) \
          stage=$(mktemp -d)

    git submodule update --init --recursive
    cd dfmt/
    dub build --build=release
    cp dfmt $stage/

    cd $stage
    tar czf $src/$PACKAGE_NAME-$TRAVIS_TAG-$TARGET.tar.gz *
    cd $src

    rm -rf $stage
}

main
