library("meineRSkripte")

library("ChemmineR")
library("ChemmineOB")

library("MolGraphR")

library("dplyr")

######## Load data

setwd("C:/Users/Robert Geitner/CloudStation/Ilm-NMR-Rh103/Database4Publication")
#setwd("C:/Users/claco/CloudStation/Ilm-NMR-Rh103/Database4Publication")
#setwd("E:/CloudStation/Ilm-NMR-Rh103/Database4Publication")

## Load tibble

load("NMR-and-SDF_11-06-26.rda")

## Last quality check

empty_sf <- which(nmrstruct$sf == "")

## Save csv
# Check how to best save multiple shifts per compound in .csv

write.table(nmrstruct[-empty_sf, c("num", "sf", "shift", "Temp", "LM", "MW", "C", "N", "Rh", "O", "cansmi", "envlab", "ref")] %>% mutate(shift = paste(shift, sep = "; ")), "Ilm-NMR-Rh103.csv")

## Rewrite cleaned tibble

ilmnmr_rh103 <- nmrstruct[-empty_sf, c("num", "sf", "shift", "Temp", "LM", "MW", "C", "N", "Rh", "O", "cansmi", "envlab", "ref", "sdf", "tbl_graph")]

save(ilmnmr_rh103, file = "Ilm-NMR-Rh103.rda")

## save SDFs

write.SDF(realss_nmrdata[-empty_sf], "Ilm-NMR-Rh103.sdf")

for(i in (1:length(realss_nmrdata))[-empty_sf]) {
  write.SDF(realss_nmrdata[[i]], paste0("SDFs/", nmrstruct$num[i], ".sdf"))
}

#### Info for publication in archives

nrow(ilmnmr_rh103)                  # number of entries
length(unique(ilmnmr_rh103$cansmi)) # number of unique molecules
length(unique(ilmnmr_rh103$ref))    # number of references

length(unique(ilmnmr_rh103$cansmi)) - 0 # number of new molecules
