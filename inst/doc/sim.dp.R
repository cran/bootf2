## ----setup0, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(bootf2)

## ----simdp-code0, eval=FALSE--------------------------------------------------
#  sim.dp(tp, dp, dp.cv, model = c("Weibull", "first-order"),
#         model.par = NULL, seed = NULL, n.units = 12L, product,
#         max.disso = 100, ascending = FALSE, message = FALSE,
#         time.unit = c("min", "h"), plot = TRUE,
#         plot.max.unit = 36L)

## ----simple01-dat-------------------------------------------------------------
# simulation
tmp1 <- sim.dp(seed = 1234)

## ----simple01-summary, error=TRUE---------------------------------------------
tmp1$sim.summary

## ----simple01-disso, error=TRUE-----------------------------------------------
tmp1$sim.disso

## ----simple01-info, error=TRUE------------------------------------------------
tmp1$sim.info

## ----simple01-par, error=TRUE-------------------------------------------------
tmp1$model.par.ind

## ----simple01-plot, error=TRUE------------------------------------------------
tmp1$sim.plot

## ----simple01-boxplot, error=TRUE---------------------------------------------
# default plot.max.unit = 36
sim.dp(n.units = 100)$sim.plot

## ----model01-dat, error=TRUE--------------------------------------------------
fo.par <- list(fmax = 100, fmax.cv = 3, k = 0.1, k.cv = 20, 
               tlag = 0, tlag.cv = 0)
fo.dat <- sim.dp(model = "first-order", model.par = fo.par, seed = 123)
fo.dat$sim.plot
fo.dat$sim.summary

## ----model01-par, eval=FALSE--------------------------------------------------
#  # with alpha = xx and alpha.cv = yy to replace beta/beta.cv if alternative
#  # expression of Weibull model is used.
#  mod.par <- list(fmax = 100, fmax.cv = 3, tlag = 0, tlag.cv = 0,
#                  mdt = 20, mdt.cv = 25, beta = 2, beta.cv = 30)

## ----mvn01-dat, error=TRUE----------------------------------------------------
# target mean profile 
dp <- c(39, 56, 67, 74, 83, 90, 94)

# CV at each time points
dp.cv <- c(19, 15, 10, 8, 8, 5, 3)

mvn.dat <- sim.dp(tp, dp = dp, dp.cv = dp.cv, seed = 1234)
mvn.dat$sim.summary

## ----mvn01-plot, error=TRUE---------------------------------------------------
mvn.dat$sim.plot

## ----mvn02-dat, error=TRUE----------------------------------------------------
mvn.dat2 <- sim.dp(tp, dp = dp, seed = 123)
mvn.dat2$sim.summary

