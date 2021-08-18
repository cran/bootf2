## ----setup0, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(bootf2)

## ----longlink, echo=FALSE-----------------------------------------------------
ema1 <- "https://www.ema.europa.eu/en/documents/scientific-guideline/"
ema2 <- "guideline-investigation-bioequivalence-rev1_en.pdf#page=21"
ema3 <- paste0(ema1, ema2)
fda  <- "https://www.fda.gov/media/70936/download#page=12"
fda2 <- "https://www.gmp-compliance.org/files/guidemgr/UCM070246.pdf#page=12"
fdamr <- "https://www.fda.gov/media/70956/download#page=37"
canada1 <- "https://www.canada.ca/en/health-canada/services/drugs-health"
canada2 <- "-products/drug-products/applications-submissions/guidance"
canada3 <- "-documents/post-notice-compliance-changes/quality-document/"
canada4 <- paste0(canada1, canada2, canada3, "guidance.html#a5")
ca1 <- "https://www.canada.ca/en/health-canada/services/drugs-health-"
ca2 <- "products/drug-products/applications-submissions/guidance-documents/"
ca3 <- "canadian-reference-product-guidance.html#app2"
ca4 <- paste0(ca1, ca2, ca3)
who1 <- "https://apps.who.int/iris/bitstream/handle/10665/258720/"
who2 <- "9789241210034-eng.pdf?sequence=1&isAllowed=y#page=244"
who3 <- paste0(who1, who2)
#anvisa1 <- "https://bvsms.saude.gov.br/bvs/saudelegis/anvisa/2010/"
anvisa1a <- "https://web.archive.org/web/20190806045126/http://bvsms.saude."
anvisa1b <- "gov.br/bvs/saudelegis/anvisa/2010/res0031_11_08_2010.html"
anvisa2  <- paste0(anvisa1a, anvisa1b)

## ----fda85rule01, echo=FALSE--------------------------------------------------
 fda85 <- data.frame(Time = c(5, 10, 15, 20, 30, 45, 60),
              Test = c(7, 15, 50, 69, 82, 84, 86),
              Ref = c(10, 20, 55, 86, 90, 95, 97))
 knitr::kable(fda85, booktabs = TRUE)

