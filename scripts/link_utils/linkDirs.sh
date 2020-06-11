#!/usr/bin/env bash

#arg 1: FILES_DIR TO LINK TO
#arg 2: replace target pattern (of the actual files directory)
#arg 3: replacer pattern (of the link names directory)
#arg 4: debug "1" will not actually link "0" will link
function linkDirs(){
	#initialize arguments
  FILES_DIR=$1
	REPLACE_TARGET=$2
	REPLACER=$3
	LINK_IN_DEBUG=$4
  if [ -z $FILES_DIR ]; then
    echo "Link files arg 1 given empty"
		#exit
  elif [ -z $REPLACE_TARGET ]; then
    echo "Link files arg 2 given empty"
		#exit
	#replacer can be an empty string ""
  elif [ -z $LINK_IN_DEBUG ]; then
    echo "Link files arg 4 given empty"
		#exit
	fi

  #listing files in dir
  FILES=($(find "$FILES_DIR" -maxdepth 1 -mindepth 1 -type d -name "*"))

  #create link names and link
  for FILE in "${FILES[@]}" ; do
		if [ -z $REPLACER ]; then
      LINK=${FILE//$REPLACE_TARGET/}
		else
      LINK=${FILE//$REPLACE_TARGET/$REPLACER}
		fi

		#linking actually
		if [ "$LINK_IN_DEBUG" = "1" ]; then
			#debug
			echo "(debug)linking file:$FILE to link:$LINK"
		elif [ "$LINK_IN_DEBUG" = "0" ]; then
			#actually linking
			echo "linking file:$FILE to link:$LINK"
			#take a backup if the file exists
		        if [ -d $LINK ]; then
			  mv $LINK "$LINK.dot_bak"
			fi
      ln -sfn $FILE $LINK
		fi
  done
}
