#!/bin/bash

while read line
  do
    numArr=("${numArr[@]}" $line)

		for i in "${numArr[@]}"
		do
			echo "foo $i   ${numArr[@]}"

		done

    #echo $line # or whaterver you want to do with the $line variable
    #echo "$line" | cut -d$'\t' -f2
done < $input


#------------------------------------------------

while read line
do
  # each line gets an array
  numArr=("${numArr[@]}" $line)

  # now add up all values in array
  for i in ${numArr[@]}
		do
			echo "$i"
		done

  echo "The row sum is $sum"
done < $input

# trying for columns -------------
while read X Y Z;
 do a[++i]=$X; b[i]=$Y; c[i]=$Z;
done < $2
echo ${a[@]} , ${b[@]} , ${c[@]}

# for averages works ---------
a=5
b=2
#average is 2.5 aka 3
c=$(( (a+(b/2))/2 ))
echo $c


# Now do the Sorting WORKING --------------  THIS IS THE SORT
#  https://techfertilizer.wordpress.com/2012/06/15/sorting-arrays-in-bash-shell-scripting/

##-------------------------

cut -c1 simplemath.txt   # works only for cutting the first col but not the second
