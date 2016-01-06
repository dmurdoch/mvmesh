\name{mvmeshmisc}
\alias{mvmeshmisc}
\alias{mvmeshFromSimplices}
\alias{mvmeshFromSVI}
\alias{mvmeshFromVertices}
\alias{rtessellation}
\alias{mvmeshCombine}
\alias{uniqueRowsFromDoubleArray}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{Miscellaneous functions used by/with mvmesh}
\description{Utilities for working with mvmesh objects}
\usage{
mvmeshFromSimplices(  S )
mvmeshFromSVI(  V, SVI )
mvmeshFromVertices( V )
mvmeshCombine( mesh1, mesh2 )
rtessellation( n, S, weights=rep(1,dim(S)[3]) )
uniqueRowsFromDoubleArray( A )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{S}{simplices, an (vps x n x nS) array, with S[ , ,k] specifying the vertices of k-th simplex 
}
  \item{V}{(nV x n) matrix giving the distinct vertices in the list of simplices
}
  \item{SVI}{integer (vps x nS) matrix which specifies the indices of the vertices that make up the simplices in S
}
  \item{mesh1, mesh2}{objects of class "mvmesh"
}
  \item{n}{number of vectors to simulate
}
  \item{weights}{weights used for simulation
}
  \item{A}{a matrix of doubles
}
}
\details{Experimental functions. They allow one to build mvmesh objects manually 
by specifying just simplices (\code{mvmeshFromSimplices}), 
or just vertices (\code{mvmeshFromVertices}), or vertices and grouping information (\code{mvmeshFromSVI}).
\code{mvmeshCombines} combines two meshes.  The resulting objects can usually be plotted directly.
\code{rtessellation} allows you to sample from an mvmesh object.
}
\value{undocumented
}
\section{Warning}{This is experimental code, and not throughly tested.  Function names, arguments, and what they do may change in the future.
}
\examples{
\dontrun{
demo(mvmeshmisc) 
}

}

