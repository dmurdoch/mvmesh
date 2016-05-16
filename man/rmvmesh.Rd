\name{rmvmesh}
\alias{rmvmesh}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{Simulate from a mesh}
\description{Simulate from a mvmesh object}
\usage{
rmvmesh( n, mesh, weights=rep(1,ncol(mesh$SVI) ) )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mesh}{object of class "mvmesh"
}
  \item{n}{number of vectors to simulate
}
  \item{weights}{weights used for simulation
}
}
\details{
\code{rmvmesh} allows you to sample from an mvmesh object, simplex j is sampled with probability weights[j]. Note that if the simplices are of
different sizes, and the weights are uniform, this will result in uniform sampling among the simplices, but different densities on different faces.
See the example below with alternating weights.  If you want to get a uniform density, set the weights equal to the \code{m} dimensional volume of the 
simplices that make up the meshes.

\code{rmvmesh} works for any mesh where the \code{m} dimensional simplices are convex 
combinations of \code{(m+1)} vertices i.e. \code{vps=m+1}.
This works whatever the dimension of the embedding space is, and whether or not things have been rotated, scaled or shifted by \code{AffineTransform}.
It also works with an unaltered SolidRectangle or HollowRectangle.  
\code{mvmesh} does not currently work with mvmesh objects of type PolarSphere, PolarBall, HollowTube, or SolidTube; nor does it work with rectangles that have
been altered  by \code{AffineTransform}.

Note that \code{rmvmesh} samples from the mesh, not from the idealized object.  In particular, in the example below with a unit sphere,
the sampled points are from the tessellation approximation to the sphere, not from the unit sphere itself.  So (with probability one), all
points will have length less than 1.
}
\value{A matrix of values x: x[1, ],x[2, ],...,x[n, ] are vectors sampled from the mesh.
}
\examples{
\dontrun{
sphere <- UnitSphere( n=3, k=2 )
plot(sphere)
x <- rmvmesh( 1000, sphere )
points3d( x, col='red' )

box <- HollowRectangle( a=c(0,2,-1), b=c(1,5,3), breaks=3 )
plot(box)
x <- rmvmesh( 500, box )
points3d( x, col='blue', size=5 )


plot(box)
nS <- ncol(box$SVI) # number of simplices in box
weights <- rep( c(0,1), nS/2 )  # alternating 0,1 weights
x <- rmvmesh( 10000, box, weights )
points3d( x, col='green', size=5 )

}
}

