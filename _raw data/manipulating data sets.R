library(readxl)
library(tibble)
library(tidyr)
library(dplyr)
library(devtools)
use_data_raw()
# World Development indicators --------------------------------------------

wdi_raw <- as_tibble(read_excel("_raw data/WDI.xlsx"))

wdi <- wdi_raw %>% select(`Country Name`, `Country Region`,
                          `Series Name`, 58:72) %>%
  gather(key = year,value = valor,-c(`Country Name`,
                                     `Country Region`,
                                     `Series Name`)) %>%
  spread(key = `Series Name`, value = valor)

colnames(wdi) <- c("Pais","Regiao","Ano","PerCap_dolar","PerCap_growth","Inflacao")

use_data(wdi_raw)
use_data(wdi)


# Corruption perception index ---------------------------------------------

cpi_raw <- as_tibble(read_excel("_raw data/CPI.xlsx"))

cpi <- cpi_raw %>% select(`Country Name`,
                          `Indicator Name`,
                          9:23) %>%
  gather(key = year, value = valor, -c(`Country Name`,
                                       `Indicator Name`)) %>%
  spread(key = `Indicator Name`,value = valor)
colnames(cpi) <- c("Pais","Ano","CPI")

use_data(cpi_raw)
use_data(cpi)


# press freedom index -----------------------------------------------------

pfi_raw <- as_tibble(read_excel("_raw data/PFI.xlsx"))

pfi <- pfi_raw %>%  select(`Country Name`,
                           `Indicator Name`,
                           8:23) %>%
  gather(key = year, value = valor, -c(`Country Name`,
                                       `Indicator Name`)) %>%
  spread(key = `Indicator Name`,value = valor)
colnames(pfi) <- c("Pais","Ano","PFI")

use_data(pfi_raw,pfi)


# democracy index ---------------------------------------------------------

di_raw <- as_tibble(read_excel("_raw data/DI.xlsx"))

di <- di_raw %>% select(`Country Name`,
                        `Variable Name`,
                        9:16) %>%
  gather(key = year, value = valor, -c(`Country Name`,`Variable Name`)) %>%
  spread(key = `Variable Name`,value = valor)
colnames(di) <- c("Pais","Ano","DI")

use_data(di_raw,di)


# Juntandos todos os dados numa mesma planilha ----------------------------

data_set1 <- inner_join(wdi,cpi,c("Pais","Ano"))

data_set1 <- inner_join(data_set1,pfi,c("Pais","Ano"))

data_set1 <- inner_join(data_set1, di,c("Pais","Ano"))

use_data(data_set1)
