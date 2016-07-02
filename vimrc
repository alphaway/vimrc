"vim 内置的设置命令
set nocompatible			"设置不兼容vi，即不模仿vi的行为， 最为基础的设置
set backspace=indent,eol,start		"只有这样设置，才能使用退格键删除字符
set mouse=a					"能够使用鼠标
set tabstop=4				"设置tab键为4个空格
set softtabstop=4
set shiftwidth=4
set autoindent				"设置自动对齐,即每行的缩进和与上一行相等
set number					"在右下角显示光标的行列信息
syntax on					"语法高亮
set ruler					"显示光标
set encoding=utf-8
set laststatus=2		"只有设置了这个才会显示状态来
"设置打开vim时，将光标显示在上次的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"设置vim创建文件的权限为744
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> 

"在插入模式下，将jj键映射为<esc>键
imap jj <esc><right>		 
imap JJ <esc><right>

"当新建以下后缀结尾的文件时，会拷贝模板文件中的代码带新建文件中
autocmd BufNewFile *.html 0r ~/.vim/template/html.template
autocmd BufNewFile *.cpp 0r ~/.vim/template/cpp.template
autocmd BufNewFile *.sh 0r ~/.vim/template/sh.template
autocmd BufNewFile *.css 0r ~/.vim/template/css.template


"--------------------------------------CPP----------------------------------
func! CompileCpp()
exec "w"
" %<表示不包含后缀的文件名
exec "!g++ -O2 -g  % -o %<"
exec "! ./%<"
endfunc

" 编译C++文件
if expand('%:t:e') == "cpp"
	map <F6> :call CompileCpp()<CR><Space>
endif
"---------------------------------------------------------------------------

"--------------------------------------HTML---------------------------------
func! RunHtml()
"这个命令是在vim中执行
exec "w"		
"!开头的命令是在shell中执行, %代表当前文件名， 
"%:t:r代表当前不包含后缀的文件名
exec "!open -a /Applications/'Google Chrome.app' %"
endfunc

map <F5> : call RunHtml()<CR><space>
"----------------------------------------------------------------------------

"---------------------------------------LESS---------------------------------
" 按\m时编译less文件
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

" 保存时 自动编译less文件
function! CompileLess()
	execute "w"
	exec "!lessc % > %:t:r.css"
endfunction

if executable("lessc")
	autocmd BufWriteCmd *.less call CompileLess()
endif
"----------------------------------------------------------------------------








"---------------------以下是各种插件的配置------------------------






filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


Plugin 'pangloss/vim-javascript'			"js语法高亮插件
Plugin 'scrooloose/nerdtree'				"目录树插件
Plugin 'Shougo/neocomplcache.vim'			"自动补全插件
Plugin 'lilydjwg/colorizer'					"css颜色显示插件
Plugin 'vim-airline/vim-airline'			"状态栏插件
Plugin 'tpope/vim-commentary'				"注释插件
Plugin 'mattn/emmet-vim'					"快速编写html的插件
Plugin 'maksimr/vim-jsbeautify'				"html,css,js代码美化插件
Plugin 'Rykka/colorv.vim'					"取色器插件	:ColorV 或者<leader>cv
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required







"---------------------------------------nerdtree目录树插件----start-------------------------
"autocmd vimenter * NERDTree    "打开vim时自动打开nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif			"当只有目录树窗口时，自动关闭。

"映射<F3>键Wie打开和关闭nredtree
nmap <F3> :NERDTree<CR>
nmap <F3> :NERDTreeToggle<CR>
"---------------------------------------nerdtree目录树插件----end----------------------------


"---------------------------------------airline状态栏插件----start--------------------------
let g:airline_powerline_fonts = 1				"设置pwerline字体，这样状态栏才会正常显示箭号
"---------------------------------------airline状态栏插件----end--------------------------




"----------------------------------------commentar插件设置----start-------------------------
nmap ÷ gcc
vmap ÷ gc
"----------------------------------------commentar插件设置----end----------------------------



"----------------------------------------emmet插件设置----start--------------------------------
"将 alt+j  映射为  ctrl + y + ,   因为后者是该插件默认的命令 
imap ∆ <c-y>,    
"让该插件只对vim和css其作用
autocmd FileType html,css EmmetInstall
"-----------------------------------------emmet插件设置----end--------------------------------



"---------------------------------------vim-jsbeautify插件设置----start---------------------------
if expand('%:t:e') == "js"
	map <c-f> :call JsBeautify()<CR>
endif
if expand('%:t:e') == "css"
	map <c-f> :call CSSBeautify()<CR>	
endif
if expand('%:t:e') == 'less'
	map <c-f> : call CSSBeautify()<CR>
endif
if expand('%:t:e') == "html"
	map <c-f> : call HtmlBeautify()<CR>
endif
"---------------------------------------vim-jsbeautify插件设置----end------------------------------






"neocomplcache 自动补全插件

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_auto_select = 1				"作用：提示的时候默认选择地一个，
" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'








