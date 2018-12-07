# #TODO:
- [x] reorganize project structure - increase readability
- [ ] refactor `setup.sh` and `link_dotfiles.sh` (and adjust to new directory tree)
- [ ] handle locales in test containers otherwise tmux plugins won't install causing tests to fail

## Quickstart
Execute command below:
```bash
bash -c "$(curl -fsSL https://gitlab.com/filip.wiechec/dotfiles/raw/master/setup.sh)"
```
## Repository contents
Config files for:

1. Vim
2. Zsh
3. Tmux
4. Compton
5. Xresources
6. Alacritty
7. Dunst
8. i3
9. i3blocks
10. Termite

Themes for:

1. Zsh
2. Rofi
3. i3

Simple Python scripts to print scheme colors for:

1. [srcery](https://github.com/srcery-colors)
2. [gruvbox](https://github.com/morhetz/gruvbox)

<i>Requirements: `Python3.6+`, `colr` package, terminal emulator with support for truecolor</i>

## List of my preferred software
#### Desktop environment
###### window manager
[i3](https://i3wm.org/)
 - tiling window manager

[i3 gaps](https://github.com/Airblader/i3)
 - fork of the above that adds gaps

###### launcher
[Rofi](https://github.com/DaveDavenport/rofi)
 - customizable launcher, window switcher

###### notifications
[dunst](https://github.com/dunst-project/dunst)
 - lightweight notification daemon


#### Terminal magick
[fzf](https://github.com/junegunn/fzf)
 - command line fuzzy finder, reverse history browser

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
 - ZSH configuration management framework

[ranger](https://github.com/ranger/ranger)
 - VIM-inspired console file manager

#### Fonts
[Mononoki](https://github.com/madmalik/mononoki)
 - brilliant monospaced font

[Iosevka](https://github.com/be5invis/Iosevka)
 - another brilliant monospaced font, which is, in addition, quite condensed

[Nerd Fonts](http://nerdfonts.com/)
 - collection of many fonts (including `Iosevka` and `Mononoki`) with additional
characters, or glyphs - programming language logos, useful icons etc.

#### Picture collections, photo editing etc.
[Gravit Designer](https://www.designer.io/)
 - vector design
[ShotWell]()
 - Gnome image organizer somewhat similar to Apple Photos
[Pinta](https://pinta-project.com/pintaproject/pinta/)
 - somewhat simillar to Paint


## Inspired by
[srcery-colors](https://github.com/srcery-colors)<br>
[gruvbox](https://github.com/morhetz/gruvbox)
[some random internet users' dotfiles](https://duckduckgo.com/?q=dotfiles)
