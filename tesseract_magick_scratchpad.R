library(tesseract)
library(magick)
library(dplyr)
library(pdftools)

# https://cran.r-project.org/web/packages/tesseract/vignettes/intro.html#preprocessing_with_magick

setwd("H:/R/tesseract")
list.files()

test_image <- ocr("test_ocr_image.png", engine = eng)
test_image
cat(test_image)

eng <- tesseract("eng")
test_image_data <- ocr_data("test_ocr_image.png", engine = eng)
cat(test_image)
test_image_data
test_image_data %>% arrange(confidence)
test_image_data %>% mutate(row_id = row_number()) %>% filter(word == "cor")


####################################################


ca_1 <- ocr("scanned_docs/california1.pdf")
ca_1
cat(ca_1)

ca_1_data <- ocr_data("scanned_docs/california1.pdf")
ca_1_data
ca_1_data %>% arrange(confidence)
mean(ca_1_data$confidence) # 74.11


#######################################################


# with magick preprocessing - better results
ca_1_png <- pdf_convert("scanned_docs/california1.pdf", dpi = 600)
ca_1_text <- image_read(ca_1_png) %>%
        image_resize("2000x") %>%
        image_convert(type = 'Grayscale') %>%
        image_trim(fuzz = 40) %>%
        image_write(format = 'png', density = '300x300') %>%
        ocr(.) 
cat(ca_1_text)

ca_1_text_data <- image_read(ca_1_png) %>%
        image_resize("2000x") %>%
        image_convert(type = 'Grayscale') %>%
        image_trim(fuzz = 40) %>%
        image_write(format = 'png', density = '300x300') %>%
        ocr_data(.) 
ca_1_text_data %>% arrange(confidence)
mean(ca_1_text_data$confidence) # 83.00
