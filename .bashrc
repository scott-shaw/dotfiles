# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# NEW BASH HISTORY
HISTSIZE=9000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups
_bash_history_sync() {
    builtin history -a
    HISTFILESIZE=$HISTSIZE
}
history() {
    _bash_history_sync
    builtin history "$@"
}
PROMPT_COMMAND=_bash_history_sync
 
if [[ "$-" =~ "i" ]] # Don't do this on non-interactive shells
then
    # Add MATLAB-style up-arrow, so if you type "ca[UP ARROW]" you'll get
    # completions for only things that start with "ca" like "cat abc.txt"
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color | xterm-kitty) color_prompt=yes ;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

montage_tile() {
	local w="$1"
	local h="$2"
	shift 2

	local border=5
	local bordercolor="black"
	local extra_args=()

	while [[ "$1" == --* ]]; do
		case "$1" in
		--border)
			border="$2"
			shift 2
			;;
		--bordercolor)
			bordercolor="$2"
			shift 2
			;;
		--*)
			extra_args+=("-${1#--}" "$2")
			shift 2
			;;
		esac
	done

	local output="${@: -1}"
	local inputs=("${@:1:$#-1}")

	montage -tile "${w}x${h}" -geometry +0+0 "${inputs[@]}" \
		-border "$border" -bordercolor "$bordercolor" \
		"${extra_args[@]}" "$output"
}

icat_dir() {
	DIR="${1:-.}"
	COLS="${2:-}"

	if [[ ! -d "$DIR" ]]; then
		echo "Error: '$DIR' is not a directory" >&2
		exit 1
	fi

	# Collect image files
	mapfile -t IMAGES < <(find "$DIR" -maxdepth 1 -type f \
		\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
		   -o -iname '*.gif' -o -iname '*.webp' -o -iname '*.bmp' \
		   -o -iname '*.tiff' -o -iname '*.tif' -o -iname '*.avif' \
		   -o -iname '*.svg' \) | sort)

	if [[ ${#IMAGES[@]} -eq 0 ]]; then
		echo "No images found in '$DIR'" >&2
		exit 1
	fi

	TERM_COLS=$(tput cols)
	TERM_ROWS=$(tput lines)

	# Auto-select column count: roughly sqrt(n), clamped to image count
	if [[ -z "$COLS" ]]; then
		COUNT=${#IMAGES[@]}
		COLS=$(awk "BEGIN { c=int(sqrt($COUNT)); print (c<1)?1:c }")
	fi

	ROWS=$(( (${#IMAGES[@]} + COLS - 1) / COLS ))

	# Terminal pixel dimensions
	read -r PX_W PX_H < <(kitten icat --print-window-size | tr 'x' ' ')

	# Single character cell size in pixels
	read -r CHAR_PX_W CHAR_PX_H < <(awk "BEGIN { printf \"%d %d\", int($PX_W/$TERM_COLS), int($PX_H/$TERM_ROWS) }")

	# Cell width in terminal columns and pixels (columns drive layout)
	CELL_COLS=$(( TERM_COLS / COLS ))
	CELL_PX_W=$(( CHAR_PX_W * CELL_COLS ))

	# Derive cell height from the first image's aspect ratio so images fill their
	# column width exactly — eliminating blank horizontal space between columns.
	read -r IMG_W IMG_H < <(identify -format "%w %h\n" "${IMAGES[0]}" 2>/dev/null | head -1)
	if [[ -z "$IMG_W" || "$IMG_W" -eq 0 ]]; then IMG_W=1; IMG_H=1; fi
	CELL_PX_H=$(awk "BEGIN { printf \"%d\", int($CELL_PX_W * $IMG_H / $IMG_W) }")
	CELL_ROWS=$(awk "BEGIN { r=int($CELL_PX_H / $CHAR_PX_H); printf \"%d\", (r<1)?1:r }")

	clear

	# Process one grid row at a time.  Printing blank lines row-by-row lets the
	# terminal scroll in controlled increments; querying the real cursor position
	# after each scroll gives the correct absolute Y for --place, avoiding the
	# staircase that results from using pre-computed TOP values against an origin
	# that shifts whenever the viewport scrolls.
	for (( IROW=0; IROW < ROWS; IROW++ )); do
		# Reserve vertical space for this image row and jump back to its top.
		printf '\n%.0s' $(seq 1 "$CELL_ROWS")
		tput cuu "$CELL_ROWS"

		# Query actual cursor row (1-indexed) via ANSI DSR, convert to 0-indexed.
		IFS='[;' read -sdR -p $'\033[6n' _ CURR_Y _ < /dev/tty
		CURR_Y=$(( CURR_Y - 1 ))

		for (( ICOL=0; ICOL < COLS; ICOL++ )); do
			IDX=$(( IROW * COLS + ICOL ))
			[[ $IDX -ge ${#IMAGES[@]} ]] && break
			LEFT=$(( ICOL * CELL_COLS ))

			convert "${IMAGES[$IDX]}" \
				-resize "${CELL_PX_W}x${CELL_PX_H}" \
				png:- \
			| kitten icat \
				--place "${CELL_COLS}x${CELL_ROWS}@${LEFT}x${CURR_Y}" \
				--align left \
				--scale-up \
				--stdin=yes
		done

		# Advance cursor past this image row.
		tput cud "$CELL_ROWS"
	done
}

export EDITOR=nvim
export GIT_EDITOR=nvim
alias gext=gnome-extensions-cli
alias mux=tmuxinator
alias icat='kitten icat --align left'
alias ls='lsd'
alias cat="batcat --paging=never"

~/pfetch.sh
