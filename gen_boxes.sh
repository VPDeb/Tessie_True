# Place this script in the directory containing all of your tif files
# Loop through each tif file and generate its respective box file
for img in *.tif ;
do
	BASENAME=`echo "${img%%.*}"` ;
	tesseract "${img}" "${BASENAME}" lstmbox
done
