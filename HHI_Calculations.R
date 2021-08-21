# Libraries
library(tidyquant)
library(tidyverse)

# Downloading data from the INDEX
Index <- "DOW" # Options: DOW, DOWGLOBAL, SP400, SP500, SP600

DB_Index <- tq_index(Index) %>%
  dplyr::mutate(Weighted_Square = weight^2)

# Calculating the HHI
HHI <- DB_Index$Weighted_Square %>% sum()

# Calculating the effective number of stocks
ENS <- round(1/HHI, digits = 0)

# Presenting the results
data.frame(Companies = nrow(DB_Index),
           Effective = ENS)

# Where is the concentration
DB_Index %>%
  group_by(sector) %>%
  summarise(Allocation = sum(weight), n = n()) %>%
  arrange(desc(Allocation))
