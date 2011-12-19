######################################################################
# Environmental variables {{{
######################################################################

export HOME=/home/matti
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/games
export CDPATH=.:..
export TMPDIR=/tmp

if [[ $(hostname) = 'homunculus' ]] then
  export MAIL=
  MAY_BECOME_ROOT=1
fi

if [[ $(hostname) = 'eris' ]] then
  export MAIL=/home/matti/Mail/INBOX
fi

# }}}
######################################################################

######################################################################
# Limits?
######################################################################

######################################################################
# some more variables {{{
######################################################################

export CC=gcc
export COLORTERM=yes
unset  SCREENDIR

export EDITOR=vim
export PAGER=less
export BROWSER=elinks

# skipscreenwhensearching,clear,quit@eof,ic,longprompt
# export LESS=aCeiM
export LESS=aCiM # Don't quit at eof
export BC_ENV_ARGS=$HOME/.bcrc

# Locales
# export LC_C=de_DE
# export LC_ALL=de_DE
# export LC_CTYPE=de_DE
export LC_C=en_US.UTF8
export LC_ALL=en_US.UTF8
export LC_CTYPE=en_US.UTF8

# Mails
export MAILPATH=$MAIL
export MAILCALL='New Mail in INBOX! '

# Directory stack
# 'auto_cd' has to be set
# Show directories with 'd' = 'dirs -v'
# Chance directory with 'cd +number'
DIRSTACKSIZE=30

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

# Spelling correction
# %R = current command
# %r = suggestion
SPROMPT='zsh: Correct '%R' to '%r' ? ([y]es/[n]o/[e]dit/[a]bort) '

# Colors for 'ls' and completions
export LS_COLORS='no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;33:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.bz2=1;35:*.gz=1;31:*.tar=1;31:*.zip=1;31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.tgz=1;31:*.taz=1;31:*.html=1;34:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36:*.php3=1;31'

# More colors
red='[0;31m'
white_on_blue='[0;37;44m'
green='[0;32m'
yellow='[0;33m'
blue='[0;34m'
magenta='[0;35m'
cyan='[0;36m'
nocolor='[0m'



ZSHFUNC=/usr/share/zsh/$ZSH_VERSION/functions
autoload colors
colors # ?


# }}}
######################################################################

######################################################################
# Functions {{{
######################################################################

# precmd () {
#   TMPPATH="        "$PWD
#   SHORTPATH=${(M)TMPPATH%?????????}
#   PS1=$(echo "$blue$SHORTPATH$nocolor,$yellow$RANDOM$nocolor,$red%j$nocolor%# ")
# 
#   if [[ $(hostname) = 'eris' ]] then
#     PS1=$(echo "$red$SHORTPATH$nocolor,$green%j$nocolor%# ")
#   fi
# 
#   settitle "zsh: "$PWD
# }

# PROMPT=%3~'> '
# PROMPT='%B%Uzsh%u>%b '
PROMPT='%{$blue%}%B%Uzsh%u%b%{$nocolor%}> '
# PROMPT=$(echo "$redzsh> ")

if [[ $(hostname) = 'eris' ]] then
  PROMPT='%{$red%}%B%Uzsh%u%{$nocolor%}>%b '
fi

RPROMPT=''

# collision with ^F - won't happen very often
# precmd() {
#   if [[ ! -z $jobstates ]]; then
#     RPROMPT='%B(%j)%b'
#   else
#     RPROMPT=''
#   fi
# }

# 2008-04-03 solved
precmd() {
  local jobprompt="%B(%j)%b"
  if [[ ! -z $jobstates ]]; then
    RPROMPT=${RPROMPT%"${jobprompt}"}$jobprompt
  else
    RPROMPT=${RPROMPT%"${jobprompt}"}
  fi
}

preexec() {
    settitle -- "$1"
}

# Dictionary function
_dict() {
  if [[ $# = 0 ]]
    then
    echo "Usage:    $0 word"
    echo "Example:  $0 ubiquitous"
    echo "Start the text browser on www.m-w.com to look the definition for word"
  else
    noglob links http://www.m-w.com/cgi-bin/dictionary?$1
  fi
}

# A quick globbing reference, stolen from GRML.
help-glob() {
echo -e "
    /      directories
    .      plain files
    @      symbolic links
    =      sockets
    p      named pipes (FIFOs)
    *      executable plain files (0100)
    %      device files (character or block special)
    %b     block special files
    %c     character special files
    r      owner-readable files (0400)
    w      owner-writable files (0200)
    x      owner-executable files (0100)
    A      group-readable files (0040)
    I      group-writable files (0020)
    E      group-executable files (0010)
    R      world-readable files (0004)
    W      world-writable files (0002)
    X      world-executable files (0001)
    s      setuid files (04000)
    S      setgid files (02000)
    t      files with the sticky bit (01000)
 print *(m-1)          # Dateien, die vor bis zu einem Tag modifiziert wurden.
 print *(a1)           # Dateien, auf die vor einem Tag zugegriffen wurde.
 print *(@)            # Nur Links
 print *(Lk+50)        # Dateien die ueber 50 Kilobytes grosz sind
 print *(Lk-50)        # Dateien die kleiner als 50 Kilobytes sind
 print **/*.c          # Alle *.c - Dateien unterhalb von \$PWD
 print **/*.c~file.c   # Alle *.c - Dateien, aber nicht 'file.c'
 print (foo|bar).*     # Alle Dateien mit 'foo' und / oder 'bar' am Anfang
 print *~*.*           # Nur Dateien ohne '.' in Namen
 chmod 644 *(.^x)      # make all non-executable files publically readable
 print -l *(.c|.h)     # Nur Dateien mit dem Suffix '.c' und / oder '.h'
 print **/*(g:users:)  # Alle Dateien/Verzeichnisse der Gruppe >users<
 echo /proc/*/cwd(:h:t:s/self//) # Analog zu >ps ax | awk '{print $1}'<"
}


# }}}
######################################################################

######################################################################
# One-liners {{{
######################################################################

# "m"ake directory and "cd" to it
mcd() { mkdir -p "$@"; cd "$@" }  # mkdir && cd

# Find all files with suid set in $PATH
# suidfind() { ls -latg ${(s.:.)PATH} | grep '^...s' }
# suidfind() { ls -latg $path | grep '^...s' }
  suidfind() { ls -latg $path/*(sN) }

# Change XTerm title
settitle() {
  case $TERM in
  xterm*|*rxvt)
    echo -n "\033]0;$@\007\r";;
    # \r = carriage return. ugly hack. better ideas?
  *)
    : ;;
  esac
}

alias zcalc="source $ZSHFUNC/Misc/zcalc"

# 2007-10-04
#source $ZSHFUNC/Zle/keeper
#bindkey '^Xk' insert-kept-result


# }}}
######################################################################

######################################################################
# Options {{{
######################################################################

setopt \
NO_all_export \
   always_last_prompt \
NO_always_to_end \
   append_history \
   auto_cd \
   auto_list \
   auto_menu \
NO_auto_name_dirs \
   auto_param_keys \
   auto_param_slash \
   auto_pushd \
   auto_remove_slash \
NO_auto_resume \
   bad_pattern \
   bang_hist \
NO_beep \
   brace_ccl \
   correct_all \
NO_bsd_echo \
   cdable_vars \
NO_chase_links \
NO_clobber \
   complete_aliases \
   complete_in_word \
   correct \
   correct_all \
   csh_junkie_history \
NO_csh_junkie_loops \
NO_csh_junkie_quotes \
NO_csh_null_glob \
NO_dvorak \
   equals \
   extended_glob \
   extended_history \
   function_argzero \
   glob \
NO_glob_assign \
   glob_complete \
NO_glob_dots \
   glob_subst \
   hash_cmds \
   hash_dirs \
   hash_list_all \
   hist_allow_clobber \
   hist_beep \
   hist_ignore_dups \
   hist_ignore_space \
NO_hist_no_store \
NO_hist_no_functions \
   hist_save_no_dups \
   hist_verify \
NO_hup \
NO_ignore_braces \
NO_ignore_eof \
   interactive_comments \
NO_list_ambiguous \
NO_list_beep \
   list_packed \
   list_types \
   long_list_jobs \
   magic_equal_subst \
NO_mail_warning \
NO_mark_dirs \
NO_menu_complete \
   multios \
NO_nomatch \
   notify \
NO_null_glob \
   numeric_glob_sort \
NO_overstrike \
   path_dirs \
   posix_builtins \
NO_print_exit_value \
NO_prompt_cr \
   prompt_subst \
   pushd_ignore_dups \
   pushd_minus \
   pushd_silent \
   pushd_to_home \
   rc_expand_param \
NO_rc_quotes \
NO_rm_star_silent \
   rm_star_wait \
NO_sh_file_expansion \
   sh_option_letters \
   short_loops \
NO_sh_word_split \
   share_history \
NO_single_line_zle \
NO_sun_keyboard_hack \
   unset \
NO_verbose \
NO_xtrace \
   zle


# }}}
######################################################################

######################################################################
# Aliases {{{
######################################################################

alias a=alias
alias ua=unalias

# job control
alias  1='fg %1'
alias  2='fg %2'
alias  3='fg %3'
alias  4='fg %4'
alias  5='fg %5'
alias  6='fg %6'

# alias 11='bg %1'
# alias 22='bg %2'
# alias 33='bg %3'
# alias 44='bg %4'
# alias 55='bg %5'
# alias 66='bg %6'

alias  j='jobs -l'

# Show all processes, tree
alias px='ps aufx'

# Change to parent directories. Invaluable!
alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

# Cf. 'DIRSTACKSIZE'
alias d='dirs -v'

# Shorthands
alias l='less'
alias v='vim'

# Quiet.
alias bc='bc -q'

# Efile: Edit config files
alias Emutt='vim ~/.muttrc'  # muttrc
# alias Emutt='vim ~/.mutt/muttrc'  # muttrc
# alias Ealias='vim ~/.mutt/alias'  # addresses
alias Evim='vim ~/.vimrc'         # vimrc
# alias Eslrn='vim ~/.slrnrc'       # slrnrc
# alias Escore='vim ~/.slrn/score'  # Scorefile (killkillkill!)

# Important gpg commands
# gget:  get key
# glist: show key and fingerprint
# gput:  upload key
# gsigs: list key signatures
alias  gget='gpg --recv-keys'
alias glist='gpg --fingerprint --list-keys'
alias  gput='gpg --send-keys'
alias gsigs='gpg --list-sigs'

# Show the ten latest ...
alias lsnew='ls -rtl -- *(.) | tail'
# ... and oldest files.
alias lsold='ls  -tl -- *(.) | tail'

# locate && updatedb ?

# ls! ls! ls!
alias ls='ls --color=auto' # Color! '$LS_COLORS'
alias la='ls -a'           # Show dotfiles
alias ll='ls -lAh'         # List and almost all (without . und ..) and human-readable
alias lsd='ll -d'          # LSD. Yeah. Don't show content of directories
alias sl=ls                # Verschreiber, typo

# Screen. W00t!
alias   S='screen'        # screen
alias  sr='screen -r'     # reattach
alias sdr='screen -D -r'  # de-reattach
alias sls='screen -ls'    # list attached, detached and dead screens
alias  sx='screen -x'     # Eine Attachte screensession 'betrachten'

# grep with colors and case insensitive.
alias grep='grep -i --color=auto'

# vim
alias vi==vim
alias vom=vim
alias vm=vim

# make
# alias Cc='CDPATH="" ./configure' ?
alias make='CDPATH="" make'

alias W='wget'
alias mirror='noglob wget --mirror --no-parent --convert-links'
alias irb="irb --simple-prompt" # irb mit zweibuchstabigem Prompt
alias man="TERM=mostlike man" # man hat less mit tollem terminfo als Pager
alias rgb='less /etc/X11/rgb.txt' # Tabelle aller RGB-Farben
alias myip='lynx -dump tnx.nl/ip'

# No config files
alias null-mutt='mutt -n -f /dev/null -F /dev/null'
alias null-zsh='zsh -f'
alias null-vim='vim -u NONE'
alias null-irssi='irssi --config=/dev/null'

# Edit and source .zshrc
alias  __='$EDITOR ~/.zshrc'
alias ___='source  ~/.zshrc'

# Keymappings
alias kru='setxkbmap ru'
alias kus='setxkbmap us'
alias kde='setxkbmap de'

# Global aliases. Get expanded everywhere.
alias -g C=' | wc -l'
alias -g CW='| wc -w'
alias -g CC='| wc -c'
alias -g G=' | grep'
alias -g P=' | less'
# 2007-06-16: ganzer Bildschirm wird gefuellt
alias -g H=" | head -n $(( +LINES?LINES-4:10 ))"
alias -g T=" | tail -n $(( +LINES?LINES-4:10 ))"
alias -g V=' | vim -'
alias -g X=' | xargs'

alias -g NE="2> /dev/null" # No Errors
alias -g NO="&> /dev/null" # No Output
alias -g DN=/dev/null

# sudo aliases
if [[ ! -z $MAY_BECOME_ROOT ]] then
  # networking
  for a (ifup ifdown ifconfig iwconfig iwlist iwpriv ettercap)
    alias $a="sudo $a"

  alias suvi="sudo vim"
  # alias Ettercap="sudo ettercap -C -i eth1"
  # alias ethcon="sudo mii-tool -w eth1"

  # Aptitude, apt-get
  alias apt-get="sudo apt-get"
  alias    A="sudo aptitude"   # Aptitude's search is more detailed
  alias   Ai="apt-get install" # but it tends to install strange dependencies.
  alias  Ais="apt-get install -s"
  alias   Ar="apt-get remove"
  alias  Aup="apt-get update"
  alias Augs="apt-get upgrade -s"
  alias  Aug="apt-get upgrade"
  alias   As="A search"
  alias  Ash="A show"

  for i in Start Restart Stop Reload ; do
    eval "$i() { sudo /etc/init.d/\$1 ${i:l} ; }"
  done
fi

alias traffic="vnstat -tr"

# Julius: 2006-12-17: Better prompt for sudo
alias sudo="sudo -p '%u->%U, enter password: '"

alias ssm="ssh matti@feh.name"
alias ssmt='ssh -D 3333 -L 8118:localhost:8118 matti@feh.name' # with tunnels

# 2008-02-21: like ',d' in vim
bindkey -s ',dd' "`date +"%Y-%m-%d"`"
alias df='df -h' # human readable ;)
alias xdvi='xdvi -s 7'
#alias aterm='aterm -fade 50'

alias musb='mount /media/usb'
alias umusb='umount /media/usb'
alias mpmp='sudo mount /dev/sdb /media/usb'
alias umpmp='sudo umount /media/usb'

alias wlu='ifup wlan0'
alias wld='ifdown wlan0'

alias blsh='urxvt -bg black -fg white'

alias uzbl-flash="XDG_DATA_HOME=/usr/share/uzbl/examples/data XDG_CONFIG_HOME=/usr/share/uzbl/examples/config uzbl"
alias uzbl-nf="XDG_DATA_HOME=/usr/share/uzbl/examples/data XDG_CONFIG_HOME=/usr/share/uzbl/examples/config uzbl -c ~/.uzbl"


# }}}
######################################################################

######################################################################
# Modules {{{
######################################################################

# Tetris!! Tetris?
if [[ ! -z $TETRIS ]]; then
  autoload -U tetris
  zle -N tetris
  bindkey "^X^T" tetris # Cx-Ct to play
fi


# }}}
######################################################################

######################################################################
# Completions {{{
######################################################################

# pre-installed completions for various programs
autoload -U compinit
compinit
# colored completion and menu-select
zmodload -i zsh/complist

# Ifnore certain patterns for completion
# fignore=( .BAK .bak .alt .old .aux .toc .swp \~) # OLD STYLE
# zstyle ':completion:*:(all-|)files' ignored-patterns \
#   "(*.BAK|*.bak|*.alt|*.old|*.aux|*.toc|*.swp|*\~)"

# Completion for make
_make() {
  _wanted targets expl targets \
    compadd install clean remove uninstall deinstall
}
compdef _make make

_newest_files() {
  local f expl
  f=( *~.*(omN[1,10]) )
  _wanted files expl 'ten newest files' compadd -a f
}
compdef _newest_files XXX
zle -C newest-files menu-select _newest_files
bindkey '^Xl' newest-files

# Julius: 2007-10-03: complete word from history
_hist_complete() {
  _main_complete _history
}
zle -C hist-complete menu-select _hist_complete
bindkey '^H' hist-complete

# cd & co.: Nur in Verzeichnisse.
# compctl -g '*(-/)' + -g '.*(/)' cd chdir dirs pushd rmdir dircmp cl # OLD STYLE!
# compdef '_files -g "*~.*(/)"' cd chdir dirs pushd rmdir
# tar & co.: Nur Archivdateien und Verzeichnisse.
compctl -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' gunzip gzcat zcat
# Soundprogramme: Sounds + Playlisten + Verzeichnisse.
compctl -g '*.(mp3|MP3|ogg|OGG|temp|TEMP|m3u|pls)' + -g '*(-/)' mpg123 xmms EP
# Browser: Nur HTML-Seiten und Verzeichnisse.
compctl -g "*.html *.htm" + -g "*(-/) .*(-/)" + -H 0 '' w3m lynx elinks wget opera EL O
# xpdf: Nur PDFs und Verzeichnisse.
compctl -g '*.(pdf|PDF)' + -g '*(-/)'  xpdf pdf2ps
# Bilderanzeige: Nur Bilder und Verzeichnisse.
compctl -g '*.(jpg|JPG|jpeg|JPEG|gif|GIF|png|PNG|bmp)' + -g '*(-/)' gimp xv display gqview
# xdvi: DVIs und Verzeichnisse.
compctl -g '*.dvi' + -g '*(-/)' dvips xdvi gxdvi
# lp und gv: Postscript-Dateien und Verzeichnisse.
compctl -g '*.ps' + -g '*(-/)' lp gv
# Für die Funktionen Start, Stop, Reload und Restart: Nur Dienste
compctl -g "$(echo /etc/init.d/*(:t))" Start Restart Stop Reload

# Max of 2 errors per command
# zstyle ':completion:*:correct:*' max-errors 2 numeric
# Shows original strings as well
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:correct:*' insert-unambiguous true

# Functions to use for completion
zstyle ':completion:*' completer _complete _correct _approximate
# Globbing (default)
zstyle ':completion:*' glob true

# 2008-02-06
# zstyle ':completion:*:default' list-prompt '%SMatches %M    Line %L     %P%s'
MENUPROMPT='%SMatches %M    Line %L     %P%s'

# 2007-10-01
zstyle ':completion:*:history:*' remove-all-dups yes

# Verbose. Verbose!
zstyle ':completion:*' verbose yes
# Format der Corrections, Warnungen, etc.
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*' group-name ''
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:default' list-colors $ls_colors # huh?

# Bei der Completion: Menü mit inversen aktiven Einträgen. Cool!
zstyle ':completion:*' menu yes=long-list
zstyle ':completion:*' menu select=2

# Cache - Geschwindigkeitsverbesserung?
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zshcompcache


# More completions

# SSH - Erst User, dann Host.
zstyle ':completion:*:ssh:*' group-order 'users' 'hosts'

zstyle ':completion:*:*:scp:*' list-colors ${(s.:.)LS_COLORS}

# cd - Erst lokale Verzeichnisse, dann vom Dir-Stack, dann Hashes,
# dann aus dem $PATH...
zstyle ':completion:*:cd:*' completer  _history _alternative _cd
zstyle ':completion:*:cd:*' tag-order history-words \
  local-directories directory-stack named-directories path-directories

# rm - Reigenfolge: Erst Backupdateien, dann Bytecoimpiled Files,
# danach core-Files, erst dann restliche Dateien.
zstyle ':completion:*:*:rm:*' file-patterns '(*~|\\#*\\#):backup-files' \
  '*.zwc:zsh\ bytecompiled\ files' 'core(|.*):core\ files' '*:all-files'
# kill - unglaubliche Completions!
zstyle ':completion:*:kill:*' command 'ps xf -u $USER -o pid,%cpu,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' insert-ids single
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# less und mutt: Umfangreiches Menü.
zstyle ':completion:*:*:less:*' menu yes select
zstyle ':completion:*:*:mutt:*' menu yes select

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' auto-description 'specify: %d'

# 2005-07-25: Completion für Aptitude-Aliase
compdef _aptitude A
compdef '_deb_packages avail' Ai Ais As Ash # Alle Pakete
compdef '_deb_packages installed' Ar    # Nur installierte Pakete



svn () {
  umask 022
  command svn "$@"
}


# }}}
######################################################################

######################################################################
# Keybindings. Vi rules! {{{
######################################################################

# Standardmäßige vi-Keybindings.
bindkey -v # Auch Sachen wie 2wd3w0PAfoobar sind möglich!
# Home- und End-Keys.
# bindkey '\e[1~' beginning-of-line
# bindkey '\e[4~' end-of-line
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
# ^B inserts last argument
bindkey '^B' insert-last-word
# Eingabe eines Kommandos und Drücken der Pfeil-nach-oben-Taste veranlasst
# die Zsh, eine hostory-Suche zu starten.
bindkey "^[[A"   up-line-or-search
bindkey "^[[B" down-line-or-search
# 2005-04-13: Aus der GRML-Zshrc: ^P fügt das letzte Wort ein.
insert-last-typed-word() { zle insert-last-word -- 0 -1 }; \
  zle -N insert-last-typed-word; bindkey "^p" insert-last-typed-word

# 2005-02-27: Navigation im Completion-Menü. GENIAL!
# Navigation in der Completion-Liste (Tab-Tab): hjkl wählt aus, Return fügt ein
# und beendet das Menü (wobei es weiterhin angezeigt wird) und i fügt ein und
# lässt das Menü offen, um eine weitere Vervollständigung einzufügen.
# Die Befehle funktionieren nur, *nachdem* zsh/complist geladen wurde!
bindkey -M menuselect 'h' vi-backward-char                # links
bindkey -M menuselect 'j' vi-down-line-or-history         # unten
bindkey -M menuselect 'k' vi-up-line-or-history           # oben
bindkey -M menuselect 'l' vi-forward-char                 # rechts
# Fügt die Completion auf der Kommandozeile ein, lässt aber das Menü
# für eine Weitere Vervollständigung offen.
bindkey -M menuselect 'i' accept-and-menu-complete
# Fügt die Completion auf der Kommandozeile ein und zeigt dann ein
# Menü mit weiterhin möglichen Completions. "Engere Auswahl"
bindkey -M menuselect 'o' accept-and-infer-next-history

# 2005-07-10
# setopt globs_complete: Completionmenü statt einfügen aller Möglichkeiten
# Expansion von *.txt -> file1.txt, file2.txt... mit ^E
bindkey "^E" expand-word

# Julius: 2005-09-14: caphusos Tip
# Divine!
run-with-sudo () { LBUFFER="sudo $LBUFFER" }
zle -N run-with-sudo
bindkey '^Xs' run-with-sudo

# 2005-10-28: push line to buffer
bindkey '^K' push-line


# }}}
######################################################################

######################################################################
# Misc {{{
######################################################################

# if [[ $(hostname) = 'eris' ]] then
#   # De-re-attach
#   if [[ $(screen -ls | wc -l) == 4 ]]
#     then
#       if [[ $(echo $STY | grep -c `hostname` ) == 0 ]]
#         then
#       #if [[ -z $STY ]]; then
#           sleep 1 # Willkommensnachricht lesen...
#           /usr/bin/screen -d -r
#       fi
#   fi
# fi

# Clever comment
# if [[ -z "$STY" ]]; then /usr/bin/screen -d -r main >/dev/null; fi
# if [[ -z "$STY" ]]; then /usr/bin/screen -d -r >/dev/null; fi

# 2005-12-24: Hide certain commands from being saved to history
# (uses hist_ignore_space option)
for i in mplayer cd wipe; do
  eval "alias $i=' $i'"
done

# 2006-04-24: 
flv2mpeg() {
  if [[ -z "$1" || ! -e "$1" ]]; then
    echo Usage: $0 VideoFile.flv
    echo Use http://keepvid.com to download the FLV file.
  else
    ffmpeg -i $1 -ab 56 -ar 22050 -b 500 -s 320x240 ${1:r}.mpeg
  fi
}

# Julius: 2007-04-08: EH07, nice idea! (tcsh-like)
# When Tab is pressed on an empty(!) command line,
# the content of the directory is printed (`ls`)
# instead of a menu list of all executables:
# % cd /usr/src/
# % <Tab>
# linux-2.6.14.3        9p
# fuse.tar.bz2          thinkpad.tar.gz
  complete-or-list() {
    if [[ $#BUFFER == 0 ]]; then
      echo
      ls
      zle reset-prompt
    else
      zle expand-or-complete
    fi
  }
  zle -N complete-or-list
  bindkey '^I' complete-or-list

# 2007-10-03: temporarily display $PWD
# display_pwd() {
#   if [[ $#RPROMPT -gt 0 ]]; then
#     RPROMPT=''
#   else
#     RPROMPT='%/' # <- PWD
#   fi
#   zle reset-prompt
# }
# zle -N display_pwd
# bindkey '^F' display_pwd

display_pwd() {
  if [[ ${(M)RPROMPT#??} == "%/" ]]; then
    RPROMPT=${RPROMPT#%/}
  else
    RPROMPT="%/"$RPROMPT # <- PWD
  fi
  zle reset-prompt
}
zle -N display_pwd
bindkey '^F' display_pwd

#source "/usr/share/zsh/$ZSH_VERSION/functions/Zle/keeper"
#bindkey '^Xk' insert-kept-result
#alias -g K=' | keep'
#alias   rk='r K'

# Julius: 2008-03-05
histgrep () {
          fc -l -m "*$1*"
}

autoload insert-unicode-char
zle -N insert-unicode-char
bindkey '^Xi' insert-unicode-char

# ibm_write enable fan/status
ibm_write() {
  sudo sh -c "echo $1>/proc/acpi/ibm/$2"
}

# powerdot presentations
makpdf() {
  dvips "$1.dvi"
  ps2pdf "$1.ps"
}


# }}}
######################################################################

# vim:set sw=2 nowrap: EOF
