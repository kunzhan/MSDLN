#!/usr/bin/env sh
for i in 0 1 2 3 4 5 6 7 8 9
do
set -e
$HOME/caffe/build/tools/caffe test --model=./prototxt/newtest_paviau$i.prototxt --weights=./snapshot/newsolver_paviau${i}_iter_20000.caffemodel -iterations=2096 -gpu=0 &> test/test$i.log
done