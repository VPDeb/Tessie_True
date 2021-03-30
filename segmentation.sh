# Script creates segmentations of files ending  in .png_bw.png.  This file
# ending is created when the images are run through preprocess.py in Tessie_True
# -psm is the page segmentation.  Best results were found with --psm 4, --psm 6, --psm 1.
# Run separate times to create psm 4, psm 6, psm 1


lang=storysquadnew
#set -- **/*.png_bw
find . -type f -name "*.png_bw.png" -exec sh -c '
    for img_file do
        echo -e  "\r\n File: $img_file"
        mogrify -density 300 "$img_file"
        OMP_THREAD_LIMIT=1 tesseract --tessdata-dir /mnt/c/Users/dabor/dev/storysquad/Tessie_True/tesseract/tessdata   "${img_file}" "${img_file%.*}"  --dpi 300 --psm 6  --oem 1 -l storysquadset -c page_separator="" hocr
        PYTHONIOENCODING=UTF-8 hocr-extract-images -p "${img_file%.*}"-%03d.tif  "${img_file%.*}".hocr
    done' sh {} +

find . -type f -name '*.txt' -execdir rename 's/\.\/(.+)\.txt$/$1.gt.txt/' '{}' \;

echo "Image files converted to tif. Correct the ground truth files and then run training to create box and lstmf files"

