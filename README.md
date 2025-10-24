# Conventions and format examples

## Audio task notes

Provide a summary overview of the theoretical concepts and methods.
Focus more on theory and less on the examples from the text, do not reference R functions or code.
Avoid phrases like "you know", "it is clear that", "kind of".
Please do not read mathematical notations or formulas verbatim, instead summarize them in words.
Keep the audio length between 15 and 20 minutes. 

## Audio processing

as Dialogue -> Podcast Voice -> Clip Volume + 1.5 dB -> Export to mp3

### YouTube details:
This audio overview is an adaptation by Vyacheslav Lyubchich. 
It is based on the original work, "Time Series Analysis: Lecture Notes with Examples in R", by V. Lyubchich and Y. R. Gel, available at https://vlyubchich.github.io/tsar/ and licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
This new, adapted work is also licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.

The audio was generated using AI and may be inaccurate. Please refer to the original work for accurate information.


- Category: Education
- License
- Languages: English
- Add specific keywords + time series, time series analysis, lecture notes, R, forecasting
- End screen: 1 vid, 1 playlist, 1 subscribe
- Visibility: Public

[**Audio overview**](https://youtu.be/GmJLSaD29gY)


## Spellings

a.k.a.
changepoint
dataset
heteroskedasticity
homoskedasticity
hyperparameter
nondeterministic
nonlinear
nonnegative
nonparametric
nonstationarity
non-causal
non-existent
non-monotonic
non-normal
non-overlapping
non-seasonal
scatterplot
vs.


## Format

$p$-value
$\mathrm{WN}(0,\sigma^2)$
$N(0,1)$
$X_t \sim$ I(2)

\boldsymbol
\dots (not \ldots or \cdots)

Use *italics* for highlights in text, not **bold**.

Use 'single quotes' in text whenever possible.

#| code-fold: false

Space and capital letter after a comment sign: 
# This is a comment

Cite
@Brockwell:Davis:2002
or
[@Brockwell:Davis:2002]
or
[@Rebane:Pearl:1987;@Pearl:2009]

Recall the classical decomposition
$$
Y_t = M_t + S_t + \epsilon_t,
$${#eq-trseas}

model as @eq-trseas is

[Riksbank Prize](https://www.nobelprize.org/prizes/economic-sciences/2003/engle/facts/)


## Figures

fig-height 
use default (5) for 1-2 plots per row
#| fig-height: 3 for 3 plots per row
#| fig-height: 7 for decompose or 2 rows
#| fig-height: 9 for 3 rows

```{r}
#| label: fig-shampoo
#| fig-cap: "Monthly shampoo sales over three years and a corresponding sample ACF."

p1 <- forecast::autoplot(shampoo) +
    xlab("Year") +
    ylab("Sales") +
    theme_light()
p2 <- forecast::ggAcf(shampoo) +
    ggtitle("") +
    xlab("Lag (months)") +
    theme_light()
p1 + p2 +
    plot_annotation(tag_levels = 'A') &
    theme_light()
```


## Notes and examples

::: {.callout-note}
text
:::

::: {.callout-note icon=false}

## Example: Secchi

text
:::


## Table manual formatting

| from 0 to $d_{L}$ | from $d_{L}$ to $d_{U}$ | from $d_{U}$ to $4 - d_{U}$ | from $4 - d_{U}$ to $4 - d_{L}$ | from $4 - d_{L}$ to 4 |
|------|------|------|------|------|
| Reject $H_{0}$, positive autocorrelation | Neither accept $H_{1}$ or reject $H_{0}$ | Do not reject $H_{0}$ | Neither accept $H_{1}$ or reject $H_{0}$ | Reject $H_{0}$, negative autocorrelation |

: Regions of rejection of the null hypothesis for the Durbin--Watson test {#tbl-DW}


Collapse All — Alt+O.
Expand All — Shift+Alt+o.


# Save RData as CSV
load("data/Secchi_CB1.1.RData")
secchi_df <- data.frame(Year = floor(time(Secchi)),
                        Month = cycle(Secchi),
                        Value = as.numeric(Secchi))
write.csv(secchi_df, "data/Secchi_CB1.1.csv", row.names = FALSE)

# Reload as ts
secchi_data <- read.csv("data/Secchi_CB1.1.csv")
Secchi <- ts(secchi_data$Value,
start = c(min(secchi_data$Year), min(secchi_data$Month)),
frequency = 12)


