## ----setup0, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(bootf2)

## ----calcf2-code0, eval=FALSE-------------------------------------------------
#  calcf2(test, ref, path.in, file.in, path.out, file.out,
#         regulation = c("EMA", "FDA", "WHO", "Canada", "ANVISA"),
#         cv.rule = TRUE, message = FALSE, min.points = 3L,
#         f2.type = c("est.f2", "exp.f2", "bc.f2", "vc.exp.f2",
#                     "vc.bc.f2", "all"), both.TR.85 = FALSE,
#         digits = 2L, time.unit = c("min", "h"),  plot = TRUE,
#         plot.start.time = 0, plot.max.unit = 24L)

## ----calcf2-cvok01-dat--------------------------------------------------------
# time points
tp <- c(5, 10, 15, 20, 30, 45, 60)

# model.par for reference with low variability
par.r1.lv <- list(fmax = 100, fmax.cv = 3, mdt = 15, mdt.cv = 13, 
                  tlag = 0, tlag.cv = 0, beta = 1.5, beta.cv = 7)

# simulate reference data
dr1.lv <- sim.dp(tp, model.par = par.r1.lv, seed = 100, plot = FALSE,
                 message = TRUE)

# model.par for test 
par.t1.lv <- list(fmax = 100, fmax.cv = 3, mdt = 12.29, mdt.cv = 10,
                  tlag = 0, tlag.cv = 0, beta = 1.727, beta.cv = 8)

# simulate test data with low variability
dt1.lv <- sim.dp(tp, model.par = par.t1.lv, seed = 100, plot = FALSE,
                 message = TRUE)

## ----calcf2-cvok01-a, error=TRUE----------------------------------------------
t_vs_r_ema <- calcf2(dt1.lv$sim.disso, dr1.lv$sim.disso,
                     message = TRUE)

## ----calcf2-cvok01-b, error=TRUE----------------------------------------------
t_vs_r_who <- calcf2(dt1.lv$sim.disso, dr1.lv$sim.disso, 
                     regulation = "WHO", message = TRUE)

## ----calcf2-cvok01-c----------------------------------------------------------
t_vs_r <- calcf2(dt1.lv$sim.disso, dr1.lv$sim.disso, regulation = "FDA",
                 both.TR.85 = TRUE, message = TRUE, plot = FALSE)

## ----calcf2-cvko-dat----------------------------------------------------------
# model.par for reference with high variability
par.r1.hv <- list(fmax = 100, fmax.cv = 3, mdt = 15, mdt.cv = 20, 
                  tlag = 0, tlag.cv = 0, beta = 1.5, beta.cv = 10)

# simulate reference data
dr1.hv <- sim.dp(tp, model.par = par.r1.hv, seed = 100, plot = FALSE)

# model.par for test 
par.t1.hv <- list(fmax = 100, fmax.cv = 3, mdt = 12.29, mdt.cv = 15,
                  tlag = 0, tlag.cv = 0, beta = 1.727, beta.cv = 12)

# simulate test data with low variability
dt1.hv <- sim.dp(tp, model.par = par.t1.hv, seed = 100, plot = FALSE)

## ----calcf2-cvko-a, error=TRUE------------------------------------------------
calcf2(dt1.hv$sim.disso, dr1.hv$sim.disso, message = TRUE)

## ----calcf2-cvko-b, error=TRUE------------------------------------------------
dt1.hv_vs_dr1.hv <- calcf2(dt1.hv$sim.disso, dr1.hv$sim.disso,
                           cv.rule = FALSE, message = TRUE)

