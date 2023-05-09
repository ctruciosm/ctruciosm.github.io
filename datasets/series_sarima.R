

library(sarima)

serie1 <- sim_sarima(n = 500, model = list(sma = 0  , ma = 0  , sar = 0.3, ar = 0.3, nseasons = 12, sigma2 = 25, iorder=1, siorder=1), xintercept = NULL, n.start = 500)
serie2 <- sim_sarima(n = 500, model = list(sma = 0  , ma = 0.4, sar = 0.8, ar = 0.5, nseasons = 7,  sigma2 = 16, iorder=1, siorder=1), xintercept = NULL, n.start = 500)
serie3 <- sim_sarima(n = 500, model = list(sma = 0  , ma = 0  , sar = 0, ar = 0.4, nseasons = 12,  sigma2 = 4, iorder=1, siorder=0), xintercept = NULL, n.start = 500)
serie4 <- sim_sarima(n = 500, model = list(sma = 0  , ma = 0.2  , sar = 0, ar = 0.4, nseasons = 0,  sigma2 = 4, iorder=1, siorder=0), xintercept = NULL, n.start = 500)
serie5 <- sim_sarima(n = 500, model = list(sma = 0  , ma = 0.2  , sar = 0, ar = 0.4, nseasons = 12,  sigma2 = 36, iorder=1, siorder=1), xintercept = NULL, n.start = 500)

series <- data.frame(serie1, serie2, serie3, serie4, serie5)

write.csv(series, "series_me607.csv")