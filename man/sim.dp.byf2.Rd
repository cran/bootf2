% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sim.dp.byf2.R
\name{sim.dp.byf2}
\alias{sim.dp.byf2}
\title{Simulate Dissolution Profiles by \eqn{f_2}{f2} Values}
\usage{
sim.dp.byf2(tp, dp, target.f2, seed = NULL, min.points = 3L,
            regulation = c("EMA", "FDA", "WHO", "Canada", "ANVISA"),
            model = c("Weibull", "first-order"), digits = 2L,
            max.disso = 100, message = FALSE, both.TR.85 = FALSE,
            time.unit = c("min", "h"), plot = TRUE, sim.dp.out,
            sim.target = c("ref.pop", "ref.median", "ref.mean"),
            model.par.cv = 50, fix.fmax.cv = 0, random.factor = 3)
}
\arguments{
\item{tp, dp}{\emph{Numeric} vector of time points \code{tp} and the mean dissolution
profiles \code{dp}.}

\item{target.f2}{\emph{Numeric} value of target \eqn{f_2}{f2}. It can be a
\emph{single value}, or a \emph{vector of two values} that represent the lower and
upper limit of target \eqn{f_2}{f2} value. See Details.}

\item{seed}{\emph{Integer} seed value for reproducibility. If missing, a random
seed will be generated for reproducibility purpose.}

\item{min.points}{An \emph{integer} indicating the minimum time points to be used
to calculate \eqn{f_2}{f2}. The default value 3 should be used for
conventional \eqn{f_2}{f2} calculation. See Details. @seealso \code{\link[=calcf2]{calcf2()}}.}

\item{regulation}{\emph{Character} strings indicating regulatory guidelines.
@seealso \code{\link[=calcf2]{calcf2()}} for the discussion of those guidelines.}

\item{model}{\emph{Character} strings of model names. Currently only \code{"Weibull"}
and \code{"first-order"} models are supported. @seealso \code{\link[=sim.dp]{sim.dp()}} for the
description of models.}

\item{digits}{An \emph{integer} indicating the decimal points for the output.}

\item{max.disso}{\emph{Numeric} value for the maximum possible dissolution.
In theory, the maximum dissolution is 100\%, but in practice, it is not
uncommon to see higher values, such as 105\%, or much lower values,
especially for products with low solubility.}

\item{message}{\emph{Logical}. If \code{TRUE}, basic information of the simulation
will be printed on screen.}

\item{both.TR.85}{\emph{Logical}. If \code{TRUE}, and if \code{regulation = "FDA"}, all
measurements up to the time points at which both test and reference
products dissolve more than 85\% will be used to calculate \eqn{f_2}{f2}.
This is the conventional, but incorrect, interpretation of the US FDA rule.
Therefore, the argument should only be set to \code{TRUE} for validation purpose
such as comparing the results from old literature that use the wrong
interpretation to calculate \eqn{f_2}{f2}. @seealso \code{\link[=calcf2]{calcf2()}} for detailed
discussion.}

\item{time.unit}{\emph{Character} strings indicating the unit of time. It should
be either \code{"min"} for minute or \code{"h"} for hour. It is mainly used for
checking CV rules and making plot. See Regulation in Details.
@seealso \code{\link[=calcf2]{calcf2()}}.}

\item{plot}{\emph{Logical}. If \code{TRUE}, a a dissolution versus time plot will be
included in the output.}

\item{sim.dp.out}{Output of function \code{sim.dp()}. If this argument is
supplied by the user, then \code{tp/dp}, \code{regulation}, \code{model}, \code{max.disso},
and \code{time.unit} will be ignored, if they are provided by the user, since
all those arguments are included in \code{sim.dp.out}.}

\item{sim.target}{\emph{Character} strings indicating to which target profile
should the newly simulated profile be compared for the calculation of
\eqn{f_2}{f2}. This argument is only applicable when \code{sim.dp.out} is
provided. See Details.}

\item{model.par.cv, fix.fmax.cv}{\emph{Numeric} values expressed as percentages
used for random generation of model parameters and fmax when optimization
algorithm is not used, i.e., when \code{target.f2} is a vector of two numbers.
See Details.}

\item{random.factor}{\emph{Numeric} value used for random generation of model
parameters when optimization algorithm is used, i.e., when \code{target.f2}
is a single number. See Details.}
}
\value{
A \emph{list} of 2 components: a \emph{data frame of model parameters} and a
\emph{data frame of mean dissolution profile} generated using the said model
parameters. The output can be passed to function \code{sim.dp()} to further
simulate multiple individual profiles.
}
\description{
Given any mean dissolution profile \code{dp}, this function will simulate a mean
dissolution profile such that when the newly simulated profile is compared
to \code{dp}, the calculated \eqn{f_2}{f2} will be equal to the predefined target
\eqn{f_2}{f2} value.
}
\details{
The main principle of the function is as follows:
\enumerate{
\item For any given mean dissolution profile \code{dp}, fit a suitable mathematical
model and obtain model parameters.
\itemize{
\item No precise fitting is required since those parameters will be served as
\emph{initial value} for further model fitting.
\item If \code{sim.dp.out}, the output of the function \code{sim.dp()}, is available,
no initial fitting is necessary as model parameters can be read directly
from the output, unless multivariate normal distribution approach was
used in \code{sim.dp()}. In such case, initial model fitting will be done.
}
\item Find a suitable model parameters and simulate a new dissolution profile,
comparing the new profile to the provided reference profile \code{dp} by
calculating \eqn{f_2}{f2}. If the the obtained \eqn{f_2}{f2} is
\emph{equal to}, or \emph{within the lower and upper limit of}, the \code{target.f2},
then the function will output the obtained model parameters and the new
profile.
}

There are two approaches used to find the suitable model parameters:
\itemize{
\item If \code{target.f2} is a single value, optimization algorithm will be used and
the newly simulated dissolution profile will have \eqn{f_2}{f2} equal to
\code{target.f2} when compared to \code{dp} (within numeric precision defined by the
tolerance).
\item If \code{target.f2} is a vector of two numbers representing the lower and upper
limit of target \eqn{f_2}{f2} value, such as \code{target.f2 = c(lower, upper)},
then dissolution will be obtained by random searching and the calculated
\eqn{f_2}{f2} will be within the range of lower and upper.
}

For example, you can set \code{target.f2 = c(54.95, 55.04)} to have target
\eqn{f_2}{f2} of 55. Since \eqn{f_2}{f2} should be normally reported without
decimal, in practice, this precision is enough. You might be able to do with
\code{c(54.99, 55.01)} if you really need more precision. However, the narrower
the range, the longer it takes the function to run. With narrow range such as
\code{c(54.999, 55.001)}, it is likely the program will fail. In such case,
provide single value to use optimization algorithm.

Arguments \code{model.par.cv}, \code{fix.fmax.cv}, and \code{random.factor} are certain
numeric values used to better control the random generation of model
parameters. The default values should work in most scenarios. Those values
should be changed only when the function failed to return any value. Read
vignette of the function (\code{vignette("sim.dp.byf2", package = "bootf2")})
for more details.

The data frame \code{sim.summary} in \code{sim.dp.out}, the output of function
\code{sim.dp()}, contains \code{dp}, the population profile, and \code{sim.mean} and
\code{sim.median}, the mean and median profiles calculated with \code{n.units} of
simulated individual profiles. All these three profiles could be used as the
target profile that the newly simulated profile will be compare to. Argument
\code{sim.target} defines which of the three will be used: \code{ref.pop}, \code{ref.mean},
and \code{ref.median} correspond to \code{dp}, \code{sim.mean} and \code{sim.median},
respectively.
}
\examples{
tp <- c(5, 10, 15, 20, 30, 45, 60)

mod.par.r <- list(fmax = 100, fmax.cv = 2, tlag = 0, tlag.cv = 0,
                  mdt = 25, mdt.cv = 4, beta = 2.1, beta.cv = 3)

d.r <- sim.dp(tp, model.par = mod.par.r, seed = 100, n.units = 120L,
              plot = FALSE)

model.par1 <- sim.dp.byf2(sim.dp.out = d.r, target.f2 = 60, seed = 123)
model.par2 <- sim.dp.byf2(sim.dp.out = d.r, target.f2 = c(59.95, 60.04),
                          seed = 123)

}
