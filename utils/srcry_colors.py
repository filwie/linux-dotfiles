#!/usr/bin/env python3
from colr import color, hex2rgb

gruvbox_colors = dict(
    black='#1C1B19',
    brightblack='#2D2C29',
    red='#EF2F27',
    brightred='#F75341',
    green='#519F50',
    brightgreen='#98BC37',
    yellow='#FBB829',
    brightyellow='#FED06E',
    blue='#2C78BF',
    brightblue='#68A8E4',
    magenta='#E02C6D',
    brightmagenta='#FF5C8F',
    cyan='#0AAEB3',
    brightcyan='#53FDE9',
    white='#918175',
    brightwhite='#FCE8C3',
    orange='#D75F00',
    brightorange='#FF8700',
    xgrey1='#262626',
    xgrey2='#303030',
    xgrey3='#3A3A3A',
    xgrey4='#444444',
    xgrey5='#4E4E4E',
)
for name, code in gruvbox_colors.items():
    rgb_code = '"{}"'.format(
            ';'.join([str(v) for v in hex2rgb(code)])
            )
    print(f'{color(rgb_code, back=hex2rgb(code))}\t{color(code, back=hex2rgb(code))}\t{name}')
