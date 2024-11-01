# Set working directory in order to read UUHELD
getwd()
setwd("~/Documents/RStudio/DKstat")

# Peg og klik via Excel:
library(readxl)
UUheld <- read_excel("UUheld.xlsx")
View(UUheld)

# Hent via API
library(dkstat)
?my_function
"??my_function"

# Hent via API
# Hente metadata mhp filtrering
uheld_meta <- dst_meta(table = "UHELDK1", lang = "da")

# Konstruer liste med filtre
uheld_meta_filters <- list(
  OMRÅDE = "*",
  UHELD = "Personskade i alt",
  INDBLAND = c("Almindelig personbil", "Lastbil over 3.500 kg.", "Fodgænger"),
  ALDER = "*",
  KØN = c("Mænd", "Kvinder"),
  Tid = "*"
)

# Hente data via filtre
uheldsdata <- dst_get_data(table = "UHELDK1", query = uheld_meta_filters, lang = "da")

