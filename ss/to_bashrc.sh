bold=$(tput bold)
normal=$(tput sgr0)
echo "FROM ${bold}BASHRC${normal}"

PS1="\@ | \u | \W   ▶  "
PATH="$PATH:~/trinkets/apples"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

prof(){
    echo -n -e "\033]50;SetProfile=$1\x7"
}

inv(){
    printf "\e[?5h"
}

rev(){
    printf "\e[?5l"
}

img(){
    echo "";
    imgcat $1;
    echo "";
}

yt_filename(){
    youtube-dl $1 | grep .mp4 | sed 's/[][]//g; s/Destination: //; s/download//; s/ has already been downloaded//; s/ //;'
}

ytsave(){
    OLD=$(yt_filename "$2");
    NEW=$1;
    if [  -d "$NEW"  ]; then
	echo "${bold}$NEW${normal} is already a directory.";
	echo "file saved in working directory as ${bold}$OLD${normal}.";
    elif [  -f "$NEW"  ]; then
	echo "${bold}$NEW${normal} is already a file.";
	echo "file saved in working directory as ${bold}$OLD${normal}.";
    else
	mv "$OLD" "$NEW";
	echo "file saved in working directory as ${bold}$NEW${normal}."
    fi
}

ytplay(){
    OLD=$(yt_filename "$2");
    NEW=$1;
    if [  -d "$NEW"  ]; then
        echo "${bold}$NEW${normal} is already a directory.";
	echo "file saved in working directory as ${bold}$OLD${normal}.";
	mplayer "$OLD";
    elif [  -f "$NEW"  ]; then
        echo "${bold}$NEW${normal} is already a file.";
        echo "file saved in working directory as ${bold}$OLD${normal}.";
	mplayer "$OLD";
    else
        mv "$OLD" "$NEW";
	echo "file saved in working directory as ${bold}$NEW${normal}."
	mplayer "$NEW";

    fi
}

vplay(){ mplayer $1; }

start(){
    if [ $# -eq 1 ]; then
	if [  -d "$1"  ]; then
            echo "${bold}$1${normal} already exists.";
	elif [  -f "$1"  ]; then
            echo "${bold}$1${normal} already exists.";
	else
	    if [[ $1 == *"."* ]]; then
		touch "$1"
		echo "${bold}$1${normal} saved as file in working directory."
	    else
		mkdir "$1"
		echo "${bold}$1${normal} saved as directory in working directory."
	    fi

	fi

    elif [ $# -eq 2 ]; then
	if [[ $1 == *"-f"* ]]; then
	    if [  -d "$2"  ]; then
		echo "${bold}$2${normal} already exists.";
    	    elif [  -f "$2"  ]; then
		echo "${bold}$2${normal} already exists.";
            else
		touch "$2"
		echo "${bold}$2${normal} saved as extensionless file in working directory."
	    fi
     
	elif [[ $1 == *"-o"* ]]; then
	    if [  -d "$2"  ]; then
		echo "${bold}$2${normal} already exists.";
            elif [  -f "$2"  ]; then
		echo "${bold}$2${normal} already exists.";
            else
		if [[ $2 == *"."* ]]; then
                    touch "$2"
		    open "$2"
                    echo "${bold}$2${normal} saved as file in working directory."
		    echo "opened file ${bold}$2${normal}"
		else
                    mkdir "$2"
		    cd "$2"
                    echo "${bold}$2${normal} saved as directory in working directory."
		    echo "in new directory ${bold}$2${normal}"
		fi

            fi
    	fi
	
	elif [ $# -eq 3 ]; then
	    if [[ ( $1 == *"-f"*  &&  $2 == *"-o"* ) || ( $1 == *"-o"*  &&  $2 == *"-f"*  ) ]]; then
		if [  -d "$3"  ]; then
            	    echo "${bold}$3${normal} already exists.";
		elif [  -f "$3"  ]; then
            	    echo "${bold}$3${normal} already exists.";
		else
                    touch "$3"
		    open "$3"
                    echo "${bold}$3${normal} saved as extensionless file in working directory."
		    echo "opened file ${bold}$3${normal}"
		fi
	    fi
	fi
}