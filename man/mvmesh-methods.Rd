\name{mvmesh-methods}
\alias{print.mvmesh}
\alias{plot.mvmesh}
\alias{DrawSimplex2d}
\alias{DrawSimplex3d}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Methods to print and draw mvmesh objects}
\description{Print summary of a mesh and plot 2D and 3D simplices.  The 2D plot routines use the
standard R plots; 3D plot routines use the rgl package.}
\usage{
\method{print}{mvmesh}( x, ... )
\method{plot}{mvmesh}( x, new.plot=TRUE, show.points=FALSE, show.edges=TRUE, show.faces=FALSE, 
                     show.labels = FALSE, label.values=NULL, ... )
DrawSimplex2d(S,label,show.labels,mvmesh.type,show.edges=TRUE,show.faces=FALSE,...)
DrawSimplex3d(S,label,show.labels,mvmesh.type,show.edges=TRUE,show.faces=FALSE,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{an object of class "mvmesh", usually from one of the functions 
  \code{UnitSimplex}, \code{SolidSimplex},
  \code{UnitSphere}, \code{UnitBall}, \code{RectangularMesh}, etc.
}
  \item{new.plot}{If TRUE, start a new plot; otherwise add to an existing plot
}
  \item{show.points}{If TRUE, show vertices (use cex= to change size)
}
  \item{show.edges}{If TRUE, show edges
}
  \item{show.faces}{If TRUE, fill in solid faces (only works in certain cases); otherwise show edges
}
  \item{show.labels}{If TRUE, an identifying label will be drawn inside each simplex
}
  \item{label.values}{values to display if show.label=TRUE; defaults to 1,2,3,...
}
  \item{\dots}{Optional argument to plot functions to set color, alpha, etc.
}
  \item{label}{Integer to label current simplex
}
  \item{S}{a simplex, an n x m matrix with columns S[,1],...,S[,m] giving the vertices
}
  \item{mvmesh.type}{integer code identifying what type of mesh this is, see the
  definition of class "mvmesh" in \code{\link{mvmesh}}.
}
}
\details{\code{print} will print out summary information about a mesh object

\code{plot} will plot a mesh, calling \code{DrawSimplex2d} or \code{DrawSimplex3d} 
to plot a each simplex as appropriate for the dimension.  These routines are meant to
give a basic display; not all rgl capabilities are used.
}
\value{A plot is drawn, usually nothing is returned
}
\examples{
print( SolidSimplex( n=3, k=2 ) )

\dontrun{

plot( SolidSimplex( n=3, k=2 ), col='red' )

}
}
