#!/usr/bin/env bash
# set -e

# Usage: ./make_gallery.sh
#
# Run in a directory with a "papes/" subdirectory, and it will create a
# "thumbnails/" subdirectory.
#
# Uses imagemagick's `convert`, so make sure that's installed.

rm -rf thumbnails
mkdir thumbnails

url_root="https://raw.githubusercontent.com/hi-sg/wallpapers/master"

echo "# Steve's Wallpaper Collection" >README.md
echo "" >>README.md
echo "I have collected these wallpapers over a number of years. This is my entire wallpaper directory for those that want/need them. Created with a slightly modified version of [make_gallery.sh](https://github.com/jonascarpay/Wallpapers/blob/master/make_gallery.sh) script by Jonas Carpay." >>README.md
echo "## Where did I get these?" >>README.md
echo "I find wallpapers in a number of different locations but good places to check out include [Imgur](https://imgur.com/) and [/wg/](https://boards.4chan.org/wg/). Some of the wallpapers are from other people's wallpaper repos like [Jonas Carpay](https://github.com/jonascarpay/Wallpapers), [MAKC](https://github.com/makccr/wallpapers), [Chris@Machine](https://github.com/ChristianChiarulli/wallpapers), [Gavin Freeborn](https://github.com/Gavinok/wallpapers), and [DT](https://gitlab.com/dwt1/wallpapers)." >>README.md
echo "## Ownership" >>README.md
echo "Since I got these mostly from sites like [Imgur](https://imgur.com/), [/wg/](https://boards.4chan.org/wg/), and [pixiv](https://www.pixiv.net/en/), I have no way of knowing if there is a copyright on these images. If you find an image hosted in this repository that is yours and of limited use, please let me know and I will remove it." >>README.md
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
