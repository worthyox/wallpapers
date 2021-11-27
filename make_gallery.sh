#!/usr/bin/env bash
# set -e

# Usage: ./make_gallery.sh
#
# Run in a directory with a "papes/" subdirectory, and it will create a
# "thumbnails/" subdirectory.
#
# Uses imagemagick's `convert`, so make sure that's installed.
# On Nix, nix-shell -p imagemagick --run ./make_gallery.sh

rm -rf thumbnails
mkdir thumbnails

url_root="https://raw.githubusercontent.com/worthyox/wallpapers/master"

echo "# Worthyox's Wallpaper Collection" >README.md
echo "" >>README.md
echo "I have collected these wallpapers over a number of years. This is my entire wallpaper directory for those that want/need them." >>README.md
echo "## Where did I get these?" >>README.md
echo "I find wallpapers in a number of different locations but good places to check out include Imgur and /wg/. Some of the wallpapers were probably included in default wallpaper packages from various Linux distributions that I have installed over the years." >>README.md
echo "## Ownership" >>README.md
echo "Because I downloaded most of these from sites like Imgur and /wg/, I have no way of knowing if there is a copyright on these images. If you find an image hosted in this repository that is yours and of limited use, please let me know and I will remove it." >>README.md
echo "" >>README.md
echo "## My current wallpaper rotation" >>README.md
echo "" >>README.md


total=$(ls papes | wc -l)

i=0

git ls-files papes/ -z | while read -d $'\0' src; do
    ((i++))
    filename="$(basename "$src")"
    printf '%4d/%d: %s\n' "$i" "$total" "$filename"

    convert -resize 200x "$src" "${src/papes/thumbnails}"

    filename_escaped="${filename// /%20}"
    thumb_url="$url_root/thumbnails/$filename_escaped"
    pape_url="$url_root/papes/$filename_escaped"

    echo "[![$filename]($thumb_url)]($pape_url)" >>README.md
done
