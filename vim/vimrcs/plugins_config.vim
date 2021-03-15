""""""""""""""""""""""""""""""
" => Install using Vim-plug
""""""""""""""""""""""""""""""
if has('nvim')
      if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
            silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs 
                  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
      endif
else
      if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      endif
endif

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""
" => Lookie
"""""""""""""""""""""""""""""
Plug 'hzchirs/vim-material'
Plug 'itchyny/lightline.vim'

""""""""""""""""""""""""""""""
" => Development
""""""""""""""""""""""""""""""
" ==> Completition
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer --clangd-completer'} | Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'SirVer/ultisnips' | Plug 'dimatura/ultisnip-snippets'
Plug 'derekwyatt/vim-protodef', { 'for': ['c', 'cpp'] }
Plug 'pchynoweth/vim-gencode-cpp', { 'for': ['c', 'cpp'] } | Plug 'pchynoweth/a.vim', { 'for': ['c', 'cpp']}

" ==> Navigating
Plug 'lambdalisue/fern.vim' 
Plug 'tweekmonster/fzf-filemru'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'ludovicchabant/vim-gutentags' | Plug 'skywind3000/gutentags_plus'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'mileszs/ack.vim' | Plug 'jesseleite/vim-agriculture'
Plug 'chaoren/vim-wordmotion'                
Plug 'tpope/vim-rsi'

" ==> Linting
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp']} | Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" ==> Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'oguzbilgic/vim-gdiff'
Plug 'will133/vim-dirdiff'

" ==> Misc
Plug 'ilyachur/cmake4vim',                    " Cmake support
      \{ 'for': ['c', 'cpp']} | Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'kkoomen/vim-doge',                    " Doxygen documentation
      \{ 'do': { -> doge#install() }, 'for': ['c', 'cpp', 'python'] } 
Plug 'sheerun/vim-polyglot'                 " Syntax highlightning
Plug 'jeaye/color_coded',                   " Semantic syntax highlightling
      \{'do': 'rm -f CMakeCache.txt && cmake . && make -j4 && make install', 'for': ['c', 'cpp']}
Plug 'thaerkh/vim-workspace'                " Intersession open buffers saving
Plug 'goerz/jupytext.vim',                  " Open jupyter notebooks as markdown
      \{ 'do': 'pip3 install jupytext'}
Plug 'metakirby5/codi.vim',                 " realtime interpreter
      \{ 'for': ['python', 'cpp']} 
Plug 'weirongxu/plantuml-previewer.vim' | Plug 'tyru/open-browser.vim'
Plug 'AndrewRadev/sideways.vim'             " argument objects
Plug 'alepez/vim-gtest',                    " Google Test support
      \{'for': ['c', 'cpp']}
Plug 'tmsvg/pear-tree'                      " pairs completition
Plug 'Midren/splitjoin.vim'
Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
Plug 'romainl/vim-qf', { 'for': ['qf'] }

"""""""""""""""""""""""""""""
" => Writing
"""""""""""""""""""""""""""""
Plug 'lervag/vimtex',                       " latex
      \{'for': ['tex']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/goyo.vim' | Plug 'amix/vim-zenroom2' | Plug 'junegunn/limelight.vim'

"""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""
Plug 'skywind3000/asyncrun.vim'
Plug 'markonm/traces.vim' " Highlighting default ex substitute
Plug 'tpope/vim-repeat'

call plug#end()

""""""""""""""""""""""""""""""
" => Gutentags
""""""""""""""""""""""""""""""
let g:gutentags_define_advanced_commands = 1
" remove auto maps
let g:gutentags_plus_nomap = 1

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.git', '.root', '.color_coded']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ '--c++-kinds=+p',
      \ '--extra=+q',
      \ '--languages=C++,Python,C,vim'
      \ ]

let g:fzf_tags_command = 'ctags -R --tag-relative=yes --fields=+ailmnS --c++-kinds=+p --extra=+q --languages=C++,Python,C,vim'

if executable('rg')
  let g:gutentags_file_list_command = 'rg -l ""'
endif

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ '.*build.*',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

""""""""""""""""""""""""""""""
" => junegunn/fzf
""""""""""""""""""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.4 } }
let $FZF_DEFAULT_COMMAND='rg -l "" --sort path'
let $FZF_DEFAULT_OPTS="--reverse --tiebreak=length,end,index"
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

let g:fzf_colors =
              \ { 'fg':      ['fg', 'Normal'],
              \ 'bg':      ['bg', 'Normal'],
              \ 'hl':      ['fg', 'Comment'],
              \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
              \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
              \ 'hl+':     ['fg', 'Statement'],
              \ 'info':    ['fg', 'PreProc'],
              \ 'border':  ['fg', 'Ignore'],
              \ 'prompt':  ['fg', 'Conditional'],
              \ 'pointer': ['fg', 'Exception'],
              \ 'marker':  ['fg', 'Keyword'],
              \ 'spinner': ['fg', 'Label'],
              \ 'header':  ['fg', 'Comment'] }

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

nnoremap <silent> <leader>lf :FilesMru --tiebreak=end<cr>
nnoremap <silent> <leader>lr :History<CR>
nnoremap <silent> <leader>lb :Buffers<cr>
nnoremap <silent> <leader>ll :BTags<cr>
nnoremap <silent> <leader>ls :Tags<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => mileszs/ack.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
"
vnoremap <silent> <leader>fd :call VisualSelection('gv', '')<CR>
nmap              <leader>fd :Ack!

""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lambdalisue/fern.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_smart_quit = 0

map <silent> <leader>nt :Fern . -stay -reveal= -drawer -toggle -width=50<cr>
map <silent> <leader>nf :Fern . -stay -reveal=% -drawer -toggle -width=50<cr>

function! s:init_fern() abort
  nmap <buffer><expr> <Plug>(fern-my-open-or-expand)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open)",
      \   "\<Plug>(fern-action-expand:stay)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
  nmap <buffer> <cr>  <Plug>(fern-my-open-or-expand)
  nmap <buffer> l  <Plug>(fern-my-open-or-expand)

  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> i <Plug>(fern-action-open:bottom)
  nmap <buffer> s <Plug>(fern-action-open:right)
  nmap <buffer> N <Plug>(fern-action-new-path)
  nmap <buffer> m <Plug>(fern-action-move)

  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  nmap <buffer> cd <Plug>(fern-action-cd:cursor)

  nmap <buffer> I <Plug>(fern-action-hide-toggle)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> zh <Plug>(fern-action-hidden:toggle)
  nmap <buffer> t <Plug>(fern-action-mark:toggle)j

  nmap <buffer> q :<C-u>quit<CR>
endfunction

function s:is_fern_open() abort
      return fern#internal#window#find( { w -> fern#internal#drawer#is_drawer(bufname(winbufnr(w))) }, )
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd QuitPre * if (winnr('$') == 2 && s:is_fern_open()) | FernDo close | endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

function! s:goyo_enter()
    Limelight
endfunction

function! s:goyo_leave()
    Limelight!
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-clang-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format#detect_style_file = 1
"let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#auto_formatexpr = 0
let g:clang_format#style_options = {
 \ "BasedOnStyle": "LLVM",
 \ "IndentWidth":  4
 \ }

autocmd FileType c,cpp nnoremap <silent> <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <silent> <buffer><Leader>cf :ClangFormat<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1

function! s:in_last_hunk_line(lnum) abort
  " Hunks are sorted in the order they appear in the buffer.
  for hunk in gitgutter#hunk#hunks(bufnr(''))
    " if in a hunk on first line of buffer
    if a:lnum == 1 && hunk[2] == 0
      return 1
    endif

    " if in a hunk generally
    if a:lnum >= hunk[2] && a:lnum == hunk[2] + (hunk[3] == 0 ? 1 : hunk[3]) - 1
      return 1
    endif

    " if hunk starts after the given line
    if a:lnum < hunk[2]
      return 0
    endif
  endfor

  return 0
endfunction

autocmd CursorMoved * if s:in_last_hunk_line(line(".")) | GitGutterPreviewHunk | else | pclose | endif

highlight! link GitGutterAdd SignColumn
highlight! link GitGutterChange SignColumn
highlight! link GitGutterDelete SignColumn

map <silent> ]h <Plug>(GitGutterNextHunk)
map <silent> [h <Plug>(GitGutterPrevHunk)
map <silent> <leader>hs <Plug>(GitGutterStageHunk)
map <silent> <leader>hu <Plug>(GitGutterUndoHunk)
map <silent> <leader>hp <Plug>(GitGutterPreviewHunk)
omap <silent> ih <Plug>(GitGutterTextObjectInnerPending)
omap <silent> ah <Plug>(GitGutterTextObjectOuterPending)
xmap <silent> ih <Plug>(GitGutterTextObjectInnerVisual)
xmap <silent> ah <Plug>(GitGutterTextObjectOuterVisual)
nnoremap <silent> <leader>df :GitGutterToggle<cr>
" Usually you don't need to have list of all hunks, but better list of modified files
"nnoremap <silent> <leader>hl :GitGutterQuickFix<cr>:copen<cr>:cd `git rev-parse --show-toplevel`<cr>
" Even better with Fuzzy Finding )
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :GBranches<CR>
nnoremap <silent> <leader>gs :Gstatus<cr>:resize 12<cr>

nmap <leader>gf :diffget //2<cr>
nmap <leader>gj :diffget //3<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-material
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:material_style='palenight'
set background=light
try
   colorscheme vim-material
   highlight! link SignColumn Conceal

   autocmd FileType c,cpp call s:cpp_highlight_settings()
   function! s:cpp_highlight_settings()
       highlight! link cBlock cppBlock
       highlight! link cppBlock Type
       highlight! link cppExceptions cppModifier
       highlight! link cppModifier cppStorageClass
       highlight! link cStorageClass cppStorageClass
       highlight! link cppStorageClass javascriptClassSuperName
       highlight! link FunctionDecl javascriptFuncKeyword
       highlight! link CXXMethod javascriptMethod
       highlight! link Variable Normal
       highlight! link EnumConstant Member
       highlight! link Member javascriptProperty
       highlight! link Namespace ClassDecl
       highlight! link StructDecl ClassDecl
       highlight! link UnionDecl ClassDecl
       highlight! link EnumDecl ClassDecl
       highlight! link ClassDecl javascriptClassName
       highlight! link cStructure cppStructure
       highlight! link cppStructure javascriptOperator
       highlight! link NamespaceRef Type
       highlight! link TypeRef javascriptVariable
       highlight! link cParen javascriptBraces
       highlight! link cppType Type
    endfunction
catch
endtry

au BufEnter * call color_coded#moved()

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => scrooloose/nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
" Delete comment character when joining commented lines
autocmd FileType * set formatoptions+=j


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lervag/vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ilyachur/cmake4vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cmake_compile_commands=1
let g:asyncrun_open = 8

nnoremap <silent> <leader>cb :CMakeBuild<cr>
nnoremap <silent> <leader>cc :CMakeClean<cr>
nnoremap <silent> <leader>ct :FZFCMakeSelectTarget<cr>
function! RunProgram()
    if !exists('g:cmake_build_target')
        echom "Please select target first"
        return
    endif
    let s:exec_path = findfile(g:cmake_build_target, utils#cmake#getBuildDir())
    if strlen(s:exec_path)
        execute 'AsyncRun ' . s:exec_path
    else
        echom "Target in not runnable"
    endif
endfunction
nnoremap <silent> <leader>cr :call RunProgram()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ycm-core/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MyYCMCustom
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_key_list_stop_completion = ['<C-y>', '<Esc>']
    let g:ycm_always_populate_location_list = 1

    let g:ycm_semantic_triggers =  {
      \   'c,cpp': [ 're!\w{3}', '_', '.', '->', '::' ],
      \   'python': [ 're!\w{3}', '_'  ],
      \ }
    if !has('nvim')
      set completeopt+=popup
    else
      set completeopt+=preview
    endif

    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_python_binary_path = '/usr/bin/python3'
    let g:ycm_clangd_args = ['-cross-file-rename']
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf/ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0

    let g:ycm_key_list_select_completion = []
    let g:ycm_key_list_previous_completion = []
    let g:ycm_key_detailed_diagnostics = ''
    "let g:ycm_echo_current_diagnostic=0
    
    " Enable tabbing through list of results
    function! g:UltiSnips_Complete()
        call UltiSnips#ExpandSnippet()
        if g:ulti_expand_res == 0
            if pumvisible()
                return "\<C-n>"
            else
                call UltiSnips#JumpForwards()
                if g:ulti_jump_forwards_res == 0
                   return "\<tab>"
                endif
            endif
        endif
        return ""
    endfunction

    let g:UltiSnipsExpandTrigger = "<nop>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    let g:ulti_expand_or_jump_res = 0

    function ExpandSnippetOrReturn()
        let snippet = UltiSnips#ExpandSnippetOrJump()
        if g:ulti_expand_or_jump_res > 0
            return snippet
        else
            return "\<C-y>"
        endif
    endfunction

    inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrReturn()<CR>" : "\<CR>"

    let g:UltiSnipsSnippetsDir        = $HOME.'/.vim/UltiSnips/'
    let g:UltiSnipsSnippetDirectories = ["UltiSnips"]

    autocmd!
    autocmd FileType c,cpp let b:ycm_hover = {
      \ 'command': 'GetDoc',
      \ 'syntax': &filetype
      \ }
    autocmd FileType python let b:ycm_hover = {
      \ 'command': 'GetType',
      \ 'syntax': &filetype
      \ }
    let g:ycm_auto_hover=''
augroup END

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
autocmd FileType c,cpp nnoremap <silent> <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
autocmd FileType c,cpp nnoremap <silent> <C-]> :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>fr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>rr :YcmCompleter RefactorRename 
nnoremap <silent> <leader>ft :YcmCompleter FixIt<CR>
nmap <silent> <leader>dt <plug>(YCMHover)

set updatetime=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => xolox/vim-notes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'
autocmd FileType notes iabbrev <buffer> ЕЩВЩ TODO
autocmd FileType notes iabbrev <buffer> ВЩТУ DONE
autocmd FileType notes iabbrev <buffer> ЧЧЧ XXX

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => kkoomen/vim-doge
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:doge_enable_mappings=0
let g:doge_doc_standard_cpp='doxygen_qt'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => thaerkh/vim-workspace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:workspace_session_directory = $HOME . '/.vim/temp_dirs/sessions/'
let g:workspace_persist_undo_history = 0
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_autosave_ignore = ['gitcommit', 'qf', 'nerdtree', 'tagbar']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => derekwyatt/vim-protodef
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:protodefprotogetter='~/.vim/plugged/vim-protodef/pullproto.pl'
let g:disable_protodef_sorting=1
let g:disable_protodef_mapping=1

nmap <silent> <leader>gp :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})<cr><esc>='[:set nopaste<cr>
" Add functions to generate prototypes
"nmap <buffer> <silent> <leader>gn :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : 0})<cr><esc>='[:set nopaste<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => pchynoweth/a.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick switch between header and source file
nnoremap <silent> <F4> :A<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => chaoren/vim-wordmotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:wordmotion_disable_default_mappings=1
nmap W          <Plug>WordMotion_w
nmap E          <Plug>WordMotion_e
nmap B          <Plug>WordMotion_b
omap aW         <Plug>WordMotion_aw
omap iW         <Plug>WordMotion_iw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AndrewRadev/sideways.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><c-h> :SidewaysLeft<cr>
nnoremap <leader><c-l> :SidewaysRight<cr>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => alepez/vim-gtest
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup GTest
	autocmd FileType cpp nnoremap <silent> <leader>tt :GTestRun<CR>
	autocmd FileType cpp nnoremap <silent> <leader>tu :GTestRunUnderCursor<CR>
	autocmd FileType cpp nnoremap          <leader>tc :GTestCase<space>
	autocmd FileType cpp nnoremap <silent> <leader>td :GTestToggleEnabled<CR>
	autocmd FileType cpp nnoremap <silent> ]t         :GTestNext<CR>
	autocmd FileType cpp nnoremap <silent> [t         :GTestPrev<CR>
	autocmd FileType cpp nnoremap <silent> <leader>tf :FZFGTest<CR>
	autocmd FileType cpp nnoremap          <leader>ti :GTestNewTest<CR>i
    let g:gtest#print_time = 1
    let g:gtest#test_filename_suffix = "test"
    let g:gtest#gtest_command = "/home/rmilishc/build-GreenPAKDesigner-Desktop_Qt_5_12_3_GCC_64bit-Debug/deploy/bin/gtest_gpd6_unittests"
    let g:gtest#highlight_failing_tests = 1
augroup END

nnoremap ]r :%bd<CR>:cnext<CR>:Gvdiffsplit master<CR>
nnoremap [r :%bd<CR>:cprevious<CR>:Gvdiffsplit master<CR>
nnoremap ]R :%bd<CR>:clast<CR>:Gvdiffsplit master<CR>
nnoremap [R :%bd<CR>:cfirst<CR>:Gvdiffsplit master<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tmsvg/pear-tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ }
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_map_special_keys = 0
imap <BS> <Plug>(PearTreeBackspace)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tenfyzhong/vim-gencode-cpp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_gencode_function_attach_statement = [ '' ]
nnoremap <leader>ad :GenDefinition<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 'wsdjeg/FlyGrep.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('lua')
  let s:plugin_dir = fnamemodify(expand('<sfile>'), ':h').'\lua'
  let s:str = s:plugin_dir . '\?.lua;' . s:plugin_dir . '\?\init.lua;'
  silent! lua package.path=vim.eval("s:str") .. package.path
  if empty(v:errmsg)
      let g:_spacevim_if_lua = 1
  endif
endif

let g:FlyGrep_input_delay=300
nmap <silent> <C-f> :FlyGrep<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => moll/vim-bbye
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close the current buffer
map <leader>bd :Bdelete<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo :Bdelete<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => romainl/vim-qf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>q <Plug>(qf_qf_toggle)
"nnoremap <leader>e <Plug>(qf_loc_toggle)
nnoremap <silent> <leader>q :<C-u> call qf#toggle#ToggleQfWindow(0)<cr>
nnoremap <silent> <leader>e :<C-u> call qf#toggle#ToggleLocWindow(0)<cr>
nnoremap <silent> ]q :cn<cr>
nnoremap <silent> [q :cp<cr>
nnoremap <silent> ]e :lnext<cr>
nnoremap <silent> [e :lprev<cr>

autocmd FileType qf nnoremap <buffer> <silent> <C-H> <Plug>(qf_older)
autocmd FileType qf nnoremap <buffer> <silent> <C-L> <Plug>(qf_newer)

