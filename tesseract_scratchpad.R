# https://www.r-bloggers.com/the-new-tesseract-package-high-quality-ocr-in-r/

# install.packages("tesseract")
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


