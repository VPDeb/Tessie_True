import pytesseract
import cv2

from skimage.data import page
from skimage.filters import threshold_sauvola
from skimage.io import imsave

def prepocessing(image):
    img = cv2.imread(image, 0)

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
    thresh_sauvola = threshold_sauvola(image, window_size=window_size)
    binary_sauvola = image > thresh_sauvola
    
    return binary_sauvola

def transcribe(image, lang="eng"):
    """
    Transcribes image file to a string using pytesseract.
    Args:
        image: file
            Image file that is desired to be described.
    Returns:
        str
            String containing Tesseract's transcription using the provided
            language file.
    """
    processed = preprocessing(image)
    return pytesseract.image_to_string(processed, lang=lang)
    
