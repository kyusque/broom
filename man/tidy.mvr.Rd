% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pls-mvr-tidiers.R
\name{tidy.mvr}
\alias{tidy.mvr}
\title{Tidy a(n) mvr object}
\usage{
\method{tidy}{mvr}(x, ncomp = x$ncomp, comps = NULL,
  intercept = FALSE, ...)
}
\arguments{
\item{x}{An \code{mvr} object such as those created by \code{\link[pls:mvr]{pls::mvr()}}, \code{\link[pls:plsr]{pls::plsr()}}, \code{\link[pls:cppls]{pls::cppls()}}
and \code{\link[pls:pcr]{pls::pcr()}}.}

\item{ncomp}{The number of components to include in the model. Ignored if comps is specified.}

\item{comps}{If specified, the values of each component out of comps are shown.}

\item{intercept}{Whether coefficients for the intercept should be included. Ignored if comps is
specified.}

\item{...}{Additional arguments. Not used. Needed to match generic
signature only. \strong{Cautionary note:} Misspelled arguments will be
absorbed in \code{...}, where they will be ignored. If the misspelled
argument has a default value, the default value will be used.
For example, if you pass \code{conf.lvel = 0.9}, all computation will
proceed using \code{conf.level = 0.95}. Additionally, if you pass
\code{newdata = my_tibble} to an \code{\link[=augment]{augment()}} method that does not
accept a \code{newdata} argument, it will use the default value for
the \code{data} argument.}
}
\description{
Tidy summarizes information about the components of a model.
A model component might be a single term in a regression, a single
hypothesis, a cluster, or a class. Exactly what tidy considers to be a
model component varies cross models but is usually self-evident.
If a model has several distinct types of components, you will need to
specify which components to return.
}
\details{
The number of components to fit is specified with the argument ncomp.
It means from the 1st component to the ncomp-th component are used to fit.
If comps is given, however, estimates are the coefficients for a model with only the component
comps[i], i.e. the contribution of the component comps[i] on the regression coefficients.
}
\examples{
library(pls)
library(dplyr)
library(ggplot2)

data(yarn) # Single-response model
yarn.pls <- plsr(density ~ NIR, 6, data = yarn, validation = "CV")
glance(yarn.pls)
tidy(yarn.pls)
augment(yarn.pls)

data(oliveoil) # Multi-response model
sens.pls <- plsr(sensory ~ chemical, ncomp = 4, scale = TRUE, data = oliveoil)
glance(sens.pls)
tidy(sens.pls)
augment(sens.pls)

set.seed(42)
test_id <- sample(1:nrow(yarn), nrow(yarn) / 3)
yarn.pls.train <- plsr(density ~ NIR, 3, data = slice(yarn, -test_id))
augment(yarn.pls.train, newdata = slice(yarn, test_id)) \%>\%
  mutate(.rownames = test_id) \%>\%
  ggplot(aes(.rownames, .t.squared[, 3])) +
  geom_point() +
  ggtitle("How far each sample is from the center of the model.")
}
\seealso{
\code{\link[=tidy]{tidy()}}, \code{\link[pls:coef.mvr]{pls::coef.mvr()}}

Other mvr tidiers: \code{\link{augment.mvr}},
  \code{\link{glance.mvr}}
}
\concept{mvr tidiers}
\value{
A \code{\link[tibble:tibble]{tibble::tibble()}} with columns:
  \item{estimate}{The estimated value of the regression term.}
  \item{response}{Which response column the coefficients correspond to (typically `Y1`, `Y2`, etc).}
  \item{term}{The name of the regression term.}

}
