# * * * * * * * *
# >> EXPORT ZONE
# envir variables


# My very own private bin
export PATH="$PATH:$HOME/bin"
# C0L0R1FY ls, part 1
export LSCOLORS="GxfxcxdxBxegedabagacad"




# * * * * * * * *
# >> ALIAS ZONE
# don't like typing


# C O L O R I F Y  ls and pwd when 'ls'ing
alias ls='echo -n "pwd: "; pwd; ls -GH'
