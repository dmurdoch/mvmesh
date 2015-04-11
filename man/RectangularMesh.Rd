\name{RectangularMesh}
\alias{RectangularMesh}
\alias{NextMultiIndex}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Subdivide a hyperrectangle with a standard grid
%%  ~~function to do ... ~~
}
\description{\code{EdgeSubdivision} implements the 
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
RectangularMesh( a, b, breaks=5, silent=FALSE )
NextMultiIndex( i, n )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{a}{vector specifying the "lower left" vertex of the rectangle
}
  \item{b}{vector specifying the "upper right" vertex of the rectangle
}
  \item{breaks}{a specification of the subdivision scheme.  See details below.
}
  \item{silent}{indicates whether or not to warn the caller if the subdivision
determined by 'breaks' covers the whole hyperrectangle [a,b]. 
}
  \item{i}{integer vector
}
  \item{n}{integer vector
}
}
\details{\code{RectangularMesh} computes an rectangular mesh on the hyperrectangle
[a,b] = [a[1],b[1]] x [a[2],b[2]] x ... x [a[n],b[n]].   It is similar to
the function \code{mesh} in CRAN package plot3D, but works for dimension d=2,3,4,...


'breaks' determines how 
each component is divided, it is motivated by the argument breaks in \code{hist}.
If 'breaks' is a vector of length n, then breaks[i] gives the number of evenly
sized bins in coordinate i, spread out over the range [a[i],b[i]].
If 'breaks' is a single number m, then each component
is subdivided into that many bins, i.e. this is equivalent to breaks=rep(m,n).
Thus the default breaks=6 subdivides each coordinate into 6 bins.  
Finally, if a more complicated subdivision is desired, 'breaks' can a list
with n fields.  breaks[[i]] should be a vector of dividing points for coordinate i.
See the example below. In this last case, where the bin boundaries are explictly
defined, 'a' and 'b' are not used (other than a possible warning if the specified
bins do not cover the rectangle given by 'a' and 'b').

%%  ~~ If necessary, more details than the description above ~~
}
\value{An object of class "mvmesh"  as described in \code{\link{mvmesh}}.
}
\examples{
RectangularMesh( a=c(1,3), b=c(2,7), breaks=2 )
RectangularMesh( a=c(1,3), b=c(2,7), breaks=c(4,10) )
RectangularMesh( a=c(1,3), b=c(2,7), 
    breaks=list( seq(1,3,by=0.25), seq(2,7,by=1) ) )

\dontrun{
plot( RectangularMesh( a=c(1,3), b=c(2,7), breaks=3 ), show.labels=TRUE )
plot( RectangularMesh( a=c(1,3), b=c(2,7), breaks=c(4,10) ), show.labels=TRUE )
plot( RectangularMesh( a=c(1,3), b=c(2,7), 
    breaks=list( seq(1,3,by=0.25), seq(2,7,by=1) ) ), show.labels=TRUE )
plot( RectangularMesh( a=c(1,3), b=c(2,7), breaks=3 ), show.labels=TRUE, 
    label.values=letters[1:9], col='green' )
plot( RectangularMesh( a=c(1,3,0), b=c(6,7,6), breaks=3 ), show.labels=TRUE, col='blue')
}    
}

