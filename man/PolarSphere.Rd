\name{PolarSphere}
\alias{PolarSphere}
\alias{PolarBall}
\alias{Polar2Rectangular}
\alias{Rectangular2Polar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Define a mesh on the unit sphere/ball in n-dimensions determined by a polar coordinates grid.
}
\description{Subdivide the unit ball or sphere into simplices in
arbitrary dimensions using a rectangular grid on the polar parameterization of the sphere.

The general n-dimensional polar coordinates to and from rectangular coordinates transformations 
are provided.
}
\usage{
PolarSphere(n, breaks=c(rep(4,n-2),8), p = 2, positive.only = FALSE)
PolarBall( n, breaks=c(rep(4,n-2),8), p=2, positive.only=FALSE )
Rectangular2Polar( x )
Polar2Rectangular( r, theta )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{Dimension of the space; the Polar sphere is an (n-1) dimensional manifold
}
  \item{breaks}{specification of the partition of in the angle space theta.  See the definition of
  'breaks' in \code{\link{SolidRectangle}}.
}
  \item{p}{Power used in the l^p norm; p=2 is the Euclidean norm
}
  \item{positive.only}{TRUE means restrict to the positive orthant; FALSE gives the full ball
}
  \item{r}{a vector of radii of length m.
}
  \item{theta}{a (n-1) x m matrix of angles.
}
  \item{x}{ (n x m) matrix, with column j being the point in n-dimensional space.
}
}
\details{\code{PolarSphere} computes an approximation to the unit sphere using a rectangular
grid in the polar angle space.
\code{PolarBall} uses a partition of the polar sphere and joins those simplices to 
the origin to approximately partition the unit ball.
\code{LpNorm} computes the l^p norm of each columns of \code{x}.

\code{Polar2Rectangular} and \code{Rectangular2Polar} convert between the polar coordinate
representation  (r,theta[1],...,theta[n-1]) and the rectangular coordinates (x[1],...,x[n]).

n dimensional polar coordinates are given by the following: \cr
 rectangular x=(x[1],...,x[n])  corresponds to
   polar  (r,theta[1],...,theta[n-1]) by \cr
 x[1]  = r*cos(theta[1]) \cr
 x[2]  = r*sin(theta[1])*cos(theta[2]) \cr
 x[3]  = r*sin(theta[1])*sin(theta[2])*cos(theta[3]) \cr
   ... \cr
 x[n-1]= r*sin(theta[1])*sin(theta[2])*...*sin(theta[n-2])*cos(theta[n-1]) \cr
 x[n]  = r*sin(theta[1])*sin(theta[2])*...*sin(theta[n-2])*sin(theta[n-1]) \cr
 
 Here theta[1],...,theta[n-2] in [0,pi), and theta[n-1] in [0,2*pi). 
 This is the parameterization described in the Wikipedia webpage for "n-sphere".
 Note that this is NOT a 1-1 transformation: when theta[1]=0, it follows
 that x[2]=x[3]=...=x[n]=0.  This is analagous to all longitude lines going
 through the north pole in standard 3d spherical coordinates.
 
 For multivariate integration, the Jacobian of the above tranformation
  is J(theta) = r^(n-1) * prod( sin(theta[1:(n-2)])^((n-2):1) );
  note that theta[n-1] does not appear in the Jacobian.
}

\value{\code{PolarSphere} and \code{PolarBall} return an object of class 
"mvmesh"  as described in \code{\link{mvmesh}}.
\code{Polar2Rectangular} returns an (n x m) matrix of rectangular coordinates.
\code{Rectangular2Polar} returns a list with fields:
 \item{r}{a vector of length m containing the radii}
 \item{theta}{an (n x m) matrix of angles}
}
\examples{
PolarSphere(  n=3, breaks=4)
PolarBall( n=3, breaks=4 )

(x <- matrix( 1:10, ncol=2 ))
(a <- Rectangular2Polar( x ))
Polar2Rectangular( a$r, a$theta )

(x <- matrix( 1:12, ncol=4 ))
(a <- Rectangular2Polar( x ))
Polar2Rectangular( a$r, a$theta )

\dontrun{
plot( PolarSphere( n=2, breaks=8 ) )
plot( PolarBall( n=2, breaks=8 ) )

plot( PolarSphere( n=3, breaks=c(4,8) ) )
plot( PolarBall( n=3, breaks=c(4,8) ) )
}

}
