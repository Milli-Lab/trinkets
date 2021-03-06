from wand.image import Image as w
import PyPDF2

def pdf_page_to_png(src_pdf, pagenum=0, resolution=154):
    """
    Returns specified PDF page as wand.image.Image png.
    :param PyPDF2.PdfFileReader src_pdf: PDF from which to take pages.
    :param int pagenum: Page number to take.
    :param int resolution: Resolution for resulting png in DPI.
    """

    #check_dependencies(__optional_dependencies__['pdf'])
    # Import libraries within this function so as to avoid import-time dependence

    dst_pdf = PyPDF2.PdfFileWriter()
    src_pdf = w(filename=src_pdf,resolution=300)
    dst_pdf.addPage(src_pdf.getPage(pagenum))

    pdf_bytes = io.BytesIO()
    dst_pdf.write(pdf_bytes)
    pdf_bytes.seek(0)

    img = Image(file=pdf_bytes, resolution=resolution)
    
    with img.convert('png') as converted:
        converted.save(filename='converted.png')
    return img

pdf_page_to_png('pdf/testfile.pdf',7,300)
