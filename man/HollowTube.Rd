\name{HollowTube}
\alias{HollowTube}
\alias{SolidTube}

\title{Define tubes in n-dimensions
}
\description{Define a 'horizontal' tube, either hollow or solid, in n dimensions}  
\usage{
HollowTube( n, k.x=1, k.circumference=2, method="dyadic", p=2 )
SolidTube( n, k.x=1, k.circumference=2, method="dyadic", p=2 )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{Dimension of the space
}
  \item{k.x}{Number of subdivisions along the x[1] direction (first component)
}
  \item{k.circumference}{Number of subdivisions around the circumference; note the meaning of
this depends on the value of \code{method}.
}
  \item{method}{"dyadic" or "edgewise": the former recursively subdivides the sphere to get
  a more uniform grid; the latter uses a faster method using one edgewise subdivision.
}
  \item{p}{Power used in the l^p norm; p=2 is the Euclidean norm
}
}
\details{\code{HollowTube} computes an approximation to a tube, an (n-1) dimensional 
surface in n space.  The tube is 'horizontal', e.g. the center line of the tube is the x-axis with
0 <= x[1] <= 1 and radius 1;
use \code{AffineTransform} to rotate, stretch or translate.  
The mesh is basically constructed by taking the cross product of an x[1] subdivision
with an (n-1) dimensional sphere; the optional arguments \code{k.circumference, method, p} are used in
a call to \code{UnitSphere} to specify the sphere.  The default value of p=2 gives a tube
with round/Euclidean cross section; using a different p will make the cross sections of the tube
a ball in the Lp norm.  

\code{SolidTube} computes an approximation to a solid tube, an n dimensional solid in
n space.  
}
\value{an object of class "mvmesh"  as described in \code{\link{mvmesh}}.
}
\examples{
HollowTube( n=3 )
SolidTube( n=3 )

\dontrun{
plot( HollowTube(  n=3, k.x=3, k.circumference=2 ), show.faces=TRUE, col='red', alpha=0.5 )
plot( SolidTube( n=3, k.x=5, k.circumference=2 ), col='blue' )

# use non-Euclidean sphere to define wall of tube 
plot( HollowTube(  n=3, k.x=10, k.circumference=2, p=0.6 ), col='green')
}
}
