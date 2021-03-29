import pytesseract


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
    return pytesseract.image_to_string(image, lang=lang)
