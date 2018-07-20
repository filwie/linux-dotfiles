def pango_format(text_between_tags: str, tag=None, tag_attributes=None) -> str:
    if tag is None or tag not in ['span'] or tag_attributes is None:
        tag_attributes = {}
    if tag is None:
        return text_between_tags
    return f'<{tag} {tag_attributes}>{text_between_tags}</{tag}>'
