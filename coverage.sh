#!/usr/bin/env bash

if ! brew list | grep -q 'lcov'; then
    brew install lcov
fi

echo "==============> run : flutter test --coverage"
fvm flutter test --coverage

path="report"

echo "==============> run : genhtml coverage/lcov.info"
genhtml coverage/lcov.info -o $path

echo "==============> open report"
open $path/index.html

