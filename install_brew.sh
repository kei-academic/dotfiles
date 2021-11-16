#!/bin/zsh

echo "installing homebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade..."
brew upgrade


formulas=(
    autoconf     # configure生成
    awscli       # awsの管理
    asciinema    # ターミナルセッションの記録とWeb上での共有
    # bat          # catの代替コマンド，zinitにてインストール済，干渉しないようコメントアウト
    ctop         # コンテナ用のモニタリングツール
    # dat          # ?
    exa          # ls，treeの代替コマンド
    ffmpeg       # フリーの動画変換・編集ツール
    fd           # findの代替コマンド
    # fish         # シェル，zshで十分なのでコメントアウト
    gh           # GitHubの操作を行えるCLIツール
    git          # 分散型バージョン管理システム
    # gitui      # GitKrakenとghで十分なのでコメントアウト
    imagemagick  # 画像変換・編集ツール
    jrnl         # ターミナルから利用できる記録ツール
    mas          # Mac App Storeをコマンドラインから操れるツール
    mysql        # オープンソースのリレーショナルデータベース管理システム(RDBMS)
    navi         # コマンドで見れるチートシート
    # nb           # ?
    neovim       # テキストエディタ
    neofetch     # システム情報を表示するツール
    nodebrew     # Node.jsのバージョン管理ツール，anyenv→nodenv→node.jsが良さげ
    nnn          # ファイルマネージャ
    pandoc       # ドキュメント・コンバータ
    procs        # プロセス表示・検索ツール
    poppler      # pdfをppm形式にするツール，ImageMagickのconvertコマンドと併用
    pstree       # プロセスのツリーを表示するツール
    sampler      #
    sd           #
    sqlite       # 単独のアプリケーションとして動作が可能なリレーショナルデータベース管理システム(RDBMS)
    # starship     # zinit経由でpowerlevel10k導入しているのでコメントアウト
    taskell      #
    thefuck      #
    tldr         #
    tmux         #
    tmuxinator   #
    tree         # ディレクトリ配下のファイル構造をツリー上に表示するコマンド
    warp         #
    xsel         # クリップボードにアクセスするツール
    yarn         #
)

echo "brew tap"
# brew tap thirdparty
brew tap homebrew/cask-fonts

echo "brew install formula"
for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

# install gui up
casks=(
    atom
    alfred
    alacritty
    appcleaner
    biscuit
    bitwarden
    boostnote
    cacher
    cheatsheet
    dash
    deepl
    discord
    docker
    drawio
    dropbox
    font-hack-nerd-font
    gitkraken
    grammarly
    google-backup-and-sync
    gyazo
    hyperswitch
    inkscape
    iterm2
    julia
    jetbrains-toolbox
    kap
    karabiner-elements
    keycastr
    mamp
    notion
    obs
    papers
    r
    rectangle
    skitch
    skype
    slack
    spotify
    steam
    tickeys
    visual-studio
    visual-studio-code
    vrew
    vlc
    xmind
    zoom
)

echo "brew casks"
for cask in "${casks[@]}"; do
    brew install --cask $cask
done


stores=(
    497799835
    539883307
    937984704
    975890633
    1144071713
    1295203466
    1423210932
    1429033973
    1450950860
    1483764819
)


echo "app stores"
for store in "${stores[@]}"; do
    mas install $store
done


brew cleanup

echo "brew installed"

