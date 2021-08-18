## ----setup0, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(bootf2)

## ----simdpbyf2-code0, eval=FALSE----------------------------------------------
#  sim.dp.byf2(tp, dp, target.f2, seed = NULL, min.points = 3L,
#              regulation = c("EMA", "FDA", "WHO", "Canada", "ANVISA"),
#              model = c("Weibull", "first-order"), digits = 2L,
#              max.disso = 100, message = FALSE, both.TR.85 = FALSE,
#              time.unit = c("min", "h"), plot = TRUE, sim.dp.out,
#              sim.target = c("ref.pop", "ref.median", "ref.mean"),
#              model.par.cv = 50, fix.fmax.cv = 0, random.factor = 3)

## ----simdpbyf2-01-------------------------------------------------------------
# time points
tp <- c(5, 10, 15, 20, 30, 45, 60)

# model.par for reference
par.r <- list(fmax = 100, fmax.cv = 3, mdt = 15, mdt.cv = 14, 
              tlag = 0, tlag.cv = 0, beta = 1.5, beta.cv = 8)

# simulate reference data
dref <- sim.dp(tp, model.par = par.r, seed = 100)

## ----simdpbyf2-f2-50a---------------------------------------------------------
df2_50_a <- sim.dp.byf2(sim.dp.out = dref, target.f2 = 50, seed = 123,
                        message = TRUE)

## ----simdpbyf2-f2-50a1--------------------------------------------------------
format(df2_50_a$model.par$f2 - 50, scientific = FALSE)

## ----simdpbyf2-f2-50-b2-------------------------------------------------------
df2_50_b <- sim.dp.byf2(sim.dp.out = dref, target.f2 = 50, seed = 234,
                        message = TRUE)

# precision 
format(df2_50_b$model.par$f2 - 50, scientific = FALSE)

## ----simdpbyf2-f2-50-3--------------------------------------------------------
df2_50_c <- sim.dp.byf2(sim.dp.out = dref, target.f2 = c(49.99, 50.01),
                        seed = 456, message = TRUE)

# check to see that this is less precise, but still enough for practical use
format(df2_50_c$model.par$f2 - 50, scientific = FALSE)

## ----simdpbyf2-f2-55a---------------------------------------------------------
dp <- c(17, 42, 63, 78, 94, 99, 100)

df2_55a <- sim.dp.byf2(tp, dp, target.f2 = 55, seed = 100,
                       message = TRUE)
# check precision
format(df2_55a$model.par$f2 - 55, scientific = FALSE)

## ----simdpbyf2-f2-55b---------------------------------------------------------
df2_55b <- sim.dp.byf2(tp, dp, target.f2 = c(54.95, 55.04), seed = 100,
                       message = TRUE)

# check precision
format(df2_55b$model.par$f2 - 55, scientific = FALSE)

