# Installing watermelon
git clone --depth 1 https://github.com/cchristion/watermelon.git
( cd watermelon && cp -rsvf $(pwd)/.config ~/ && cp -rsvf $(pwd)/.zshenv ~/.zshenv )
mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/zsh ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins

# Installing fast-syntax-highlight plugin for zsh
git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/fast-syntax-highlighting

# Installing powerlevel10k theme
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/powerlevel10k
