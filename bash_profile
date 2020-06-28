#!/bin/bash
# * * * * * * * *
# >> EXPORT ZONE
# envir variables


# Ensure that HOME is correct
export HOME="/Users/nathaniel"
# My very own private bin
export PATH="$PATH:$HOME/bin"
# C0L0R1FY ls, part 1
export LSCOLORS="GxfxcxdxBxegedabagacad"
# Check for mail more often
export MAILCHECK=10



# * * * * * * * *
# >> SCRIPT ZONE
# why do it urself?


echo >> "$HOME/.intrusions.log"
date +"Logged in to `tty` on %C%y-%m-%d at %H:%M:%S" >> "$HOME/.intrusions.log"
echo >> "$HOME/.intrusions.log"

# Require ` to be typed at start of session,
# unless this was run from my .bashrc
# If anything other than ` is typed,
# send everything that is typed to a log.

#securerID="$(uuidgen)"
#( nohup securer "$securerID" & ) < /dev/null &> /dev/null
#read -srn 1 -t 4 char
#touch "$HOME/.started$securerID"
#if [ "$char" != \` -a -t 0 ]; then
#	exec spy "$char" "$securerID"
#fi
#touch "$HOME/.secured$securerID"

# Display the current working directory
if [ "`pwd`" = '/Users/nathaniel' ]; then
    echo "pwd: `pwd`"
else
    printf "pwd: \e[31m`pwd`\e[0m"
    echo
fi

# Display the tty
echo "tty: `tty`"

# Alert if SIP isn't enabled
if [ "`csrutil status`" = 'System Integrity Protection status: enabled.' ]
    then echo "sip: OK"
else
    printf "\e[31mSystem Integrity Protection is Disabled!\e[0m"
    echo
fi

# Fortune Cookie
echo
fortune -s
echo

# Run cscgy which runs scgy if it is between 2:00 and 4:00 on a weekday
cscgy cscgy 2> /dev/null



# * * * * * * * *
# >> ALIAS ZONE
# don't like typing


# Wifi toggle: wifi on, wifi off
alias wifi="networksetup -setairportpower en0"
# Typing just "sudo" behaves like su, but loads your .bash_profile and such
alias sudo="sudo -i"
# A quicker way to type exit
alias q="exit"
# 5h0w 0ff ur m4d h4ck1ng 5ki11z
alias hack=". ~/bin/matrix2.bash"
# Edit .bash_profile
alias vbp="vi ~/.bash_profile; . ~/.bash_profile"
# C O L O R I F Y  ls and pwd when 'ls'ing
alias ls='echo -n "pwd: "; pwd; ls -GH'
# Grep for SSH-related log entries
alias sshl="cat /var/log/system.log | grep sshd | sed '1!G;h;\$!d' | sed -e 's/^/* /' | fold -w 100 -s"
# Typo protection
alias bbc='printf "Did you mean bc? "; read -n 1 char; if [ "${char}" = y ]; then bc; fi'
# Generate an OAuth nonce and timestamp
alias oauth="php -f /Users/nathaniel/Desktop/2legOAuthGenerator.php"
# Easily view terminal dimensions using the magic of tput
alias dim='echo $(tput cols)x$(tput lines)'
# Make rm safe
alias rm='rm -i'
# Convert strings into elements
alias elem='while echo -n "> "; read; do per $REPLY; done'
# Improve pip install
alias 'pipin'='sudo -H pip install --default-timeout=100'
# Clean up broken pieces of disrupted securer logins.
# Only run when no logins are in progress.
alias 'rmsec'='rm ~/.started* ~/.secured* ~/.securing*'



# * * * * * * * *
# >> SHOPT ZONE
# i got options


shopt -s cdspell



# * * * * * * * * *
# >> FUNCTION ZONE
# alias++


# Prints and says $1$1$1 ... $2
function longe {
	c=0
	sleeptime=0
	let sleeptime=$sleeptime+$3
	while :; do
		let c=$c+1
		word="${2}"
		for throwaway in `seq 1 $c`
			do word="${1}${word}"
		done
		echo $word
		say $word
		sleep $sleeptime
	done
}

# Counts down from 9 to 0 in a cute box using box
function timebox {
	c=10
	while [ $c -gt 0 ]; do
		let c=$c-1
		clear
		box $c
		sleep 1
	done
}

# cd to $1, pwd, then ls
function cdc {
	cd "$1"
	ls
}

# Adds #!/bin/bash, then opens the file with vim, then makes it executable
function vib {
	test ! -e "${1}" && printf "#!/bin/bash\n\n" > "${1}"
	vim "${1}"
	chmod +x "${1}"
}

# Opens a not previously existing file with vim, then deletes it
function vit {
	if [ -e "$1" ]; then
		echo "That file already exists!"
	else
		vim "$1"
		rm "$1"
	fi
}

# Finds c given a and b using the pythagorean theorem
function ptg {
	step1=$(($1*$1+$2*$2))
	step2=$(bc -l <<< "sqrt(${step1})")
	echo "$step1"
	echo "$step2"
}

# Runs ptg in a loop, taking a and b from stdin each iteration
function ptgl {
	while echo -n "> "; read in1 in2; do
		p "$in1" "$in2"
		echo
	done
}

# Runs biber on my project
function bib {
	cd /Users/nathaniel/Desktop/Science\ Project/HFetch\ Report
	biber main
}

# Calculates blast of an Orb of Devastation
function orb {
	expense="$1"
	nDice=$(((expense-100000)/1000))
	dam=0
	i=0
	echo
	tput sc
	while [ $i -lt $nDice ]; do
		tput rc
		echo $((100*i/nDice)).$((100*i%nDice/nDice))
		dam=$((dam+($RANDOM%10)+1))
	done
	i=1
	while [ $dam -gt 0 ]; do
		echo $((i*50)) ft \($((i*50/5280)) mi\): $dam
		dam=$((dam/2))
		i=$((i*2))
	done
}

# Calculates average blast of an Orb of Devastation
function orba {
	expense="$1"
	dam=$((11*(expense-100000)/2000))
	i=1
	while [ $dam -gt 0 ]; do
		echo $((i*50)) ft \($((i*50/5280)) mi\): $dam
		dam=$((dam/2))
		i=$((i*2))
	done
}

# Uploads a folder to github. Argument 1 is the folder, arg 2 is the URL.
function gup {
	cd "$1"
	git init
	git add *
	git commit -m "Initial Commit"
	git remote add origin "$2"
	git push -u origin master
}

# Runs liq repeatedly from the desktop, taking options after each run:
# Hit enter to keep options the same
# Input "-" and hit enter to clear options
# Otherwise, input "-p", "-v", "-pv", "-vp", "-p -v", or "-v -p".
function liqr {
    while read input; do
        if [ $input ]; then
            if [ $input = "-" ]; then
                opts="";
            else
                opts=$input;
            fi;
        fi;
        clear;
        /Users/nathaniel/Desktop/liq $opts;
    done
}

# Looks through files specified in $2 for image IDs relating to the given MID class in $1, then downloads them to the folder "FromAWS"
function openimg {
    for line in $(
        grep -h "$1" "$2"
    ); do
        if [ "$(printf "%.*f\n" "0" "$(bc <<< "$(echo "$line" | cut -d , -f 4) * 100 / 1")")" -gt 70 ]; then
            id=$(echo "$line" | cut -d , -f 1)
            aws s3 --no-sign-request cp s3://open-images-dataset/train/"$id".jpg FromAWS;
            magick convert "FromAWS/${id}.jpg" -scale '64!x64!' "FromAWS/${id}.jpg"
            
        fi
    done
}

# Sets the mac's volume using AppleScript
# Volume ranges from 0 to 100
volume () {
    osascript -e "set volume output volume $@ without output muted" 
}




# * * * * * * * * * * * *
# >> AUTOGENERATED ZONE
# leave the bots alone


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
