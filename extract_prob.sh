#!/usr/bin/env sh
set -e
rm -f test/newpaviau_prob.txt
cp test/test_paviau.log test_data.log
cat test_data.log |grep "Batch ., prob" |awk '{print $9}' >& temp1.txt
cat test_data.log |grep "Batch .., prob" |awk '{print $9}' >& temp2.txt
cat test_data.log |grep "Batch ..., prob" |awk '{print $9}' >& temp3.txt
cat test_data.log |grep "Batch ...., prob" |awk '{print $9}' >& temp4.txt
cat temp4.txt >>temp3.txt
cat temp3.txt >>temp2.txt
cat temp2.txt >>temp1.txt
cat temp1.txt >>test/newpaviau_prob.txt
rm -r test_data.log temp1.txt temp2.txt temp3.txt temp4.txt