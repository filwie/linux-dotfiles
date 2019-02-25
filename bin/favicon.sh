#!/usr/bin/env zsh

PNG_SIZES=(16 32 96 160 192)
FAVICON_LOCATION="${FAVICON_LOCATION:-${2}}"

INPUT="${1}"
INPUT_LOCATION="${1:A:h}"

convert -background none "${INPUT}" -define icon:auto-resize="256,128" "${INPUT_LOCATION}/favicon.ico"
for size in "${PNG_SIZES[@]}"; do
        convert -background none -resize "${size}x${size}" "${INPUT}" "${INPUT_LOCATION}/favicon-${size}x${size}.png"
    done

cat << EOF
<link rel="shortcut icon" type="image/x-icon" href="${FAVICON_LOCATION}favicon.ico">
<link rel="icon" type="image/png" href="${FAVICON_LOCATION}/favicon-192x192.png" sizes="192x192">
<link rel="icon" type="image/png" href="${FAVICON_LOCATION}/favicon-160x160.png" sizes="160x160">
<link rel="icon" type="image/png" href="${FAVICON_LOCATION}/favicon-96x96.png" sizes="96x96">
<link rel="icon" type="image/png" href="${FAVICON_LOCATION}/favicon-16x16.png" sizes="16x16">
<link rel="icon" type="image/png" href="${FAVICON_LOCATION}/favicon-32x32.png" sizes="32x32">
EOF
