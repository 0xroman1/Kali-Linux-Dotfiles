#!/bin/bash

Fonts=(CodeNewRoman Hack Agave)
nerdfrepo=ryanoasis/nerd-fonts

dist="$HOME/.local/share/fonts"

[ -d "$dist" ] && mkdir -p $HOME/.local/share/fonts

release=$(curl --silent "https://api.github.com/repos/$nerdfrepo/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')


for i in "${Fonts[@]}"; do
		checkFont=$(fc-list | grep "$i")
		if [ -z "$checkFont" ]; then
				echo "download started" && wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/$release/$i.zip && echo "download finished" && echo "unziping started" && unzip -qq $i.zip -d ~/.local/share/fonts && echo "unzipping finished" && fc-cache -fv >/dev/null 2>&1 && echo "fc-chache: succeeded" && echo "Font "$i" Installed"
		else
				echo "Font "$i" already installed"
		fi
done

echo "done"
