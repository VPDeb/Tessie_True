# Tessie_True

## Description

This repository is meant to be a sandboxed environment from the main Story Squad data science back-end in order to explore various processes that take place with Tesseract-OCR. Tesseract is a very complex entity and we have attempted to break down what this repository is for, what it contains and how to understand this technology and what it's doing. Once an ideal model is reached, the final `<model>.traineddata` file, the `transcribe.py` and `processing.py` Python scripts can all be transferred to `story-squad-ds-a` to replace Google Vision endpoints.

## Documentation and Setup

[Tesseract Quick Start Guide](https://docs.google.com/document/d/141EKgawPfkhSCKC4GrP9VUK3_TD2qFRKl4t3aE7825c/edit?usp=sharing) (more general approach)

[Tesseract Onboarding Guide for Labs33](https://docs.google.com/document/d/1I8GayxQ6_HOPAeYB81GpApwhIVsXfBqhrH3VSdi3pPQ/edit?usp=sharing)

## File Breakdown

`fonts_n`  :: Folder containing font files (.ttf) used in synthetic data generation for training Tesseract.

`langdata_lstm` :: Folder containing all components of every langauge that has already been trained using Tesseract.

`eng.traineddata` :: This is the fully trained Tesseract model for the English language and needs to be placed into the `Tessie_True/tesseract/tessdata` directory.

`storysquadset.traineddata` & `storysquadnew` :: These are our trained model versions so far `storysquadnew` being the newest model that you will pick up from. These also need to be stored in the `Tessie_True/tesseract/tessdata` directory.

`train.sh` :: This shell script runs through the entire Tesseract training process using **image data** rather than synthetic data.

`transcribe.py` :: Python program containing a `transcribe` function that will eventually be used to replace the Google Vision transcribe function from `story-squad-ds-a/app/api/submission.py` at ~ line 55.

The following shell scripts are used to train Tesseract with sythetic data (fonts from above) and must be executed **in order** if training from sythentic data: `1gen_txt_data`, `2extract_lstm`, `3eval`, `4finetune`, `5combine`
