# Initialization file for the TMUX terminal
# By Jia Jun Ngeo (jia.jun@deriv.com)

if ! [[ "$TERM" =~ "screen".* ]]; then
	echo "Fatal: this script must run inside TMUX";
	exit;
fi

tmux rename-window "Terminal";
tmux splitw -h ;
tmux splitw;

#VIM
tmux new-window -n 'Enginnering Board' vim;

#HELP
tmux new-window -n 'Help me' less ~/help/vim-help;
