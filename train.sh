# This script recursively searches through the sub-directory structure
# to find all tif files and generate their respective box file and
# place them in an output folder.

echo -e "\tCreating 'train' directory ...\n"
mkdir -p ./train

for i in $(find . -name '*.tif*') ;
do
	BASENAME=`echo $(basename "${i}")` ;

	echo -e "\n\tCreating box file for ${BASENAME} ...\n"
	tesseract "${i}" ./train/"${BASENAME%%.*}" lstmbox
	cp "${i}" ./train

	echo -e "\n\tCreating lstmf file for ${BASENAME%%.*} ...\n"
	tesseract -l eng ./train/"${BASENAME}" ./train/"${BASENAME%%.*}" --psm 6 lstm.train
done

# Generate lstmf_training_files.txt
echo -e "\n\tGenerating storysquad.training_files.txt ...\n"
ls ./train/*.lstmf | sort -R > storysquad.training_files.txt

# Extract lstm from most recently trained language model
read -p "\n\tEnter the name of the model you wish to continue training from. > " model_name
echo -e "\n\tExtracting lstm from ${model_name}.traineddata ...\n"
combine_tessdata -e ./tesseract/tessdata/${model_name}.traineddata ./${model_name}.lstm

# Run training
echo -e "\n\tCreating 'output' directory ...\n"
mkdir -p ./output

read -p "Enter the desired name for the new model. > " new_model_name
echo -e "\n\tBeginning model training ...\n"
lstmtraining --model_output ./output/{new_model_name} \
	--continue_from ./${model_name}.lstm \
	--traineddata ./tesseract/tessdata/${model_name}.traineddata \
	--train_listfile ./storysquad.training_files.txt \
	--max_iterations 100

# Combine outputs to create the new trained language model
echo -e "\n\tCombining data for ${new_model_name} ...\n"
lstmtraining --stop_training \
	--continue_from ./output/${new_model_name}_checkpoint \
	--traineddata ./tesseract/tessdata/${model_name}.traineddata \
	--model_output ./output/${new_model_name}.traineddata
