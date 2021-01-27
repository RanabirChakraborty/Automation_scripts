#!/bin/bash
#author Ranabir Chakraborty


mvnv()
{
        mvn --version > version.txt
        echo $(head -n 1 version.txt) > version1.txt
        var1=$(awk '{for (I=1;I<NF;I++) if ($I == "Maven") print $(I+1)}' version1.txt)

        first=${var1%%.*}
        #echo $first
        last=${var1##*.}
        #echo $last
        mid=${var1##$first.}
        mid=${mid%%.$last}
        #echo $mid
        if [[ "$first" -ge "3" && "$mid" -ge "6" && "$last" -ge "0" ]]
        then
                echo "new"
        else
                echo "old"
        fi
}

if [[ mvnv = "new" ]]; then
        mvn clean install
else
        ./mvnw clean install
fi
