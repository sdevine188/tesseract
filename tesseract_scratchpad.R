# https://www.r-bloggers.com/the-new-tesseract-package-high-quality-ocr-in-r/
# https://cran.r-project.org/web/packages/magick/vignettes/intro.html

# install.packages("tesseract")
# install.packages("magick")
library(magick)
library(tesseract)
library(stringr)

# tutorial
text <- ocr("http://jeroenooms.github.io/images/testocr.png")
cat(text)

# test on birth certificate
text <- ocr("C:/Users/Stephen/Desktop/ocr_test/ocr_test_birth_certificate.png")
cat(text)

# test on receipt
text <- ocr("C:/Users/Stephen/Desktop/ocr_test/ocr_test_receipt.png")
cat(text)

# test batch
folder_name <- "C:/Users/Stephen/Desktop/ocr_test/"
ocr_batch <- function(folder_name) {
        all_files <- list.files(folder_name)
        ocr_final_output <- c()
        for(i in 1:length(all_files)) {
                file_path <- str_c(folder_name, all_files[i])
                ocr_output <- ocr(file_path)
                ocr_final_output <- c(ocr_final_output, ocr_output)
        }
        ocr_final_output
}

folder_text <- ocr_batch(folder_name)
cat(folder_text)
cat(folder_text[1])
cat(folder_text[2])

# test handwritten form
getwd()
text <- ocr("C:/Users/Stephen/Desktop/R/tesseract/test_docs/handwritten_form.png")
cat(text)

# test handwritten form - high quality
# doesnt load picture for some reason??
text <- ocr("C:/Users/Stephen/Desktop/R/tesseract/test_docs/handwritten_form_high_quality.png")
cat(text)


####################################


# test using magick

# receipt
img <- image_read("C:/Users/Stephen/Desktop/ocr_test/ocr_test_receipt.png")
print(img)
cat(image_ocr(img))

# birth certificate
img <- image_read("C:/Users/Stephen/Desktop/ocr_test/ocr_test_birth_certificate.png")
print(img)
cat(image_ocr(img))

# low-quality handwritten
handwritten2 <- image_read("C:/Users/Stephen/Desktop/R/tesseract/test_docs/handwritten_form.png")
print(handwritten2)
handwritten2 <- image_ocr(handwritten2)
cat(handwritten2)

# high-quality handwritten
handwritten_hq2 <- image_read("C:/Users/Stephen/Desktop/R/tesseract/test_docs/handwritten_form_high_quality.png")
print(handwritten_hq2)
handwritten_hq2 <- image_ocr(handwritten_hq2)
cat(handwritten_hq2)
