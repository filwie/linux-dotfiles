#!/usr/bin/env python3
from colr import color, hex2rgb
from IPython import embed
from collections import namedtuple

Color = namedtuple('Color', 'name hex rgb number')


class Colorscheme:
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)

    @property
    def _colors(self):
        return (Color(name, hex_code, hex2rgb(hex_code), number)
                for name, hex_code, number in zip(self.colors.keys(),
                                              self.colors.values(),
                                              range(16)))

    def display_scheme(self):
        for c in self._colors:
            #print(f'{c.hex}\t{c.rgb}\t{c.number}\t{c.name}')
            print(f'{c.name} = ${{xrdb:color{c.number}:{c.hex}}}')


if __name__ == '__main__':

    srcery = {
        'background': '#1C1B19',
        'foreground': '#FCE8C3',
        'colors': {
            'black': '#1C1B19',
            'red': '#EF2F27',
            'green': '#519F50',
            'yellow': '#FBB829',
            'blue': '#2C78BF',
            'magenta': '#E02C6D',
            'cyan': '#0AAEB3',
            'white': '#918175',
            'brightblack': '#2D2B28',
            'brightred': '#F75341',
            'brightgreen': '#98BC37',
            'brightyellow': '#FED06E',
            'brightblue': '#529CE0',
            'brightmagenta': '#FF5C8F',
            'brightcyan': '#53FDE9',
            'brightwhite': '#FCE8C3',
        }
    }

    gruvbox_light = {
        'background': '#f2e5bc',
        'foreground': '#3c3836',
        'colors': {
            'black': '#fbf1c7',
            'red': '#cc241d',
            'green': '#98971a',
            'yellow': '#d79921',
            'blue': '#458588',
            'magenta': '#b16286',
            'cyan': '#689d6a',
            'white': '#7c6f64',
            'brightblack': '#928374',
            'brightred': '#9d0006',
            'brightgreen': '#79740e',
            'brightyellow': '#b57614',
            'brightblue': '#076678',
            'brightmagenta': '#8f3f71',
            'brightcyan': '#427b58',
            'brightwhite': '#3c3836',
        }
    }
    srcery = Colorscheme(**srcery)
    gruvbox = Colorscheme(**gruvbox_light)
    srcery.display_scheme()
