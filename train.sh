#!/usr/bin/env sh
set -e
$HOME/caffe/build/tools/caffe train --solver=./prototxt/newsolver_paviau0.prototxt $@