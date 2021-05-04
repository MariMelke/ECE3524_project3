#!/bin/bash


for_loop () {
	#for each file inside the given directory
	for i in `find $1 -maxdepth 1 -mindepth 1` ; do 
		#specify folder name
		path=`basename "$i"`
		#check that folder/file is readable (you have read permission)
		if [ -r "$i" ]
		then
			echo -n "$4" >> $2
			#check that directory is not empty
			if [ "$(ls -A $1)" ] 
			then
 				echo "<li>$path" >> $2
 				echo "$4 <ul>" >> $2
 			else
 				echo "<li>$path</li>" >> $2
 			fi
 			#set the deth of the root
 			num="$3"
 			#decrease for each layer
 			((num--))
 			#check that we got all the for loops we need
 			if [ $num > 0 ]
 			then 
 				#for loop for each folder inside directory
 				for_loop "$i" "$2" "$num" "$4  " "$3"
 				echo "$4 </ul>" >> $2
 				echo "$4</li>" >> $2
 			
 			fi
 		fi
 	done
	
}
#Initialize variables for arguments
#first_arg=$1
second_arg=$1
a=1
mystring='.html'

#Check that we are given correct number of arguments
if [ $# == $a ]
then
	#Check that given output file in in html format
	if [[ "$second_arg" == *.html ]]
	then

		num=0
		#print the paths for calculatuon uses only
		cd ~
		ls -R > $second_arg
		#read each path and choose which is the longest to know how many for loops to do
		while IFS= read -r line
		do
			#check how many folders by taking the nuber of backslashes
 			 res="${line//[^'/']}"
 			 #set the number 
 			 num=$((${#res}>num ? ${#res} : num))
		done < "$second_arg"
		#change the html file with the necessary list types
		echo "<!DOCTYPE html>" > $second_arg
		echo "<html>" >> $second_arg
		echo "<body>" >> $second_arg
		echo "<li>$HOME" >> $second_arg
		echo " <ul>" >> $second_arg
		#For loop instantiation for all the folders inside given directory
		for_loop "$Home" "$second_arg" "$num" "  " "$num"
		#close your lists
		echo " </ul>" >> $second_arg
		echo "</li>" >>$second_arg
		echo "</body>" >> $second_arg
		echo "</html>" >>$second_arg

		#find directories and subdirectories in the given root and output them on the html file in a tree form

	else

		#else print an error message for user to give correct format for output file

		echo "The output file you have given is not an html file. Please try again with the right tye of file"	

	fi		

else

	#else print an error message for user to give correct number of arguments

	echo "Number of arguments entered does not match the number of arguments the script needs. Please enter the correct number of arguments."

fi
