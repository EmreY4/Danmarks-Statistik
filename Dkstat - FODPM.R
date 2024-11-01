# Fra timen & powerpointen
library(dkstat)
allet <- dst_get_tables(lang = "da")
write.csv(allet, "alletaps.csv", row.names = FALSE)
library(readr)
alletaps <- read_csv("alletaps.csv")
View(alletaps)

library("dkstat")
source("util.R")

# table FODPM (FODPM = Unge mødre fra dkstat)
FODPM_meta <- dst_meta("FODPM")

FODPM_meta$variables
FODPM_meta$values
FODPM_meta$values$LFNR
FODPM_meta$values$Tid
# Set filters
FODPM_meta_filters = list(
  MODERSALDER = "*",
  LFNR = "1. barn",
  Tid = "*")

# Get the data
FODPM_data <- dst_get_data(table = "FODPM", query = FODPM_meta_filters, lang = "da")

# data analysis (struktur)
str(FODPM_data)

# Fjern LFNR
FODPM_data <- FODPM_data[,-2]

agg_FODPM_data$nyage <- sapply(agg_FODPM_data$Mage, function(x) gsub("år", "", x))

# Ændre age om til numbers
agg_FODPM_data$nyage <- as.numeric(agg_FODPM_data$nyage)
agg_FODPM_data_new <- aggregate(agg_FODPM_data$x, by = list(Mage = agg_FODPM_data$nyage, Tid = agg_FODPM_data$Tid), FUN = sum)

# Kategori variabel
agg_FODPM_data$kat <- sapply(agg_FODPM_data$nyage, FUN = opdel_alder)

# Aggregering
agg_FODPM_data_new <- aggregate(agg_FODPM_data$x,
          by = list(
            Kat = agg_FODPM_data$kat,
           År = agg_FODPM_data$Tid),
          FUN = sum)

#plot
library(ggplot2)
#ab <- agg_FODPM_data2[agg_FODPM_data2$kat=="preteen"|agg_FODPM_data2$kat=="teen"]

ab <- agg_FODPM_data_new[agg_FODPM_data_new$Kat %in% c("Preteen", "Teen"),]

ggplot(data=ab, aes(x = År, y = x, color = Kat))+ geom_line()+geom_point()


