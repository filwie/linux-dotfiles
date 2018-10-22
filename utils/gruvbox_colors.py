#!/usr/bin/env python3
from colr import color, hex2rgb

gruvbox_colors = dict(dark0_hard='#1d2021',
                      dark0='#282828',
                      dark0_soft='#32302f',
                      dark1='#3c3836',
                      dark2='#504945',
                      dark3='#665c54',
                      dark4='#7c6f64',
                      dark4_256='#7c6f64',
                      gray_245='#928374',
                      gray_244='#928374',
                      light0_hard='#f9f5d7',
                      light0='#fbf1c7',
                      light0_soft='#f2e5bc',
                      light1='#ebdbb2',
                      light2='#d5c4a1',
                      light3='#bdae93',
                      light4='#a89984',
                      light4_256='#a89984',
                      bright_red='#fb4934',
                      bright_green='#b8bb26',
                      bright_yellow='#fabd2f',
                      bright_blue='#83a598',
                      bright_purple='#d3869b',
                      bright_aqua='#8ec07c',
                      bright_orange='#fe8019',
                      neutral_red='#cc241d',
                      neutral_green='#98971a',
                      neutral_yellow='#d79921',
                      neutral_blue='#458588',
                      neutral_purple='#b16286',
                      neutral_aqua='#689d6a',
                      neutral_orange='#d65d0e',
                      faded_red='#9d0006',
                      faded_green='#79740e',
                      faded_yellow='#b57614',
                      faded_blue='#076678',
                      faded_purple='#8f3f71',
                      faded_aqua='#427b58',
                      faded_orange='#af3a03')

for name, code in gruvbox_colors.items():
    rgb_code_raw = hex2rgb(code)
    rgb_code = '"{}"'.format(
                ';'.join([str(v) for v in rgb_code_raw])
                            )
    print(f'{color(rgb_code, back=rgb_code_raw)}\t{color(code, back=hex2rgb(code))}\t{name}')
