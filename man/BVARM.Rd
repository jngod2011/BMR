\name{BVARM}

\alias{BVARM}
\alias{BVARM.default}

\title{BVAR with Minnesota Prior.}

\description{
  Estimate a Bayesian VAR with Minnesota prior.
}

\usage{
BVARM(mydata,coefprior=NULL,p=4,constant=TRUE,
      irf.periods=20,keep=10000,burnin=1000,
      VType=1,decay="H",HP1=0.5,HP2=0.5,HP3=1,HP4=2)
}

\arguments{
  \item{mydata}{
  A matrix or data frame containing the data series used for estimation; this should be of size T x m.}
	\item{coefprior}{
	A numeric vector of length m, matrix of size (m p + 1_c) x m, or a value of `NULL', that contains the prior mean-value of each coefficient. Providing a numeric vector of length m will set a zero prior on all coefficients except the own first-lags, which are set according to the elements in `coefprior'. Setting this input to `NULL' will give a random-walk-in-levels prior.}
	\item{p}{
	The number of lags to include of each variable. The default value is 4.}
	\item{constant}{
	A logical statement on whether to include a constant vector (intercept) in the model. The default is `TRUE', and the alternative is `FALSE'.}
	\item{irf.periods}{
	An integer value for the horizon of the impulse response calculations, which must be greater than zero. The default value is 20.}
	\item{keep}{
	The number of Gibbs sampling replications to keep from the sampling run.}
	\item{burnin}{
	The sample burn-in length for the Gibbs sampler.}
  \item{VType}{
  Whether to use a `VType=1' or `VType=2'. The default is 1.}
	\item{decay}{
	Whether to use harmonic or geometric decay for the VType=2 case.}
	\item{HP1, HP2, HP3, HP4}{
	These correspond to H_1, H_2, H_3, and H_4, respectively, from section 2.3 of the vignette.}
}

\details{
  For technical details of the model, see the accompanying vignette.
}

\value{
The function returns an object of class BVARM, which contains:
  \item{Beta}{
	A matrix of size (m p + 1_c) x m containing the posterior mean of the coefficient matrix (beta).}
	\item{BDraws}{
	An array of size (m p + 1_c) x m x keep which contains the post burn-in draws of beta.}
  \item{BetaVPr}{
  An matrix of size (m p + 1_c) m x (m p + 1_c) m containing the prior covariance matrix of vec(beta).}
	\item{Sigma}{
	A matrix of size m x m containing the fixed residual covariance matrix (Sigma).}
	\item{IRFs}{
	A four-dimensional object of size irf.periods x m x keep x m containing the impulse response function calculations; the first m refers to responses to the last m shock. 
  
  Note: IRF calculations are based on a one standard deviation shock to each variable.}
	\item{data}{
	The data used for estimation.}
	\item{constant}{
	A logical value, TRUE or FALSE, indicating whether the user chose to include a vector of constants in the model.}
}

\author{Keith O'Hara}

\references{
  Canova, Fabio, \emph{Methods for Applied Macroeconomic Research,} Princeton, New Jersey: Princeton University Press, 2007.
  
  Koop, Gary and Dimitris Korobilis, ``Bayesian Multivariate Time Series Methods for Empirical Macroeconomics,'' \emph{Mimeo}, 2010.
}

\seealso{
  \code{\link{forecast.BVARM}}, \code{\link{IRF.BVARM}}, \code{\link{plot.BVARM}}.
}

\examples{
\dontrun{
data(BMRVARData)
prior<-c(0.9,0.95,0.95)
testbvarm <- BVARM(USMacroData[,2:4],prior,p=4,constant=T,irf.periods=20,
                  keep=10000,burnin=5000,VType=1,
                  HP1=0.5,HP2=0.5,HP3=10)
plot(testbvarm,save=F)
IRF(testbvarm,save=F)
forecast(testbvarm,shocks=TRUE,backdata=10,save=FALSE)
}
}

\keyword{BVAR}
\concept{BVAR}