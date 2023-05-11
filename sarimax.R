########################
###     SARIMAX      ###
########################
library(dplyr)
library(fpp3)
library(ggplot2)

url <- "https://raw.githubusercontent.com/ctruciosm/ctruciosm.github.io/master/datasets/SBL.TSM"
sbl <- read.table(url)

ts.plot(sbl)
abline(v = 98, col = "red")

sbl <- sbl |> mutate(legislation = c(rep(0,98), rep(1, 22)))

## Opção 1: Raíz

ols_fit <- lm(V1~legislation, data = sbl)
ts.plot(ols_fit$residuals)
acf(ols_fit$residuals)
pacf(ols_fit$residuals)



fit_01 = arima(sbl$V1, 
               order = c(1, 0, 0), 
               seasonal = list(order = c(0,1,0), period = 12),
               xreg = sbl$legislation)

fit_02 = arima(sbl$V1, 
               order = c(1, 0, 1), 
               seasonal = list(order = c(1,1,0), period = 12),
               xreg = sbl$legislation)

fit_03 = arima(sbl$V1, 
               order = c(1, 1, 1), 
               seasonal = list(order = c(1,1,0), period = 12),
               xreg = sbl$legislation)

fit_04 = arima(sbl$V1, 
               order = c(13, 0, 0), 
               xreg = sbl$legislation)

fit_05 = arima(sbl$V1, 
               order = c(1, 0, 0), 
               seasonal = list(order = c(0,1,1), period = 12),
               xreg = sbl$legislation)

fit_06 = arima(sbl$V1, 
               order = c(1, 0, 0), 
               seasonal = list(order = c(1,1,1), period = 12),
               xreg = sbl$legislation)


predict(fit_01, 12, newxreg = rep(1, 12))
predict(fit_04, 12, newxreg = rep(1, 12))


AIC(fit_01, k = log(nrow(sbl)))
AIC(fit_02, k = log(nrow(sbl)))
AIC(fit_03, k = log(nrow(sbl)))
AIC(fit_04, k = log(nrow(sbl)))
AIC(fit_05, k = log(nrow(sbl)))
AIC(fit_06, k = log(nrow(sbl)))

AIC(fit_01)
AIC(fit_02)
AIC(fit_03)
AIC(fit_04)
AIC(fit_05)

## Opção 2: Nutella

sbl <- sbl |> 
  mutate(V1 = as.numeric(V1)) |> 
  mutate(Tempo = seq(as.Date("1975-01-01"), by = "month", length = 120)) |> 
  mutate(Tempo = yearmonth(Tempo))

sbl <- sbl |> as_tsibble(index = Tempo) 

fit_07 <- sbl |> 
  model(ARIMA(V1))

fit_08 <- sbl |> 
  model(ARIMA(V1 ~ legislation))