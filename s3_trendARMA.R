rm(list = ls())

library(dplyr)
library(ggplot2)
library(patchwork)

library(readr)

# Lake Baikal ice data, sorted by ice season
# Calculate calendar day from ice break-up date
B <- read_csv("./data/baikal.csv", skip = 1) %>%
    mutate(Date_iceoff = as.Date(paste(iceoff_year, iceoff_month, iceoff_day,
                                       sep = "-"))) %>%
    mutate(DoY_iceoff = as.numeric(format(Date_iceoff, "%j")))
# ?strptime

# Convert to ts format
iceoff <- ts(B$DoY_iceoff, start = B$iceoff_year[1])

plot.ts(iceoff)

p1 <- ggplot2::autoplot(iceoff, col = "grey50") +
    xlab("Year") +
    theme_light()
p2 <- forecast::ggAcf(iceoff) +
    ggtitle("") +
    theme_light()
p3 <- forecast::ggAcf(iceoff, type = "partial") +
    ggtitle("") +
    theme_light()
p1 + p2 + p3 +
    plot_annotation(tag_levels = 'A')


# Trend testing

funtimes::notrend_test(iceoff, ar.method = "yw", test = "t")

funtimes::notrend_test(iceoff, ar.method = "yw", test = "MK")


# Option 0: just ARMA(p, q)
# ARMA(0, q) = MA(q)
# ARMA(p, 0) = AR(p)
# Based on the ACF and PACF plots, suggest AR(1) = ARMA(1, 0)
# (exponential decay in ACF, cutoff in PACF after lag 1)
# alternatively MA(3)
# alternatively ARMA(1, 1)

m_ar1 = arima(iceoff, order = c(1, 0, 0))
m_ma3 = arima(iceoff, order = c(0, 0, 3))
m_arma11 = arima(iceoff, order = c(1, 0, 1))

# Automatic selection of p and q based on information criterion
m_arma = forecast::auto.arima(iceoff, d = 0, ic = "bic") # ARMA(1, 1)
# m_arma = forecast::auto.arima(iceoff, d = 0, ic = "aicc") # ARMA(3, 0) == AR(3)

ls(m_arma)

res <- m_arma$residuals
# dependence
acf(res)
pacf(res)
# homogeneity
plot.ts(res)
# normality
hist(res)
qqnorm(res)
qqline(res)
shapiro.test(res)

?predict.arima0
P = predict(m_arma, n.ahead = 5)
P$pred
# prediction intervals
lower = P$pred + qnorm(0.025) * P$se
upper = P$pred + qnorm(0.975) * P$se


# Option 1: parametric linear trend + ARMA

Year <- time(iceoff)
mod_lin <- lm(iceoff ~ Year)

ts.plot(iceoff)
abline(mod_lin)

res = mod_lin$residuals
# dependence
acf(res)
pacf(res)
lmtest::dwtest(mod_lin, alternative = "two.sided")
# homogeneity
plot.ts(res)
# normality
hist(res)
qqnorm(res)
qqline(res)
shapiro.test(res)


library(nlme)
# use p and q you selected from the res analysis above (ACF+PACF, or auto.arima)
mod_lin_ar1 <- nlme::gls(iceoff ~ Year
                         ,correlation = nlme::corAR1(form = ~Year))
mod_lin_arma11 <- nlme::gls(iceoff ~ Year
                         ,correlation = nlme::corARMA(form = ~Year, p = 1, q = 1))
summary(mod_lin_ar1)
res <- residuals(mod_lin_ar1, type = "normalized")
# reapply resid diagnostics

?predict.gls
yearLast =  Year[length(Year)]

predict(mod_lin_ar1, newdata = data.frame(Year = (yearLast + 1):(yearLast + 6)))



# Option 3: nonparametric trend + ARMA
# mgcv, gam

# GAMLSS = Generalized additive models for location scale and shape
library(gamlss)

mod_gam_ar1 <- gamlss::gamlss(iceoff ~ pb(Year),
                              correlation = nlme::corAR1(form = ~Year))


mod_gam_ar1_2 <- gamlss::gamlss(iceoff ~ pb(Year)
                              ,nu.formula = ~Year
                              ,family = ST4 #PO PIG ST4
                              ,correlation = nlme::corAR1(form = ~Year))

summary(mod_gam_ar1)
summary(mod_gam_ar1_2)
term.plot(mod_gam_ar1, rug = FALSE, partial.resid = TRUE)
plot(mod_gam_ar1)
plot(mod_gam_ar1_2)

res <- residuals(mod_gam_ar1, what = "z-scores")
res <- residuals(mod_gam_ar1, what = "mu", type = "weighted")
par(mfrow = c(1, 2))
acf(res)
pacf(res)
lawstat::runs.test(res)
lmtest::dwtest(mod_gam_ar1)

# Normality
shapiro.test(res)
nortest::ad.test(res)


library(gamlss.tr)
gamlss.tr::gen.trun(par = c(0), family = "NO")
mod_gam_ar1_3 <- gamlss::gamlss(iceoff ~ pb(Year)
                                ,family = NOtr #PO PIG ST4
                                )
plot(mod_gam_ar1_3)
