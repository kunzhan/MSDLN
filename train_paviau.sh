#!/usr/bin/env sh
for i in 0 1 2 3 4 5 6 7 8 9
do
set -e
$HOME/caffe/build/tools/caffe train --solver=./prototxt/newsolver_paviau$i.prototxt $@ &> test/train$i.log
done