from typing import Generator

import tkinter as tk

from colour import Color


def pango_format(text_between_tags: str, tag=None, tag_attributes=None) -> str:
    if tag is None or tag not in ['span'] or tag_attributes is None:
        tag_attributes = {}
    if tag is None:
        return text_between_tags
    return f'<{tag} {tag_attributes}>{text_between_tags}</{tag}>'


def display_colors(colors: list) -> None:
    root = tk.Tk()
    widgets = []
    height = 40
    for color in colors:
        widgets.append(tk.Frame(root, bg=color))
        if height < 400:
            height += 40

    root.geometry(f'80x{height}')

    [widget.pack(fill='both', expand=True) for widget in widgets]
    root.mainloop()


def gradient(begin: str, end: str, steps=3) -> Generator:
    return Color(begin).range_to(Color(end), steps)


def percentage_colours() -> Generator:
    colors = []
    palette = '#98971A #98971A #98971A #FABD2F' \
              ' #FABD2F #FE8019 #FE8019 #D65D0E #D65D0E #CC241D'.split(' ')

    for i in range(0, len(palette), 2):
        colors.extend(gradient(palette[i], palette[i + 1], 200))
    return colors


if __name__ == '__main__':
    display_colors(percentage_colours())
