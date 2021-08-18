## ----setup0, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(bootf2)

## ----bootf2-code0, eval=FALSE-------------------------------------------------
#  bootf2(test, ref, path.in, file.in, path.out, file.out,
#         n.boots = 10000L, seed = 306, digits = 2L, alpha = 0.05,
#         regulation = c("EMA", "FDA", "WHO"), min.points = 1L,
#         both.TR.85 = FALSE, print.report = TRUE,
#         report.style = c("concise", "intermediate", "detailed"),
#         f2.type = c("all", "est.f2", "exp.f2", "bc.f2",
#                     "vc.exp.f2", "vc.bc.f2"),
#         ci.type = c("all", "normal", "basic", "percentile",
#                     "bca.jackknife", "bca.boot"),
#         quantile.type = c("all", 1:9, "boot"),
#         jackknife.type = c("nt+nr", "nt*nr", "nt=nr"),
#         time.unit = c("min", "h"), output.to.screen = FALSE,
#         sim.data.out = FALSE)

## ----bootf2-sim01-------------------------------------------------------------
# time points
tp <- c(5, 10, 15, 20, 30, 45, 60)

# model.par for reference with low variability
par.r <- list(fmax = 100, fmax.cv = 3, mdt = 15, mdt.cv = 14, 
                  tlag = 0, tlag.cv = 0, beta = 1.5, beta.cv = 8)

# simulate reference data
dr <- sim.dp(tp, model.par = par.r, seed = 100, plot = FALSE)

# model.par for test 
par.t <- list(fmax = 100, fmax.cv = 3, mdt = 12.29, mdt.cv = 12,
                  tlag = 0, tlag.cv = 0, beta = 1.727, beta.cv = 9)

# simulate test data with low variability
dt <- sim.dp(tp, model.par = par.t, seed = 100, plot = FALSE)

## ----bootf2-ex01, eval=FALSE--------------------------------------------------
#  # output file will be generated automatically
#  bootf2(dt$sim.disso, dr$sim.disso, n.boots = 100, print.report = FALSE,
#         output.to.screen = TRUE)

