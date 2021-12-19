library(quantmod)
library(ggplot2)
library(magrittr)
library(broom)

start <- Sys.Date()-365
end <- Sys.Date()

getSymbols(c("SMFG", "SONY", "MITSY"), src = "yahoo", from = start, to = end)
summary(SMFG)

stocks = as.xts(data.frame(SMFG = SMFG[, "SMFG.Adjusted"], SONY = SONY[, "SONY.Adjusted"], MITSY = MITSY[, "MITSY.Adjusted"]))

names(stocks) = c("Mitsui Financial", "SONY", "Mitsui")
index(stocks) = as.Date(index(stocks))

stocks_series = tidy(stocks) %>% 
  ggplot(aes(x=index,y=value, color=series)) + 
  labs(title = "Finance", x = "Date", y = "Latest Price") +  
  scale_size_area() + 
  geom_line()

stocks_series


