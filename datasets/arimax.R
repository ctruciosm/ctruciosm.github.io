library(dplyr)
library(ggplot2)
library(tsibble)
library(fpp3)

url = "http://leg.ufpr.br/~lucambio/CE017/20212S/oshorts.tsm"
dados = read.table(url)
n = nrow(dados)

ggplot(dados) + 
  geom_line(aes(x = 1:n, y = V1), color = "red") +
  geom_point(aes(x = 1:n, y = V1))

dados <- dados |> mutate(tempo = seq(as.Date("2000-01-01"), by = "day", length = 57)) |> 
  mutate(tempo = ymd(tempo), V1 = as.numeric(V1)) |> 
  as_tsibble(index = tempo) 

fit <- dados |> model(ARIMA(V1))
report(fit)