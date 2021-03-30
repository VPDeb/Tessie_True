import os
import glob
import cv2

from skimage.data import page
from skimage.filters import threshold_sauvola)
from skimage.io import imsave


"""
For sandboxing purposes: Preprocesses an entire folder of images. 
to be used for further training of the model.

Change `Transcribed Stories` to a directory that is pertinent 
for preprocessing a folder containing handwriting images.

`os.chdir()` 
Changes the current working directory to a particular path
The `Transcribed Stories` path refers to the file that contains all the images 
that one wants to apply the preprocessing filter to.  As new submissions/training 
files are gathered, those are the files to apply this preprocessing function to
"""
os.chdir("./Transcribed Stories")

# retrieving paths recursively from inside Transcribed Stories
for file in glob.glob("**/*.png", recursive=True):
    # reading in the image using cv2
    img = cv2.imread(file, 0)


    """
    `Threshold Sauvola` imaging function:

    T = m(x,y) * (1 + k * ((s(x,y) / R) - 1))
    where m(x,y) and s(x,y) are the mean and standard deviation of 
    pixel (x,y) local neighborhood defined by a rectangular window with 
    size 25 times 25 centered around the pixel. k is a configurable 
    parameter that weights the effect of standard deviation. R is 
    the maximum standard deviation of a grayscale image.

    """
    # dynamic range of standard deviation around a window of pixels (a window of 25 pixels)
    window_size = 25
    thresh_sauvola = threshold_sauvola(img, window_size=window_size)
    binary_sauvola = img > thresh_sauvola
    
    print(f"Writing {file}_bw")
    imsave(f"{file}__SauvolaThresh.png", binary_sauvola)