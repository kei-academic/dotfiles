set shell=/bin/zsh       " zshコマンドを使用
set shiftwidth=4         " indentの幅
set softtabstop=4        " Tabキーで挿入するスペースの数
set expandtab            " タブの入力の際にスペース
set textwidth=0          " ワードラッピングなし
set autoindent           " 自動インデント(:set pasteで解除可能)
set hlsearch             " Searchのハイライト
set clipboard=unnamed    " Vimの無名レジスタとシステムのクリップボードを連携
set number               " 行番号を表示
set smartindent          " プログラミング言語に合わせて適切にインデントを自動挿入
set autochdir            " カレントディレクトリを自動で移動
set encoding=utf-8       " バッファ内で扱う文字コード
set fileencoding=utf-8   " 書き込む文字コード
set fileencodings=utf-8  " 読み込む文字コード(UTF-8, Shift_JIS)
set wildmode=longest     " eコマンドでTabキーを押すとパスを補完する

let mapleader = "|<space>"  " LeaderキーをSpaceに設定

nnoremap <C-j> ^\(<CR>%a{<CR><Esc>o}<Esc>                " C++, Javaなどのインラインブロックを中括弧付きのブロックに展開
nnoremap <expr> S* ':%s/\<' . expand('<cword>') . '\>/'  " カーソル上の単語を置換

inoremap <silent> <Esc> <Esc>:call system('fcitx-remote -c')<CR>  " 挿入モード終了時にIMEをオフ

" 起動時にターミナルウィンドウを設置
function! Myterm()
    split
    wincmd j
    resize 10
    terminal
    wincmd k
endfunction
command! Myterm call Myterm()

"起動時にターミナルウィンドウを設置
if has('vim_starting')
    Myterm
endif

" 上のエディタウィンドウと下のターミナルウィンドウ(ターミナル挿入モード)を行き来
tnoremap <C-t> <C-\><C-n><C-w>k
nnoremap <C-t> <C-w>ji

" ターミナル挿入モードからターミナルモードへ移行
tnoremap <Esc> <C-\><C-n>

"ファイルタイプごとにコンパイル/実行コマンドを定義
function! Setup()
    "フルパスから拡張子を除いたもの
    let l:no_ext_path = printf("%s/%s", expand("%:h"), expand("%:r"))
    "各言語の実行コマンド
    let g:compile_command_dict = {
                \'c': printf('gcc -std=gnu11 -O2 -lm -o %s.out %s && %s/%s.out', expand("%:r"), expand("%:p"), expand("%:h"), expand("%:r")),
                \'cpp': printf('g++ -std=gnu++17 -O2 -o %s.out %s && %s/%s.out', expand("%:r"), expand("%:p"), expand("%:h"), expand("%:r")),
                \'java': printf('javac %s && java %s', expand("%:p"), expand("%:r")),
                \'cs': printf('mcs -r:System.Numerics -langversion:latest %s && mono %s/%s.exe', expand("%:p"), expand("%:h"), expand("%:r")),
                \'python': printf('python3 %s', expand("%:p")),
                \'ruby': printf('ruby %s', expand("%:p")),
                \'javascript': printf('node %s', expand("%:p")),
                \'sh': printf('chmod u+x %s && %s', expand("%:p"), expand("%:p"))
                \}
    "実行コマンド辞書に入ってたら実行キーバインドを設定
    if match(keys(g:compile_command_dict), &filetype) >= 0
        "下ウィンドウがターミナルであることを前提としている
        nnoremap <expr> <F5> '<C-w>ji<C-u>' . g:compile_command_dict[&filetype] . '<CR>'
    endif
endfunction
command! Setup call Setup()
"ファイルを開き直したときに実行コマンドを再設定
autocmd BufNewFile,BufRead * Setup

"RubyとJSではインデントを2マスにする
autocmd FileType ruby,javascript set shiftwidth=2 softtabstop=2

syntax on  " SyntaxをEnable



call plug#begin()
  Plug 'ntk148v/vim-horizon'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'sheerun/vim-polyglot'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" vim-horzon
" if you don't set this option, this color might not correct
set termguicolors

colorscheme horizon

" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'horizon'

" or this line
let g:lightline = {'colorscheme' : 'horizon'}


" NEARDTree
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree


