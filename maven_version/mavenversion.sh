#!/bin/bash
#author Ranabir Chakraborty

mvn --version > version.txt
echo $(head -n 1 version.txt) > version1.txt
var1=$(awk '{for (I=1;I<NF;I++) if ($I == "Maven") print $(I+1)}' version1.txt)

first=${var1%%.*}
echo $first
last=${var1##*.}
echo $last
mid=${var1##$first.}
mid=${mid%%.$last}
echo $mid
if [[ "$first" -ge "3" && "$mid" -ge "6" && "$last" -ge "0" ]]
then
        echo "maven version is new"
else
        echo "maven version is old"
fi

rm -rf version.txt version1.txt
