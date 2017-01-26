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


##### Redoing mess of transpose ----------------------
transpose(){

  # first count number of columns
  # by using head to get the first line from the file

  line=$(head -n 1 math.txt)  #this needs to be fixed
  echo "$line  is first line in transpose"

  #initialize empty array, and put this line inside
  numArrs=()
  numArrs=("${numArrs[@]}" $line)
  echo "${numArrs[@]} is in numArrs"

  # count the number of ELEMENTS (aka Columns)
  # https://www.cyberciti.biz/faq/finding-bash-shell-array-length-elements/undo
  echo "${#numArrs[@]} is the number of columns"
  numCols=${#numArrs[@]}
  echo "confirming $numCols"

  # transpose data using for loop from 1 to numCols
  for indexCol in $(seq 1 $numCols)
  do
    echo "$indexCol" >> $tempfile_transpose

    # here is where we initialize empty array for the Column
    colArray=()
    # this is the inside nested loop
    while read line
    do
      #echo "sslkjfd $index" >> $tempfile_transpose
      # create an array, and put the line inside
      #aa=()
      #aa=("${aa[@]}" $line)
      #echo "${numArrs[@]} is what is just read intothe array"
      echo "for col $indexCol, reading a whole row(aka line)"
      tmpArr=()
      tmpArr=("${tmpArr[@]}" $line)
      echo "${tmpArr[@]}  is now in tmpArr"

      # now each time, use $indexCol to find
      colArray+=("${tmpArr[$indexCol]}")
      #echo "we jsut put ${tmpArr[$indexCol]} into the colArray"
      echo "${colArray[@]} is the num of values colArray"

    done < $input
  done


}

#  Old transpose file before clean up Wednesday evening

# transpose function for converting columns into rows
# function will output a new file
transpose(){
  echo "starting transpose"
  # first count number of columns
  # by using head to get the first line from the file
  line=$(head -n 1 "$input")  #this needs to be fixed
  #echo "$line  is first line in transpose"    #deleteLine

  #initialize empty array, and put this line inside
  numArrs=()
  numArrs=("${numArrs[@]}" $line)
  #echo "${numArrs[@]} is in numArrs" # deleteLine

  # count the number of ELEMENTS (aka Columns)
  # https://www.cyberciti.biz/faq/finding-bash-shell-array-length-elements/undo
  # echo "${#numArrs[@]} is the number of columns ******"  # deleteLine
  numCols=${#numArrs[@]}
  # echo "confirming $numCols ***********************"  # delete line

  # transpose data using for loop from 1 to numCols
  for indexCol in $(seq 1 $numCols)
  do
    #echo "$indexCol" >> $tempfile_transpose  # deleteLine

    # here is where we initialize empty array for the Column
    colArray=()
    # this is the inside nested loop
    while read line
    do
      # create an array, and put the line inside
      #aa=()
      #aa=("${aa[@]}" $line)
      #echo "${numArrs[@]} is what is just read intothe array"
      echo "for col $indexCol, reading a whole row(aka line)"
      tmpArr=()
      tmpArr=("${tmpArr[@]}" $line)
      echo "${tmpArr[@]}  is now in tmpArr"

      # now each time, use $indexCol to find
      colArray+=(${tmpArr[$indexCol - 1]})    ### Fix index column minus 1 ######
      #echo "we jsut put ${tmpArr[$indexCol]} into the colArray"


    done < $input
    echo "Finallly........ the colArray is ${colArray[@]}"
    echo ${colArray[@]} >> $tempfile_transpose
    echo "${#colArray[@]} is the num of values colArray" # after reading all rows
  done


}

# columns before changes

#---- For Adding up columns ---------------
elif [[ $1 == -c* ]]
  then
  transpose
  echo "starts with c"
  input=$tempfile_transpose
  echo "now using transpose file"

  echo "-----------  transpose finished -------------"

  while read line
  do
    #echo $line
    # for each row, the array must be cleared to 0 elements!
    # put the line into the array
    numArr=()
    numElementsInRow=0
    numArr=("${numArr[@]}" $line)

    # initialize variable "sum" to hold sum of row
    sum=0
    for i in ${numArr[@]}
      do
        # for each element add 1 to the numElementsInRow
        numElementsInRow=$((numElementsInRow + 1))
        # add the elements value to the sum
        sum=$((sum + i))
      done

    #echo the average for the row. Ensure that numbers are rounded correctly

    average=$(( (sum+(numElementsInRow/2))/numElementsInRow ))
    echo "$average  is the averge"
    #echo "the sum is $sum"
    echo "The number of elements is: $numElementsInRow"
    #echo "the first element is ${numArr[0]}"

    # sort the array
    #echo "${numArr[@]}" # this is how to print the array

    #for i in "${array[@]}"; do echo "$i"; done | sort -n
    #numArr=($(for each in ${numArr[@]}; do echo "$each" ; done | sort -n ))
    numArr=($(for each in ${numArr[@]}; do echo "$each" ; done | sort -n ))


    echo "${numArr[@]} is the sorted row"
    # determine element which to use for median
    median=0
    # if numElementsInRow is odd
    if [[ $((numElementsInRow%2)) -eq 1 ]]
      then
      echo "The median is ${numArr[$((numElementsInRow/2))]}"
    else

      echo "num of elements in row is even"

      # if there are an an even number of elemnts per row
      #choose larger of the two middle values

    fi
    # else numElementsInRow is even

    # echo out the median
  done < $input
