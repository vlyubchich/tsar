library(dplyr)
library(ggplot2)
library(patchwork)
options(digits = 3)
theme_set(theme_light())

D <- read.csv("data/tilefish.csv")
Y = ts(D$Landings, start = min(D$Year))

library(forecast)
ggplot2::autoplot(Y)

library(fable)
m <- as_tsibble(Y) %>%
    model(ARIMA(Y ~ 1, ic = "bic"))
report(m)

m %>%
    fabletools::forecast(h = 10) %>%
    ggplot2::autoplot(Y, level = NULL)

m %>%
    fabletools::forecast(h = 10) %>%
    fabletools::autoplot()


library(tsibble)
library(fable)
library(feasts)
library(patchwork)

tilefish_tsbl <- readr::read_csv("data/tilefish.csv") %>%
    rename(Y = Landings) %>% # Renaming for consistency with formula
    as_tsibble(index = Year) %>%
    mutate(Y = na.interp(Y))

# 3. Plot the Time Series
autoplot(tilefish_tsbl, Y) +
    labs(x = "Year", y = "Landings (tonne)")


p1 <- tilefish_tsbl %>% ACF(Y) %>% autoplot() + ggtitle("ACF")
p2 <- tilefish_tsbl %>% PACF(Y) %>% autoplot() + ggtitle("PACF")
p1 + p2

fit <- tilefish_tsbl %>%
    model(arma_bic = ARIMA(Y ~ 1, ic = "bic"))

# 6. Review Model Report
report(fit)

gg_tsresiduals(fit)

# forecast and plot the forecasts
fit %>%
    forecast(h = 10) %>%
    fabletools::autoplot(tilefish_tsbl, level =NULL) +
    labs(x = "Year", y = "Landings (tonne)")

class(fit %>%
          forecast(h = 10))
