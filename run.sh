#!/bin/bash
set -e # Exit if any program returns an error.

#################################################################
# Make the host C++ project.
#################################################################
if [ ! -d debug ]; then
    mkdir debug
fi
cd debug
arch -x86_64 /usr/local/bin/cmake -DCMAKE_BUILD_TYPE=Debug ..
make

#################################################################
# Make the guest Flutter project.
#################################################################
if [ ! -d myapp ]; then
    flutter create myapp
fi
cd myapp
cp ../../main.dart lib/main.dart
flutter build bundle --debug
cd -

#################################################################
# Run the Flutter Engine Embedder
#################################################################
./flutter_glfw ./myapp ${FLUTTER_DIR}/bin/cache/artifacts/engine/darwin-x64/icudtl.dat
