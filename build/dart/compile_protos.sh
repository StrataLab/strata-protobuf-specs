#!/bin/sh

rm -r ./tmp/protobuf || true
rm -r ./lib/src || true

mkdir -p ./tmp/protobuf || true

cd ../..
cp --parents `find -name \*.proto*` build/dart/tmp/protobuf
cd build/dart

mkdir -p ./lib/src || true

# Compile the "google well-known type" protos
cd ./tmp/protobuf/external_proto
protoc \
    --dart_out=grpc:../../../lib/src \
    $(find ./google -name '*.proto')

# Now compile Strata's type protos
cd ../proto
protoc \
    --dart_out=grpc:../../../lib/src \
    -I . \
    -I ../external_proto \
    $(find . -name '*.proto')

cd ../../..

rm -r ./tmp
