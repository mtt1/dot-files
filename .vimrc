" ~/.vimrc von Julius Plenz, <jp@cvmx.de>, plenz.com
" Version: Sun Apr 30 13:13:55 CEST 2006

" OPTIONS/SETTINGS
" ================

" Continue searching at top when hitting bottom
set wrapscan
" Behave like vi? Hell, no!
set nocompatible
" Always show cursor-position
set ruler
" fancy menu
set wildmenu
" ...and Statusline
set laststatus=2
" Who needs backups?
set nobackup
set whichwrap=b,s,<,>,[,]
" Scroll when 2 lines before bottom of the terminal
set scrolloff=2
set sidescroll=4
" Short the messages
set shortmess=a
" Always show the command
set showcmd
" do not start at beginning of line
set nosol
" Show all changes
set report=0
" dont warn if unsaved buffers are closed
set hidden
" Blinking shows the matching parantheses
set showmatch
" Which parantheses to match
set matchpairs=(:),{:},[:],<:>
" Do I have a fast terminal?
set nottyfast
" do not insert two spaces after each period on joined lines
set nojoinspaces
" Automatically indent
set autoindent
" Automatically write File on Bufer-Change
set autowrite
" Expand Tabs
set expandtab
" How many spaces for indenting
set shiftwidth=4
" Enumerate Lines
set nu
" ^N ^P: Complete from dictionary
set cpt+=k
set dictionary=/usr/share/dict/ngerman,/usr/share/dict/words
"Write Swapfile after typing 50 chars
set uc=50
" Incasesensitive search
set incsearch
" no Visual Bells
set novb
" That's _really_ cool, try it!
set list listchars=tab:��,trail:~,eol:$
" set list listchars=tab:��,trail:~
set tabstop=4
set smarttab
set smartindent
set fdm=marker
" :h 'fo'
set fo=tcrqln " ft=mail?
" Allow the last two lines to be socalled "modelines" in which
" you can type commands vim executes on opening the file.
set modeline
set modelines=2
" Dont automatically wrap
set tw=0
" Include @ and dot in word-keys
set iskeyword=@,48-57,_,192-255,-,.,@-@
" Incasesensitive search
set ignorecase
" <419c9cd0$0$25316$9b4e6d93@newsread2.arcor-online.net>
setlocal cinkeys-=0#  "??

" Colorscheme Murphy looks really cool
" color murphy
"color evening
" colorscheme default
" Transparent Terminals
"" hi Normal ctermbg=NONE
" Enable Syntax-Highlighting
syntax on
" Transparent Terminals
"" hi Normal ctermbg=NONE
" set t_Co=16 to get rid of the bold characters

" Use CSS!
let html_use_css = 1

set viminfo=\"200,%,'200,/200,:200,@100,f1,h

if version>=700
  " hi CursorLine ctermfg=black ctermbg=white
  " set cursorline

  set pumheight=7

  inoremap j <C-R>=pumvisible() ? "\<lt>C-N>" : "j"<CR>
  inoremap k <C-R>=pumvisible() ? "\<lt>C-P>" : "k"<CR>

  map <Leader>tn :tabnew<CR>
  map <Leader>tc :tabclose<CR>
endif

" Abbreviations and Commands
" ==========================

" Set the leader:
let mapleader = ","

" Umlauts
imap <Leader>ae �
imap <Leader>oe �
imap <Leader>ue �
imap <Leader>ss �
imap <Leader>Ae �
imap <Leader>Oe �
imap <Leader>Ue �
" Already implemented via X
" imap `a �
" imap `o �
" imap `u �
" imap `s �
" imap `A �
" imap `O �
" imap `U �
" imap `` `

" Insert current date
imap <Leader>d <C-R>=strftime("%F")<CR>
imap YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>

" Go to normal mode
" imap �� <Esc>

" ThinkPads...
imap <F1> <Esc>

" force using hjkl
:noremap <Up>       :echoerr "Use k instead!"<CR>
:noremap <Down>     :echoerr "Use j instead!"<CR>
:noremap <Left>     :echoerr "Use l instead!"<CR>
:noremap <Right>    :echoerr "Use h instead!"<CR>

" Personal homepage, email
" iab Ym jp@cvmx.de
" iab Yh http://www.plenz.com/

" Fast switching between tw
map _l :set tw=0<CR>
map _L :set tw=70<CR>

" Delete trailing whitespaces
nmap <Leader>tr mm:%s/\s\+$//<CR>`m
vmap <Leader>tr    :s/\s\+$//<CR>

" Mostly used for E-Mailing
" Signaturen in Emails entfernen
map <Leader>qs G?^><CR>?^> -- $<CR>d}
map <Leader>rs G?^><CR>?^> -- $<CR>d}

" Subjectwechsel
" keep old...
map <Leader>sw 1G/^Subject: <CR>:s/Re:/was:/<CR>Wi (<C-O>$)<ESC>0Whi
map <Leader>ns 1G/^Subject: <CR>:s/Re:/was:/<CR>Wi (<C-O>$)<ESC>0Whi
" or set a new one
map <Leader>ss gg/^Subject: <CR>A
map <Leader>to gg/^To: <CR>A
" Inserting Ellipses
iab  Y...  [...]
vmap <Leader>ell c[...]<ESC>

" f�r konfigurationsdateien schnelles letztes �nderungsdatum
map <Leader>C  1G/Letzte �nderung:\s*/e+1<CR>CYDATE<ESC>
map <Leader>c  1G/Latest change:\s*/e+1<CR>CYDATE<ESC>
map <Leader>v  1G/Version:\s*/e+1<CR>CYDATE<ESC>
imap VDATE Version: YDATE

" Make correct quotes
 map <Leader>nq mmgg}VG:s/>>/> >/g<CR>`m
 ":s/^((> ?)*>)([a-zA-Z0-9])/\1 \2/<CR>`m <- doenst work correctly?!
" Dequote Paragraph, sometimes useful
 map <Leader>dp vip:s/^> //<CR>
vmap <Leader>dp    :s/^> //<CR>
" Quote P
 map <Leader>qp   vip:s/^/> /<CR>
vmap <Leader>qp   :s/^/> /<CR>
" Kill Power-Quotes
vmap <Leader>kpq :s/^> *[a-zA-Z]*>/> >/<C-M>
" reformat whole mail
map <Leader>rf mmgg}jVGgq<Esc>`m

" automatically insert greetings
map <Leader>hallo gg}j^2ldwuOHallo, <Esc>pxa!<CR><Esc>j
map <Leader>hi    gg}j^2ldwuOHi, <Esc>pxa!<CR><Esc>j
map <Leader>moin  gg}j^2ldwuOMoin, <Esc>pxa!<CR><Esc>j

" Narrow/Wide Text
" This is a /really/ useful feature. Let's say, you get a Email from a
" person which uses OutlookExpress, one of the worst Mailers ever... ;)
"
" Now let's assume you get a Mail with three long lines, or even worse,
" a Mail with 90 Characters per line. Now you select the whole Mail,
" press ,< some times and format it to 50 chars per line.
"
" Now you can reply to the mail without sending a cruel formatted Email.
 map <Leader>>          :set tw+=2<cr>gqip
vmap <Leader>>     <Esc>:set tw+=2<cr>gvgqgv
 map <Leader><          :set tw-=2<cr>gqip
vmap <Leader><     <Esc>:set tw-=2<cr>gvgqgv

vmap  < <gv
vmap  > >gv

map gn :set nu!<CR>
map gl :set list!<CR>
" map gn :set nu<CR>
" map gN :set nonu<CR>

" LaTeX: Often typed combos
map ,end yyp^ldwiend<Esc>^
map ,End yyp^f}lD^wdwiend<Esc>^

" Swap Words
nmap gw diwea <Esc>pbbhx

" ruby: write "end" and place cursor in insert mode one line above
imap <Leader>re <Esc>oend<Esc>O<Tab>

" Message-ID: <6pcee2-0j9.ln1@vitt.ddns.org> "Expand mutt alias"
map  ,ma ciw<C-R>=substitute(system("mutt -A " . @"), "\n", "", "")<CR><Esc>

" Automatically use certain settings for filetypes
" EMAILING - ft=mail
au FileType mail set ai et ts=4 tw=70 comments=b:#,:%,fb:-,n:>,n:) nosm nonu

" MAN-Pages - ft=man
au FileType man set ai et ts=4 nosm nonu nolist
" LaTeX - ft=latex
au FileType tex set ai et tw=70 sw=4
" au FileType tex imap // \
" au FileType tex imap << {
" au FileType tex imap >> }
au FileType tex imap "" "`"'<Left><Left>
au FileType tex set  makeprg=latex\ %
" \worries command for latex-draft
au FileType tex imap <Leader>w \worries{}<Left>

" BibTeX - ft=bib
"au FileType bib set makeprg=bibtex\ $*

" Cpp - ft=cpp
au FileType cpp set cindent makeprg=g++\ -Wno-deprecated\ -o\ %<\ %
au FileType cpp set ts=8 sw=8

" http://larve.net/people/hugo/2001/02/email-uri-refs/
"source ~/.vim/vimurls.vim

" wenn ich gVim nutze... (manchmal n�tzlich)
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions+=a
    :syntax on
    :colorscheme darkblue
    ":colorscheme oceandeep
    ":colorscheme murphy
endif

" High bits
" hi    HighBitChars ctermfg=yellow ctermbg=red
" match HighBitChars /[�-�]/

" Verschreiber
iab alos        also
iab aslo        also
iab laso        also
iab acuh        auch
iab becuase     because
iab bianry      binary
iab bianries    binaries
iab charcter    character
iab charcters   characters
iab eig         eigentlich
iab exmaple     example
iab exmaples    examples
iab shoudl      should
iab seperate    separate
iab teh         the
iab teil        Teil
iab tpyo        typo
iab bracuht     braucht
iab doer        oder
iab nciht       nicht
iab Dreckfuhler Druckfehler
iab Micheal     Michael
iab Netwokr     Network
iab Srever      Server
iab Standart    Standard
iab standart    standard
iab SIe         Sie
iab ICh         Ich
iab cih         ich
iab shc         sch
iab amchen      machen
iab amche       mache
iab DU          Du
" iab du          Du
iab DIr         Dir
iab Linx        Linux
iab WIen        Wien

" Svens coole Tips:
imap <Leader>** <c-o>B*<c-o>E<right>*
imap <Leader>"" <c-o>B"<c-o>E<right>"
imap <Leader>// <c-o>B/<c-o>E<right>/
imap <Leader>__ <c-o>B_<c-o>E<right>_

" Useful for writing XHTML!
imap <Leader>em <c-o>B<em><c-o>E<right></em>
imap <Leader>st <c-o>B<strong><c-o>E<right></strong>

imap <Leader>li   <Esc>^I<li><Esc>A</li>
imap <Leader>link <Esc>F ld$i<a href="<Esc>pa"><Esc>pa</a>

imap <Leader>h1 <Esc>^I<h1><Esc>A</h1>
imap <Leader>h2 <Esc>^I<h2><Esc>A</h2>
imap <Leader>h3 <Esc>^I<h3><Esc>A</h3>
imap <Leader>h4 <Esc>^I<h4><Esc>A</h4>

vmap <Leader><Leader><> :s/</\&lt;/g<CR>gv:s/>/\&gt;/g<CR>

" vmap <Leader>} /\(> ?\)\+<CR>n

imap <Esc>[3~ <C-H>
set backspace=2
fixdel

" Pseudo�berschriften in Textdokumenten
map <Leader>un yyp:s/./=/g<CR>
" Pseduok�sten aus #-Zeichen
map <Leader>## ^I#<Esc>yyP:s/./\#/g<CR>yyjpk^l

" f�r ccal
map <Leader>Cal a,d 00<Esc>:s/-/ /g<CR>A Beschreibung<Esc>^wwww
map <Leader>cal o,d 00<Esc>:s/-/ /g<CR>A Beschreibung<Esc>^wwww

" Paste und Nopaste
 map <Leader>pon  :set paste<CR>
imap <Leader>pon  <Esc>:set paste<CR>a
 map <Leader>poff :set nopaste<CR>
imap <Leader>poff <Esc>:set nopaste<CR>a

set pastetoggle=<F12>

" Kommentare einf�gen
 map ,mkc O/*<Esc>o*/<Esc>dd

" Riesen-Tab...
imap <Leader>. <Esc>klf wh:se ve=all<CR>jr :set ve=insert<CR>a

" 2005-07-04: http://www.vim.org/tips/tip.php?tip_id=956
" Quote motions for operators: da" will delete a quoted string.
omap i" :normal vT"ot"<CR>
omap a" :normal vF"of"<CR>
omap i' :normal vT'ot'<CR>
omap a' :normal vF'of'<CR>

" Akronyme - eine kleine Sammlung
iab HTMLa <acronym title="HyperText Markup Language">HTML</acronym>
iab XHTMLa <acronym title="eXtensible HyperText Markup Language">XHTML</acronym>
iab CSSa  <acronym title="Cascading Style Sheets">CSS</acronym>
iab PHPa  <acronym title="PHP: Hypertext Preprocessor">PHP</acronym>
iab IRCa  <acronym title="Internet Relay Chat">IRC</acronym>
iab ICQa  <acronym title="I seek you">ICQ</acronym>
iab WWWa  <acronym title="World Wide Web">WWW</acronym>
iab GNUa  <acronym title="GNU's not UNIX">GNU</acronym>
iab GPLa  <acronym title="GNU General Public License">GPL</acronym>
iab PGPa  <acronym title="Pretty Good Privacy">PGP</acronym>
iab IMa   <acronym title="Instant Messenger">IM</acronym>
iab URLa  <acronym title="Uniform Resource Locator">URL</acronym>
iab DVDa  <acronym title="Digital Versatile Disc">DVD</acronym>
iab CDa   <acronym title="Compact Disc">CD</acronym>
iab FTPa  <acronym title="File Transfer Protocol">FTP</acronym>
iab HTTPa <acronym title="HyperText Transfer Protocol">HTTP</acronym>
iab OSa   <acronym title="Operating System">OS</acronym>
iab ALSAa <acronym title="Advanced Linux Sound Architecture">ALSA</acronym>
iab USBa  <acronym title="Universal Serial Bus">USB</acronym>
iab ASCIIa <acronym title="American Standard Code for Information Interchange">ASCII</acronym>
iab FAQa  <acronym title="Frequently Asked Questions">FAQ</acronym>

iab MUAa  <acronym title="Mail User Agent">MUA</acronym>
iab MTAa  <acronym title="Mail Transfer Agent">MTA</acronym>
iab MDAa  <acronym title="Mail Delivery Agent">MDA</acronym>
iab WYSIWYGa <acronym title="What you see is what you'll get">WYSIWYG</acronym>
iab PDFa  <acronym title="Portable Document Format">PDF</acronym>

" Abk�rzungen
iab idRa  <abbr title="in der Regel">idR.</abbr>
iab Abka  <abbr title="Abk&uuml;rzung">Abk.</abbr>
iab uswa  <abbr title="und so weiter">usw.</abbr>

" for mutt: fast changing of "Outboxes"
 map #fk gg}OFcc: +KEEP<Esc>
"map #fo gg}OFcc: +ORKUT<Esc>
"map #ff gg}OFcc: +FREUNDE<Esc>
 map #fa gg}OFcc: +ASK<Esc>
"map #fk gg}OFcc: +KIRCHE<Esc>
"map #fj gg}OFcc: +JUDO<Esc>
 map #fw gg}OFcc: +WIEN<Esc>

" Adding Signatures
" map #sPl Go-- <Esc>:r ~/.sig/plenz<CR>
" map #sA  Go-- <Esc>:r ~/.sig/amnesie<CR>
" map #sLi Go-- <Esc>:r ~/.sig/life<CR>
" map #sML Go-- <Esc>:r ~/.sig/ml<CR>
" map #sPr Go-- <Esc>:r ~/.sig/private<CR>
" map #sV  Go-- <Esc>:r ~/.sig/versions<CR>
" map #sB  Go-- <Esc>:r! fortune bofh-excuses \| sed /^$/d<CR>
" map #sT  Go-- <Esc>:r ~/.sig/TOFU<CR>
" map #sL  Go-- <Esc>:r ~/.sig/less<CR>
" map #sC  Go-- <Esc>:r ~/.sig/counter<CR>
" map #ss  Go-- <Esc>:r ~/.sig/

map #a :$r!agrep -d'^-- $' '.' ~/.sig/signatures<S-Left><S-Left><right>
map #s :$r!agrep -d'^-- $' '.' ~/.sig/signatures<S-Left><S-Left><right>
map #d Go-- <CR>

iab &ndash; &#8211;

" set hlsearch
" map gs :set nohls<CR>
map gs :set hls!<CR>

hi Search term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE

map Y y$

imap <Leader>? (?)

map mm gqip:mak<CR><CR><CR>

" EOF
