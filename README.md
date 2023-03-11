# Wishlist for lectures and examples
- after GARMA, add about GAMLSS (see the example file on Chesapeake Bay)
- make causality a separate lecture #10, add on diff-in-diff with cannabis example.
- add wavelets in spectral Time-Frequency estimation, see Hali's emails
https://rstudio-pubs-static.s3.amazonaws.com/9428_1197bd003ebd43c49b429f22ea4f36e5.html
- add example coverage calculations Lect 2 or ARIMA
- add a lecture on panel data analysis
- add that tsa::arimax is a transfer function, not ARIMAX model
- add about ts bootstrap (sieve, block) in l07
- add video lectures

# To-dos
- check that all materials transferred from main.pdf
- check the folders in MEES713, MEES713/check this.
- check comments from past PDFs to fix typos
- check missing materials from YRG's lectures


# Conventions and format examples

## Spellings 

a.k.a.
changepoint
heteroskedasticity
homoskedasticity
nonlinear
nonnegative
nonparametric
nonstationarity
non-existent
non-monotonic
non-normal
non-seasonal
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
    plot_annotation(tag_levels = 'A')
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
