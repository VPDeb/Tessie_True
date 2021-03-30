# Script searches for files ending in .jpg and converts
# these files in .png with a DPI of 300
# Use this script before using preprocessing.py
find . -type f -name "*.jpg" -exec sh -c '
    for f do
        echo "Converting $f"
        convert -density 300 "$f" -auto-orient "${f%.*}.png"
        rm -rf "$f"
    done' sh {} +
