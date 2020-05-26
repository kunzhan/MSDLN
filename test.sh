#!/usr/bin/env sh
set -e
$HOME/caffe/build/tools/caffe test --model=./prototxt/newtest_paviau0.prototxt --weights=./snapshot/newsolver_paviau0_iter_20000.caffemodel -iterations=2096 -gpu=0