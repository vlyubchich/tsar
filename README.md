# Future work
- make ARMA example in l04 real data
- move garma to appendix
- make causality a separate lecture 10, add on diff-in-diff with cannabis example.
+ add example coverage calculations Lect 2 or ARIMA, eventually move part of the material 
from l02 to a separate lecture on Model evaluation and forecasting. forecast::accuracy(). 
caret::postResample(obs = y_test, pred = y_dnn) Overfitting. B&D Ch. 9
Remember that all predictive inference is based on the assumptions that the relationships 
between the variables and their dynamics will be the same in the future.
- add a lecture on panel data analysis
- expand on wavelets, add example of acoustic data
- appendix or lecture on changepoint analysis
- GLM or another generalized model with classification example for fisheries or ecology.
- local stationarity, warping, time motifs, graph representation of time series
- from NOAA project with G.N.: "Environmental Statistics 2: identification of different 
types of rare events in time series (appendix?), time-series cross-validation (l 12?), 
and GAMLSS (lect 12 on TSREG2 - done; lect 3 - done)"

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
This is an audio overview of the lecture 
"Title" 
from Lyubchich, V. and Gel, Y. R. (2025) Time Series Analysis: Lecture Notes with Examples in R. https://vlyubchich.github.io/tsar/

The audio was generated using AI and may be inaccurate. Please refer to the original lecture notes for accurate information.


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
Expand All — Shift+Alt+O.
