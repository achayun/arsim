" Allow projects having their own local vimrc and automatically include it
set exrc

" Better defaults
set nocompatible
syntax enable
filetype indent on

" Unmap Q as ex mode
map Q <Nop>

" Search
set ignorecase " Smart case search
set smartcase  " needs both
set hlsearch   " Highlight result
set incsearch
set showmatch  " Show matching parentheses etc.

" When working on multiple files, allow a buffer to be hidden so we can move to a different buffer without first saving this one
set hidden

" Set cursor shapes even if shell has different values
if exists('&t_SI')
let &t_SI = "\e[5 q" " Insert mode - bar
let &t_EI = "\e[2 q" " Normal mode - block
let &t_SR = "\e[5 q" " Replace mode - bar
endif

" Make sure viminfo keeps a lot of history
set viminfo='10,\"100,:2000,%

" Restore previous position. Line, column and viewport
autocmd BufReadPost * call RestoreCursor()

function! RestoreCursor()
  if &filetype == 'commit' || &buftype != ''
    return
  endif
  let l = line("'\"")
  let c = col("'\"")
  if l > 0 && l <= line('$')
    call cursor(l, c)
    normal! zz
  endif
endfunction

" Text formatting options. Adjust to style
set formatoptions-=t        " no automatic text wrapping
set formatoptions-=c        " no auto comment wrapping
set formatoptions+=r        " insert comment leader on Enter
set formatoptions+=o        " insert comment leader on o/O
set formatoptions+=j        " keep comment tidy on J

" Tab formatting, see http://vim.wikia.com/wiki/Converting_tabs_to_spaces
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType make setlocal noexpandtab "Makefiles must have real tabs
set softtabstop=4 "Makes 4 spaces feel like tab, adjust to taste
set autoindent

" Readline like shortcuts for commands (C+w is already default)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Utility function to find git root, used later in several functions
function! FindGitRoot()
  let l:gitroot = system('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel' . '2> /dev/null')
  if v:shell_error == 0 " Check if git command was successful
    let l:gitroot = substitute(l:gitroot, '\n\+$', '', '') " Trim newline
    return l:gitroot
  else
    return '' " Return empty string if not in a git repo
  endif
endfunction

" ## Spellcheck. Add languages as needed.
function! ProjectSpellFile()
  let git_root = FindGitRoot()
  if git_root != ''
    let spell_file_path = git_root . '/.spellfile.utf-8.add'
    if filereadable(spell_file_path)
      execute 'set spellfile=' . spell_file_path
    endif
  endif
endfunction

set spell spelllang=en_us
set spellcapcheck= " don't check for capitalization
let s:current_file_path = fnamemodify(resolve(expand("<sfile>:p")), ":h")
autocmd BufReadPost * call ProjectSpellFile()

" ## File explore in-buffer style
" See: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
" Enhanced netrw with vinegar: https://github.com/tpope/vim-vinegar
" mkdir -p ~/.vim/pack/tpope/start
" cd ~/.vim/pack/tpope/start
" git clone https://github.com/tpope/vim-vinegar.git
" In case you don't use vinegar, set netrw to behave nicer
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 0 " Open in current buffer
" let g:netrw_list_hide = '^\.' " Don't show hidden files

" If you're in a git repo, you probably want to browse the project files often.
" This is a handy shortcut to open the directory explorer in the git root of the current project. Remap to liking
" command! ProjectExplore execute 'edit ' . FindGitRoot()
" nnoremap <Leader>e :ProjectExplore<CR>

" ## Color scheme configuration
set termguicolors   " Assume modern terminal supporting full 24 bit colors
set background=dark
highlight clear

if exists("syntax_on")
syntax reset
endif

" mkdir -p ~/.vim/pack/themes/start
" cd ~/.vim/pack/themes/start
" git clone https://github.com/tomasiser/vim-code-dark
colorscheme codedark

" Fix codedark highlight color to match vs code
highlight Search ctermbg=238
highlight MatchParen ctermbg=238
" highlight MatchParen ctermfg=Green ctermbg=None

" Highlight trailing whitespaces - after defining colorscheme!
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
" Add color to colorscheme
hi ExtraWhitespace ctermbg=lightred guibg=lightred


" ## Productivity - Function key shortcuts
" Note: We add ! to make in order to disable vim trying to jump by itself if there are no errors
map <F7> :make! build<CR>
map <F5> :make! run<CR>

" ## ALE - https://github.com/dense-analysis/ale
" mkdir -p ~/.vim/pack/git-plugins/start
" git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
" Always use project linters, but install system wide for:
" brew install yamllint jsonlint

" Automatically fix files when saved
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 200 " milliseconds
autocmd CursorHold * ALEHover

" Show linter name in the message
let g:ale_virtualtext_prefix = '[%linter%] '


highlight ALEWarning ctermfg=208 guifg=#FFA500

" Typescript - Don't try to guess what linters to use or the eslint config.
let g:ale_linters = {
\   'typescript': ['eslint', 'tsserver', 'prettier'],
\}
let g:ale_fixers = {
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_javascript_eslint_use_global = 0
let g:ale_typescript_eslint_use_global = 0

" Fix Vim's own vimscript comments, no idea why it doesn't always work
autocmd FileType vim setlocal comments=:\" commentstring=\"\ %s
autocmd FileType sh setlocal comments=:\# commentstring=\#\ %s
autocmd FileType yaml setlocal comments=:\# commentstring=\#\ %s

" Vim comments: https://github.com/tpope/vim-commentary
" mkdir -p ~/.vim/pack/tpope/start
" cd ~/.vim/pack/tpope/start
" git clone https://tpope.io/vim/commentary.git ~/.vim/pack/git-plugins/start/commentary
" vim -u NONE -c "helptags commentary/doc" -c q
" To comment a block use 'gc'
" VScode like commenting for normal and visual mode. Could never make that work
" nnoremap <C-_> gcc
" vnoremap <C-_> gc

" Some advanced syntax highlighting
" Polyglot: https://github.com/sheerun/vim-polyglot
" git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/plugins/start/vim-polyglot

" Autosave files when tracked in git repo
function! IsGitTracked(file)
    call system('git ls-files --error-unmatch ' . shellescape(a:file) . ' 2> /dev/null')
    return v:shell_error == 0
endfunction


set updatetime=1000 " Default CursorHold delay (ms)
augroup GitAutosaveOnIdle
    autocmd!
    autocmd CursorHold,InsertLeave * if &modifiable && &buftype == '' && getbufvar('%', '&modified') && IsGitTracked(expand('%:p'))| silent! write | endif
augroup END


" Commands I need to memorize:
" a. Yank and use in command:
"    ```
"    viwy
"    :%s/<C-r>0/bar/g
"    ```
"    Register 0 is the last yank register that ignores deletions, unlike the " register
