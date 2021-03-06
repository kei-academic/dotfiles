##################################################
### zinitによる遅延防止
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

##################################################
### zsh-completions(補完機能)の設定
## autoload関連
autoload -Uz colors; colors                       # 色のロード
if [ -e /usr/local/share/zsh-completions ]; then  # 補完機能の有効化
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit && compinit -u
autoload -Uz select-word-style                    # 単語の区切り文字を指定する
select-word-style default

## enable completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'            # 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' format '%B%F{blue}%d%f%b'               # 補完方法毎にグループ化する。
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2                   # select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}          # ファイル補完候補に色を付ける
zstyle ':completion:*' ignore-parents parent pwd ..            # ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'  # psコマンドのプロセス名補完
zstyle ':zle:*' word-chars " /=;@:{},|"                        # / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-style unspecified

setopt auto_param_slash   # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_keys    # カッコを自動補完
setopt mark_dirs          # ファイル名の展開でディレクトリにマッチした場合、末尾に / を付加
setopt auto_menu          # 補完キー連打で順に補完候補を自動で補完
setopt correct            # コマンドのスペルミスを指摘
setopt magic_equal_subst  # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word   # 語の途中でもカーソル位置で補完


# prompt(zinit不使用時)
# PROMPT="%{${fg[blue]}%}[%n@%m]%{${reset_color}%} %c/ %# "


##################################################
### PATHの設定
export PATH=/usr/local/bin:$PATH  # 追加したソフトやパッケージ用のコマンドのパスを通す
export LANG=ja_JP.UTF-8           # 文字コードの指定

export PATH="/opt/homebrew/bin:$PATH"                          # Homebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH                  # Nodebrew
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"            # MySQL
export PYENV_ROOT="$HOME/.pyenv"                               # pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"         # Android SDK
export PATH=/usr/local/opt/php@7.4/bin:$PATH                   # php
export PATH=/usr/local/opt/php@7.4/sbin:$PATH
export RBENV_ROOT=$(brew --prefix rbenv)                       # rbenv
export PATH=$RBENV_ROOT/bin:$PATH
eval "$(rbenv init -)"
export OPENSSL_ROOT=$(brew --prefix openssl)                   # openssl
export PATH="$OPENSSL_ROOT/bin:$PATH"
export LDFLAGS="-L$OPENSSL_ROOT/lib"
export CPPFLAGS="-I$OPENSSL_ROOT/include"
export PKG_CONFIG_PATH="$OPENSSL_ROOT/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_ROOT"
export PATH="$PATH:/Users/shimadakeigo/Developer/flutter/bin"  # flutter
eval "$(gh completion -s zsh)"                                 # gh
export EDITOR='nvim'                                           # nnn
export VISUAL='nvim'
export PAGER='less'
export NNN_FALLBACK_OPENER=xdg-open
export NNN_DE_FILE_MANAGER=caja
export NNN_COPIER="$HOME/.config/nnn/copier.sh"
eval $(thefuck --alias)                                        # thefuck


##################################################
### aliases
# git系
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gcl='git clone'
alias gco='git checkout'
alias gct='git commit'
alias gg='git grep'
alias ga='git add'
alias gaa='git add .'
alias grm='git rm --cached -r'
alias gre='git reset HEAD'
alias gd='git diff'
alias gl='git log'
alias gcma='git checkout master'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gmod='git merge origin/develop'
alias gmud='git merge upstream/develop'
alias gmom='git merge origin/master'
alias gcm='git commit -m'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gst='git stash'
alias gsl='git stash list'
alias gsu='git stash -u'
alias gsp='git stash pop'

# vim系
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias view='nvim -R'

# ls系
alias ls='exa -FG --git --time-style=long-iso'
alias la='exa -a --git --time-style=long-iso'
alias ll='exa -abghHliSG --git --time-style=long-iso'

# brew系
alias brew='arch -arm64 brew'
alias brewc='arch -arm64 brew cleanup'
alias brewd='arch -arm64 brew doctor'
alias brewh='arch -arm64 brew help'
alias brewi='arch -arm64 brew install'
alias brewl='arch -arm64 brew list'
alias brews='arch -arm64 brew search'
alias brewu='arch -arm64 brew update && arch -arm64 brew upgrade'
alias brewun='arch -arm64 brew uninstall --ignore-dependencies'
alias brewv='arch -arm64 brew --version'

# mas系
alias masa='mas accunt'
alias mash='mas help'
alias masi='mas install'
alias masl='mas list'
alias maso='mas outdated'
alias mass='mas search'
alias masu='mas upgrade'

# pip系
alias pipc='pip check'
alias piph='pip help'
alias pipi='pip install'
alias pipl='pip list'
alias piplo='pip list -outdate'
alias pipf='pip freeze'
alias pipr='pip-review'
alias pips='pip search'
alias pipu='pip-review --auto'
alias pipup='pip install --upgrade pip'
alias pipv='pip -V'

# A to Z (被りはコメントアウト)
alias c='clear'
# alias d='docker'
# alias g='git'
alias h='history'
alias j='jupyter'
alias p='python3'
# alias v='nvim'

# zshrc関連
alias zsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'

# Docker関連(not found 'docker')(コマンド追加後にコメント解除)
# alias d=‘docker’
# alias dc=‘docker-compose’
# alias dcnt=‘docker container’
# alias dcur=‘docker container ls -f status=running -l -q’
# alias dexec=‘docker container exec -it $(dcur)’
# alias dimg=‘docker image’
# alias drun=‘docker container run —rm -d’
# alias drunit=‘docker container run —rm -it’
# alias dstop=‘docker container stop $(dcur)’

# その他
alias prog='source ~/.venv/prog1/bin/activate'
alias venv='source ../venv/bin/activate'
alias diff='colordiff'
alias pandocpdf='pandoc -V documentclass=ltjarticle --latex-engine=lualatex -t pdf'
function removegomi () {
    find . \( -name '.DS_Store' -or -name '._*' \) -delete -print;
}
alias rmgomi=removegomi
alias cat='bat'
alias pb='pbcopy'
alias ram='sudo purge'
alias tree='exa --tree'
alias find='fd -e'
alias mans='tldr'


##################################################
### オプション
## history関連
export HISTFILE=~/.zsh_history        # ヒストリ(履歴)を保存、数を増やす
export HISTSIZE=10000
export SAVEHIST=100000

setopt inc_append_history      # 実行時に履歴をファイルに追加していく
setopt share_history           # 同時に起動しているzshの間でhistoryを共有する
setopt extended_history        # コマンドのタイムスタンプをHISTFILEに記録する
setopt hist_save_no_dups       # 重複するコマンドが保存されるとき、古い方を削除する
setopt hist_reduce_blanks      # ヒストリに保存するときに余分なスペースを削除する

## キーバインド
bindkey -d                                                # キーバインディングをemacs風にする
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward  # ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする

setopt auto_cd            # cd無しでもディレクトリ移動
setopt auto_pushd         # cd したら自動的にpushdする
setopt pushd_ignore_dups  # 重複したディレクトリを追加しない
setopt auto_pushd         # cd -<tab>で以前移動したディレクトリを表示
setopt extended_glob      # 高機能なワイルドカード展開を使用する
setopt print_eight_bit    # 日本語ファイル名を表示可能にする
setopt no_flow_control    # フローコントロールを無効にする(disable Ctrl)
setopt ignore_eof         # Ctrl+Dでzshを終了しない

## その他
setopt no_beep               # ビープ音の停止
setopt nolistbeep            # ビープ音の停止(補完時)
setopt interactive_comments  # '#' 以降をコメントとして扱う


##################################################
### vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


##################################################
### anaconda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/shimadakeigo/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/shimadakeigo/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/shimadakeigo/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/shimadakeigo/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


##################################################
### npm
###-begin-npm-completion-###

if type complete &>/dev/null; then
    _npm_completion () {
        local words cword
        if type _get_comp_words_by_ref &>/dev/null; then
            _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
        else
            cword="$COMP_CWORD"
            words=("${COMP_WORDS[@]}")
        fi

        local si="$IFS"
        if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                COMP_LINE="$COMP_LINE" \
                COMP_POINT="$COMP_POINT" \
                npm completion -- "${words[@]}" \
                2>/dev/null)); then
            local ret=$?
            IFS="$si"
            return $ret
        fi
        IFS="$si"
        if type __ltrim_colon_completions &>/dev/null; then
            __ltrim_colon_completions "${words[cword]}"
        fi
    }
    complete -o default -F _npm_completion npm

elif type compdef &>/dev/null; then
    _npm_completion() {
        local si=$IFS
        compadd -- $(COMP_CWORD=$((CURRENT-1)) \
            COMP_LINE=$BUFFER \
            COMP_POINT=0 \
            npm completion -- "${words[@]}" \
            2>/dev/null)
        IFS=$si
    }
    compdef _npm_completion npm

elif type compctl &>/dev/null; then
    _npm_completion () {
        local cword line point words si
        read -Ac words
        read -cn cword
        let cword-=1
        read -l line
        read -ln point
        si="$IFS"
        if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
            COMP_LINE="$line" \
            COMP_POINT="$point" \
            npm completion -- "${words[@]}" \
            2>/dev/null)); then
            local ret=$?
            IFS="$si"
            return $ret
        fi
        IFS="$si"
    }

# npmをzshで保管する設定
    compctl -K _npm_completion npm
fi
###-end-npm-completion-###


##################################################
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# zinit経由でpowerlevel10k導入
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions

# fast-syntax-highlighting
zinit light zdharma/fast-syntax-highlighting

# anyframe
zinit light mollifier/anyframe

# history-search-multi-word
zinit light zdharma/history-search-multi-word

# sharkdp/bat
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# k
zinit light supercrabtree/k




