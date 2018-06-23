" CONFIGURATION:{{{
" LOCALE:{{{
" sets the language of the menu (gvim)
"set langmenu=none
" The following line do not work in Windows 10,
" so you rename the $VIMRUNTIME/lang directory
" or reinstall unchecking the NLS support
" sets the current language (aka locale)
"language English
set enc=UTF-8
"}}}
" MODIFICATIONS TO VIM DEFAULTS:{{{
" TODO set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" Changes to vimrc_example.vim
" as you use Vim always under GIT and make daily backups
set nobackup
set noundofile
"}}}
" VIM ON MS WINDOWS:{{{
if (has('win32') || has('win64'))
  source $VIMRUNTIME/mswin.vim
  behave mswin
" Remove some MS-Windows maps
" CTRL-X and SHIFT-Del are Cut instead of Substract
"vunmap <C-X>
" CTRL-A is Select all instead of Add
"nunmap <C-A>
"vunmap <C-A>
" Use PowerShell as shell
" WARNING: breaks scripts as Vundle…
"set shell=powershell
"set shellcmdflag=-Command
" For debugging external commands
"set shellcmdflag=-Noexit\ -Command
" This seems to improve Fugitive behaviour, as it triggers
" Windows shellxescape (escaping some chars with ^),
"set shellxquote=(
endif
"}}}
" FINDING FILES:{{{
" Search down into subfolders
" Provides tab-completion for all file-related tasks
" WARNING: This is slow in a SilverStripe project, so :lcd to work folders
set path+=**
" Display all matching files when we tab complete (on by default)
" set wildmenu
"}}}
" VIEWS:{{{
" Enables easy saving of views
set viewdir=$HOME/.vim/view
" To automatically save and restore views for *.c files:
"au BufWinLeave *.c mkview
"au BufWinEnter *.c silent loadview
"}}}
" LINE NUMBERS:{{{
set number
set relativenumber
"}}}
" MISCELLANEOUS:{{{
" Enable adding and substracting alpha chars
set nrformats+=alpha
"}}}
"}}}
" KEY MAPPINGS AND MACROS:{{{
" S-Tab not working to reverse file browsing by default in FreeBSD
exe 'set t_kB=' . nr2char(27) . '[Z'
" Change default leader (\)
let mapleader = ","

" Quickly quit Insert mode
inoremap jk <Esc>:w<CR>
inoremap JK <Esc>

" Edit and source _vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :write<CR>:source $MYVIMRC<CR>:echo "vimrc sourced!"<CR>

" Allow saving of read-only files as root
cmap w!! w !su -m root -c "tee % >& /dev/null"

" Tag-related and completion
command! MakeTags !ctags -R
" Jump tags forth and back in help and code
nnoremap <F10> <C-]>
" ambiguous tags (opens a list)
nnoremap g<F10> g<C-]>
nnoremap <F11> <C-T>
inoremap <F10> <C-]>

" Easy buffer select or edit the alternate file 
nnoremap <F6> :buffers<CR>:buffer<Space>
nnoremap <F7> :e #<CR>

" Easier marks navigation
nnoremap è `

" Navigating quickfix / location lists
nnoremap cj :cnext<CR>
nnoremap ck :cprev<CR>
nnoremap cx :cclose<CR>
nnoremap clj :lnext<CR>
nnoremap clk :lprev<CR>
nnoremap clx :lclose<CR>

" Navigating tabs
nnoremap th :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tt :tabedit<Space>
nnoremap tn :tabnext<CR>
nnoremap tm :tabmove<Space>
nnoremap td :tabclose<CR>

" Make space more useful
nnoremap <space> za
"nnoremap <space> viw

" Quickly move lines up and down
nnoremap <leader><up> ddkP
nnoremap <leader><down> ddjP

" Capitalize Word (note backtick used for jumping to end of marked text)
" map! Insert and Command-line modes
noremap! <S-F3> <Esc>gUiwlgue`]a
" Toggle case
nnoremap é ~

" Easy line splitting (replaces look up the word under cursor with "man")
" Joining lines with J
nnoremap K i<CR><Esc>

" Surround (without the plugin)...
" ...visually selected text in quotes (uses marks: `< and `>)
vnoremap <leader>" <Esc>`<i"<Esc>`>a"<Esc>l
" ...word in quotes
nnoremap <leader>" viw<Esc>i"<Esc>bi"<Esc>e2l

" Useful HTML macros
" See IACMailing() later

" Useful text and BBCode macros
" Remove blank lines
let @a = ':g/^$/d'
nnoremap <F2> @a<CR>
" Replace MS Word bullets (shown as e.g. ) or leading blanks with BBCode
let @b = ':%s/^\W\+/[*] /'
nnoremap <F3> @b<CR>
" Change headings case and make them bold,
" add blank lines if necessary
let @c = ':%s/^\(\I\)\(.*\)/[b]\1\L\2[\/b]/'
let @d = ':%s/^\(\I\)\(.*\)/\r[b]\1\L\2[\/b]\r/'
nnoremap <F4> @c<CR>
nnoremap <S-F4> @d<CR>ggdd
" Surround text blocks with [list] tags
let @e = ':%s/^$\n\(\(\S.*\n\)\+\)/[list]\r\1[\/list]/'
nnoremap <F5> @e<CR>
" Insert non-breaking spaces
let @f = ':%s/ \([:;!?»]\)/\="\<Char-160>" . submatch(1)/g'
let @g = ':%s/\(«\) /\=submatch(1) . "\<Char-160>"/g'
nnoremap <Leader>nb @f<CR>@g<CR>
"}}}
" PLUGINS:{{{
" VUNDLE:{{{
filetype off    " required, default configuration restored later

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
" TODO Maybe path is required in Windows, check it
" call vundle#begin('$HOME/vimfiles/bundle/')
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" color scheme
Plugin 'altercation/vim-colors-solarized'
" ftplugin
Plugin 'phalkunz/vim-ss'
" syntax
Plugin 'PProvost/vim-ps1.git'
Plugin 'pangloss/vim-javascript.git'
" utility
Plugin 'jiangmiao/auto-pairs'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'easymotion/vim-easymotion'
"Plugin 'svermeulen/vim-easyclip'
Plugin 'mattn/emmet-vim'
" Filestyle breaks with the default colorscheme because ctermbg is not defined.
" The issue has been solved by disabling ignored patterns, but adds
" an annoying warning so you fork the repository to silence it.
" Nevertheless, other errors appear due to your use of Vim inside tmux and
" xterm, so you disable altogether for the moment being.
"Plugin 'aserebryakov/filestyle'
"Plugin 'Juanitou/filestyle'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-fugitive'
Plugin 'othree/html5.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdcommenter'
Plugin 'arnaud-lb/vim-php-namespace'
" Commented-out while we test Syntastic style checkers
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-syntastic/syntastic'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mattn/webapi-vim'
Plugin 'TTCoach'

" All of your Plugins must be added before the following line
call vundle#end()           " required
filetype plugin indent on   " required
"}}}
" PLUGIN CONFIGURATION:{{{
" (internal and Vundle-managed)
"""""""""""""""""""""""""""""""

" Airline
" NOTE: Airline has Syntastic and Fugitive integration by default

" Emmet custom snippets
" The g:user_emmet_settings variable must be set before loading the plugin!
let g:user_emmet_settings = webapi#json#decode(
      \ join(readfile(expand('~/.vim/.snippets_custom.json')), "\n"))

" FileStyle
"let g:filestyle_ignore = ['help']

" Indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" Netrw Explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1      " split to the right
let g:netrw_winsize = 0   " split to equal sized window
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide .= ',\(^\|\s\s\)\zs\.\S\+' " Ignore dot files
map <leader>x :20Lexplore<CR>

" PHP-CS-Fixer
" TODO: Really required to complement Syntastic style checker
" (PHP_CodeSniffer), which could fix errors itself?
let g:php_cs_fixer_verbose = 1
let g:php_cs_fixer_dry_run = 1

" PHP QA
" Unused while testing Syntastic
"let g:phpqa_php_cmd = "C:/wamp/bin/php/php5.2.9-1/php"

" Syntastic
" Automatically run :Errors to populate local-list
let g:syntastic_always_populate_loc_list = 1
" Add ESLint to the checkers
let g:syntastic_javascript_checkers = ['eslint']
" Add PHP_CodeSniffer to the checkers
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '-n'

" tmux Navigator
" Workaround for default <C-H> map sending a backspace
nnoremap <silent> <BS> :TmuxNavigateLeft<CR>
"}}}
"}}}
" LAYOUT AND COLORS:{{{
" Wraps on words instead of characters
set linebreak
" Console colors in Windows are defined in Console's 16-color settings
"highlight Normal guibg=#131313 ctermbg=0
"highlight Visual guibg=#595959 ctermbg=8
"highlight Normal guifg=#C8C8C8 ctermfg=7
"highlight Normal font=Consolas:h14:cDEFAULT

if has("gui_running")
  set lines=46 columns=92
  " Remove m: Menu bar, g: Grey menu items, t: Tearoff menu items, T: Toolbar
  set guioptions=egrL
  set background=light
  " Set Solarized colorscheme
  let g:solarized_visibility = "normal"
  let g:solarized_contrast = "normal"
  colorscheme solarized
  highlight Normal font=Consolas:h16:cDEFAULT
  highlight SpecialKey gui=bold
else
  " Set Solarized colorscheme
  set background=dark
  let g:solarized_termtrans = 1
  " This is not respected
  let g:solarized_bold = 0
  colorscheme solarized
  let g:airline_theme = 'solarized'
  let g:airline_solarized_normal_green = 0
  let g:airline_solarized_dark_text = 1
  let g:airline_solarized_bg = 'dark'
  let g:airline_powerline_fonts = 1
  " Remove ugly bold coming from Solarized
  " and workaround for FileStyle warning on ctermbg not set
  highlight Normal ctermfg=8 ctermbg=8
endif
"}}}
" FUNCTIONS:{{{
" MyDiff for Windows{{{
" The following one was in the default _vimrc
" You added the ! after function to stop errors when sourcing
if (has('win32') || has('win64'))
  set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        if empty(&shellxquote)
          let l:shxq_sav = ''
          set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
      let &shellxquote = l:shxq_sav
    endif
  endfunction
endif
"}}}
" HTML entities Encode / Decode{{{
function! HTMLEncodeLine()
perl << EOF
  use HTML::Entities;
  @pos = $curwin->Cursor(); # returns (row, col) array
  $line = $curbuf->Get($pos[0]);
  $encvalue = encode_entities($line);
  $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

function! HTMLEncodeAll()
perl << EOF
  use HTML::Entities;
  @pos = $curwin->Cursor();
  for ($count = 1; $count <= $curbuf->Count(); $count++) {
    $line = $curbuf->Get($count);
    # encode non-ASCII, including & (x26)
    $encvalue = encode_entities($line, '^\n\x20-\x25\x27-\x7e');
    $curbuf->Set($count,$encvalue);
  }
  $curwin->Cursor(@pos);
EOF
endfunction

function! HTMLDecodeLine()
perl << EOF
  use HTML::Entities;
  @pos = $curwin->Cursor();
  $line = $curbuf->Get($pos[0]);
  $encvalue = decode_entities($line);
  $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

function! HTMLDecodeAll()
perl << EOF
  use HTML::Entities;
  @pos = $curwin->Cursor();
  for ($count = 1; $count <= $curbuf->Count(); $count++) {
    $line = $curbuf->Get($count);
    $encvalue = decode_entities($line);
    $curbuf->Set($count,$encvalue);
    }
  $curwin->Cursor(@pos);
EOF
endfunction

nnoremap <Leader>Hl :call HTMLEncodeLine()<CR>
nnoremap <Leader>H :call HTMLEncodeAll()<CR>
nnoremap <Leader>hl :call HTMLDecodeLine()<CR>
nnoremap <Leader>h :call HTMLDecodeAll()<CR>
"}}}
" Common search-replace for IAC mailing{{{
" Remove absolute links, target attributes and change some classes
function! IACMailing()
  execute '%s/http:\/\/www\.i-ac\.fr\///g'
  execute '%s/ target="_blank"//g'
  "execute '%s/red-note/red/g'
endfunction

nnoremap <Leader>iac :call IACMailing()<CR>
"}}}
"}}}
" FILETYPES:{{{
" PHP:
" This is automatically applied by Vim
" au BufNewFile,BufRead *.php set fileformat=unix
" HTML:
au! FileType html setlocal ts=2 sw=2
" SilverStripe_template:
augroup SilverStripe
  au! FileType ss.html setlocal ts=2 sw=2
  " Prevent variable attributes to trip the syntax checker
  let g:syntastic_html_tidy_ignore_errors = ['has invalid value "$']
augroup END
" JSON:
au! FileType json setlocal ts=2 sts=2 sw=2 expandtab
" VIM:
au! FileType vim setlocal ts=2 sts=2 sw=2 expandtab foldmethod=marker
" YAML:
au! FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
"}}}
