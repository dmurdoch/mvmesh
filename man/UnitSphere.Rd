\name{UnitSphere}
\alias{UnitSphere}
\alias{UnitSphereDyadic}
\alias{UnitSphereEdgewise}
\alias{UnitBall}
\alias{LpNorm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Define a mesh on a unit ball in n-dimensions
}
\description{Subdivide the unit ball or sphere into approximately equal simplices in
arbitrary dimenions.  
}
\usage{
UnitSphere(n, k, method = "dyadic", p = 2, positive.only = FALSE)
UnitSphereEdgewise(n, k, p, positive.only)
UnitSphereDyadic(n, k, start = "diamond", p, positive.only)
UnitBall( n, k, method="dyadic", p=2, positive.only=FALSE )
LpNorm(x, p)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{Dimension of the space; the unit sphere is an (n-1) dimensional manifold
}
  \item{k}{Number of subdivisions
}
  \item{method}{"dyadic" or "edgewise": the former recursively subdivides the sphere to get
  a more uniform grid; the latter uses a faster method using one edgewise subdivision.
}
  \item{p}{Power used in the l^p norm; p=2 is the Euclidean norm
}
  \item{positive.only}{TRUE means restrict to the positive orthant; FALSE gives the full ball
}
  \item{start}{starting shape: "diamond" or "icosahedron"
}
  \item{x}{Matrix of points in n-dimensions;  each column is a point in R^n
}
}
\details{\code{UnitSphere} computes a hyperspherical triangle approximation to the unit sphere.
It calls either \code{UnitSphereDyadic} or \code{UnitSphereEdgewise}
based on 'method'.  Both work by subdividing the first octant, and then rotating that
subdivision around to other octants.   
Note that 'k' has a different meaning for the different methods.  When
method="dyadic", k specifies the number of dyadic subdivisions.  When method="edgewise", 
k specifies the number of subdivisions as in \code{\link{UnitSimplex}}, which is then
projected outward to the unit sphere.  So when n=2, a dyadic subdivision with k=2 will
result in 16 edges, whereas an edgewise subdivions with k=2 results in 8 edges.

\code{UnitBall} computes an approximate simplicial approximation to the unit ball.  Specifically,
it generates cones with one vertex at the origin and the other vertices on the surface
of the unit sphere; these later vertices are from \code{UnitSphere}.  If k is large, these cones
will be very narrow/thin. 
}
\value{an object of class "mvmesh"  as described in \code{\link{mvmesh}}.
}
\examples{
UnitSphere( n=2, k=2, method="edgewise", positive.only=TRUE )
UnitSphere( n=2, k=2, method="edgewise" )

UnitSphere( n=3, k=2, method="edgewise", positive.only=TRUE )
UnitSphere( n=3, k=2, method="edgewise" )

UnitBall( n=2, k=2, method="edgewise", positive.only=TRUE )
UnitBall( n=2, k=2, method="edgewise" )

UnitSphere( n=3, k=2, method="dyadic", positive.only=TRUE )
UnitSphere( n=3, k=2, method="dyadic" )

UnitBall( n=3, k=2, method="dyadic", positive.only=TRUE )
UnitBall( n=3, k=2, method="dyadic" )

UnitSphere(  n=3, k=2 )
UnitBall( n=3, k=2 )

x <- c(3,-1,2)
LpNorm( x, p=2 )

\dontrun{
plot( UnitSphere(  n=3, k=2 ), show.label=TRUE )
plot( UnitBall( n=3, k=2 ) )

}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
