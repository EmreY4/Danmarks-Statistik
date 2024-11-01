library(dkstat)
library(dplyr)
library(tidyr)
#indhenter forbrugerforventninger meta tabel med API
forv1_meta <- dst_meta("FORV1")
tables <- dst_get_tables()

#sætter de filter du har brug for
forv1_filters <- list(
  INDIKATOR = "*",
  Tid = "*")

#Henter dataen
forv1_data <- dst_get_data(table = "FORV1", query = forv1_filters, lang = "da")

#Renser data og stiller op
forv1 <- as.data.frame(pivot_wider(data = forv1_data, names_from = INDIKATOR, values_from = value))
start_date <- as.Date(forv1[1,1])
end_date <- as.Date(forv1[nrow(forv1),1])

forv1_1 <- forv1

forv1 <- forv1[,-1]

####-------------Estimeret data-----------####

# Tjek om der mangler 1 eller 2 rækker
mangler_rækker <- nrow(forv1) %% 3

if (mangler_rækker == 1) {
  antal_tomme_rækker <- 2
} else if (mangler_rækker == 2) {
  antal_tomme_rækker <- 1
} else {
  antal_tomme_rækker <- 0
}

if (antal_tomme_rækker > 0) {
  # Opret et tomt dataframe med samme kolonnenavne som forv1
  Tomme <- data.frame(matrix(numeric(0), nrow = antal_tomme_rækker, ncol = ncol(forv1)))
  
  # Kopier kolonnenavne og datatyper fra forv1 til Tomme
  colnames(Tomme) <- colnames(forv1)
  Tomme[] <- lapply(forv1, function(x) numeric(antal_tomme_rækker))
  
  # Tilføj de tomme rækker til forv1
  forv1_lm <- rbind(forv1, Tomme)
}

if (antal_tomme_rækker == 2) {
  forv1_lm[nrow(forv1_lm)-1,] <-forv1_lm[nrow(forv1_lm)-2,]
  forv1_lm[nrow(forv1_lm),] <-forv1_lm[nrow(forv1_lm)-2,]
  print1 <- forv1_lm[nrow(forv1_lm)-2,]
  cat("Estimeret værdier for 2. og 3. måned: ", paste(print1, collapse = " "), "\n")
  
} else if (antal_tomme_rækker == 1) {
  forv1_lm[nrow(forv1_lm),] <- colMeans(forv1_lm[nrow(forv1_lm)-1:2,])
  print2 <- colMeans(forv1_lm[nrow(forv1_lm)-1:2,])
  cat("Estimeret værdier for 3. måned: ", paste(print2, collapse = " "), "\n")
  
  
} else {print("Krav for kvartal: Opfyldt")}

####-------------kvartal omregner----------####

#Laver ny data frame brugt til kvartal
forv1_kvart <- data.frame()

for (i in seq(from = 3, to = nrow(forv1_lm), by = 3)) {
  mymean <- colMeans(forv1_lm[(i-2):i, 1:13], na.rm = TRUE)
  mymean <- round(mymean, 2)
  new_row <- forv1_lm[i, 1:13]
  new_row[1, 1:13] <- mymean
  forv1_kvart <- rbind(forv1_kvart, new_row)
}

#Indæstter datoer
forv1_kvart$dato <- NA

date_sequence <- seq(start_date, end_date, by = "quarter")
forv1_kvart$dato <- date_sequence

#Skifter $Dato placering til første kolonne
forv1_kvart <- forv1_kvart[, c(ncol(forv1_kvart), 1:(ncol(forv1_kvart)-1))]

#Ændre række navnene
rownames(forv1_kvart) <- 1:nrow(forv1_kvart)

# Fjerner NA
forv1_kvart <- na.omit(forv1_kvart)

# Fra 2000 og fremad (optionalt)
forv1_kvart <- forv1_kvart[-c(1:91), ]
