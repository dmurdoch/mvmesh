\name{UnitSimplex}
\alias{UnitSimplex}
\alias{SolidSimplex}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Define a mesh on the unit simplex or the canonical simplex
}
\description{
Defines an equal area/volume subdivision of the unit simplex and the canonical simplex in R^n.
The unit simplex is the (n-1) dimensional simplex with
vertices (1,0,0,...,0), (0,1,0,...,0), ...,(0,0,0,...,1), i.e. all x >= 0
with sum(x)==1.

The solid simplex is the n dimensional simplex with
vertices (1,0,0,...,0), (0,1,0,...,0), ...,(0,0,0,...,1), and (0,0,...,0),
i.e. all x >= 0 with sum(x) <= 1.
}
\usage{
UnitSimplex(n, k )
SolidSimplex( n, k )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{dimension of the space
}
  \item{k}{number of subdivisions
}
}
\details{\code{EdgeSubdivision} is called to
do a k-subdivision of each edge, and then that output is converted to a matrix of vertices.
}
\value{an object of class "mvmesh" as described in \code{\link{mvmesh}}.
}
\examples{

UnitSimplex( n=2, k=3 )
SolidSimplex( n=2, k=3 ) 

UnitSimplex( n=3, k=2 )
SolidSimplex( n=3, k=2 )

UnitSimplex( n=5, k=4 )
SolidSimplex( n=5, k=4 )

\dontrun{
plot( UnitSimplex( n=2, k=3 ) )
plot( SolidSimplex( n=2, k=3 ) )

plot( UnitSimplex( n=3, k=2 ) )
plot( SolidSimplex( n=3, k=2 ) )

}
}

