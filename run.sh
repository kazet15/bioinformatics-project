#!/bin/bash

d1="3 1 5 4 0 1"
d2="0 6 2 2 4 6"
t1="13 1"
t2="1 18"
tosses="500"

echo $d1 > data
echo $d2 >> data
echo $t1 >> data
echo $t2 >> data

echo "$d1 $d2 $t1 $t2 $tosses" | ./Bio 1> >(tee | tail -n+5 >> data) 2> >(tee > dice)

python viterbi.py > viterbi.txt
sed -i.bak 's/\s/\n/g' dice
sed -i.bak 's/\s/\n/g' viterbi.txt
python fwbw.py > fwbw.txt

./plot.pg > plot.png & xdg-open plot.png
