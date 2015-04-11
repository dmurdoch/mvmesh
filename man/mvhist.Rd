\name{mvhist}
\alias{mvhist}
\alias{histDirectional}
\alias{histSimplex}
\alias{histRectangular}
\alias{TallyHrep}
\alias{TallyCones}
\alias{DrawPillars}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{Multivariate histograms}
\description{Tabulate and plot histograms for data, including directional histograms}
\usage{
histDirectional( x, k, p=2, plot.type="default", freq=TRUE, positive.only=FALSE, 
     report="summary", ... )
histRectangular( x, breaks=10, plot.type="default", freq=TRUE, report="summary", ... )
histSimplex( x, S, plot.type="default", freq=TRUE, report="summary", ... )

TallyHrep( x, H, report="summary" )  
DrawPillars( S, height, shift=rep(0.0,3), ... )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{data in an (n x d) matrix; rows are d-dimensional data vectors
}
  \item{k}{number of subdivisions
}
  \item{p}{power of p-norm
}
  \item{freq}{TRUE for a frequency histogram, FALSE for a relative frequency histogram
}
  \item{breaks}{specifes the subdivision of the region; see 'breaks' in \code{\link{RectangularMesh}}
}
  \item{plot.type}{type of plot, see details below
}
  \item{positive.only}{If TRUE, look only in the first octant
}
  \item{report}{level of warning messages; one of "summary", "all", "none".
}
  \item{\dots}{Optional arguments to plot
}
  \item{S}{(vps x d x nS) array of simplices in V representation, see \code{\link{V2Hrep}}
}
  \item{H}{array of simplices in H representation, see \code{\link{V2Hrep}}
}
  \item{height}{vector of length nS giving the heights of the pillars
}
  \item{shift}{shift of the pillars, typically (0,0,0) for 2d data or (0,0,z0) for 3d data
}
}
\details{Calculate and plot multivariate histograms.  In all cases, the bins are simplices computed from some
description.  Then the number in each simplex is tallied using \code{TallyHrep}.

'plot.type' values depend on the type of plot being used.  Possible values are:
\itemize{
\item "none" - does not show a plot, just return the counts
\item "index" - shows a histogram of simplex index number versus count, does not show the 
   geometry, but works in any dimension
\item "pillars" - shows a 3D plot with pillars/columns having base the shape of the 
   simplices and height proportional to frequency counts.
   When the points are 2D, this works for \code{histRectangular} and \code{histSimplex}; when the points are 3D, this only
   works for \code{histRectangular}
\item "counts" - shows frequency counts as a number in the center of each simplex
\item "radial" - \code{histDirectional} only, shows radial spikes proportional to the counts 
\item "grayscale" - \code{histDirectional} only, shows radial spikes proportional to the counts 
\item "orthogonal" - \code{histDirectional} only, shows radial spikes proportional to the counts 
\item "default" - type depends on the dimension of the data and type of histogram
}
}
\value{A plot is drawn (unless plot.type="none").  A list is returned invisibly, with fields:
\itemize{
\item counts - frequency count in each bin
\item nrejects - number of x values not in any bin
\item nties - number of points in more than one bin (if bins are set up to be non-overlapping, 
   this should only occur on a shared edge between two simplices
\item nx - total number of data points in x
\item rel.freq - counts/nx
\item rel.rejects - nrejects/nx
\item mesh - object of type mvmesh, see \code{\link{mvmesh}}
\item plot.type - input value
\item report - input value
}
}
\examples{

# two dimensional, isotropic
x <- matrix( rnorm(8000), ncol=2 )
histDirectional( x, k=1 )
histRectangular( x, breaks=5 )

\dontrun{

# three dimensional positive data
x <- matrix( abs(rnorm(9000)), ncol=3 )
histDirectional( x, k=3, positive.only=TRUE, col='blue', lwd=3 )
histRectangular( x, breaks=4 )

demo(mvhist) # shows a range of multivariate histograms

}

}
