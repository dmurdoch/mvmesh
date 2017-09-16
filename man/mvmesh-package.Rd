\name{mvmesh-package}
\alias{mvmesh}
\docType{package}
\title{Multivariate meshes and histograms in arbitrary dimensions}
\description{Define, manipulate and plot multivariate meshes/grids in n-dimensional 
Euclidean space. Multivariate histograms based on these meshes are provided.}
\details{
A range of multivariate problems require working with simplices, spheres, balls, 
rectangular and tubular meshes in dimension n > 1.
The multivariate histogram functions in this package provide routines to tabulate
and display multivariate data.  For example, 
directional histograms tablulate the number of points in a
sequence of directions, see function \code{\link{histDirectional}}.
Multivariate stable distributions and multivariate extreme value distributions are
defined by a measure
on a sphere or simplex.  Also, simulation of generalized spherical laws involves a triangulation
of some surface.  Numerical quadrature problems on a region or surface in n space require the ability to specify and
work with meshes, e.g. packages \code{SphericalCubature} and \code{SimplicialCubature}.
Finally, these meshes can be used on their own to create and plot multivariate shapes not in the \code{rgl} package.

A key goal for this package is that the dimension n is not limited to 2 or 3, but in principle can
be arbitrary. Of course, as n increases compute times and required memory will increase 
quickly.  This package uses existing methods from computational geometry that work
in arbitrary dimension.  Several of these functions were written as prototypes, so
getting something to work was the immediate goal, speed was not.

In this documentation we will use the term grid to mean a collection of points,
usually approximately evenly spread on a solid or surface.  We will use the term mesh to mean both
the grid, and the grouping information that tells which points make up the
simplices that triangulate/tesselate the region.

Please let me know if you find any mistakes.  I will try to fix bugs promptly.
Constructive comments for improvements are welcome;  
actually implementing any suggestions will be dependent on time constraints.


This research was supported by an agreement with Cornell University, Operations 
Research & Information Engineering, under contract W911NF-12-1-0385 from the Army 
Research Development and Engineering Command.


Version history: 
\itemize{
\item 1.0 original package
\item 1.1 added functions \code{histDirectionalQuantileThreshold}, \cr
  \code{histDirectionalAbsoluteeThreshold}, \code{HollowTube}, \code{SolidTube}, \code{Lift2UnitSimplex}, \cr
 \code{IntersectMultipleSimplicesV}, \code{IntersectMultipleSimplicesH}, \code{Intersect2SimplicesH} \cr
\item 1.2 added new functions \code{mvmeshFromSVI}, \code{mvmeshfromSimplices}, \code{mvmeshFromVertices}, \code{rtesselation},
   new argument normalize.by.area in \code{histDirectional}, new argument label.orthants in \code{histDirectional}.  Speed up 3d plots. 
\item 1.3 replace \code{rtessellation} with more general \code{rmvmesh}; add argument 'm' to mvmeshFromSVI; rename
  \code{RectangularMesh} to \code{SolidRectangle}; add \code{HollowRectangle}; fix \code{Icosahedron} to correctly set 'm'.
\item 1.4 fix a bug in \code{IntersectMultipleSimplicesH}.
\item 1.5 add new return value 'which.simplex' to \code{TallyHrep}; for each data point x[,i], it identifies which simplex contains that point; 
  minor change in \code{Intersect2SimplicesH}; change 'octant' to 'orthant' to correctly describe what happens in all dimensions;
  improve \code{IntersectMultipleSimplicesH} and \code{Intersect2SimplicesH}
}
}

\section{Programming details and notes}{
The remainder of this section describes some of the internal details of the package.
It is not needed for the average user.

Points in n-dimensional space are stored in row vectors as is customary in R. 
All simplices considered in this package are convex. 
A single convex simplex can be described/stored in two ways:
\itemize{
\item A vps x n matrix of (doubles) S; the rows S[1,], S[2, ], etc. are the vertices in R^n.  
The simplex is the convex hull of the vertices. Note: vps stands for 'vertices per simplex'.
\item An nV x n matrix of (doubles) vertices V with rows giving the
        points in R^n, and an integer vector of length vps called SVI (Simplex Vertex Indices) 
        that specifies which vertices make up a simplex.  
}

Both of these descriptions have their uses, so the core functions in this package calculate
both.   To store all the relevant
information needed, the basic functions in this package return an object of class mvmesh.  
An object of class mvmesh has the following fields, extending the definitions
above from a single simplex to a list of simplices:
\itemize{
\item type - a string describing the mesh, e.g. "UnitSimplex" (see table below)
\item mvmesh.type - an integer specifying the type of mesh (see table below)
\item n - dimension of the space
\item m - dimension of the mesh, e.g. the unit sphere in n=3 dimensions is an m=2 dimensional
   surface (see table below)
\item vps - vertices per simplex, the number of vertices that define a simplex, which must be the
same for all simplices in this mesh (see table below)
\item S - an (vps x n x nS) array, with S[ , ,k] specifying the vertices of k-th simplex
\item V - an (nV x n) matrix giving the distinct vertices in the list of simplices (repeated vertices in 
              S that are on common edges are removed)
\item SVI - an integer (vps x nS) matrix which specifies the indices of the vertices that make up the simplices in S.
SVI = Simplex Vertex Indices.  SVI[ ,k] gives the subscripts in the vertex array V that determine the k-th simplex in S
\item other fields are specific to the type of mesh.  Generally, they describe the parameters that 
were used to generate the mesh
}

\tabular{lccc}{
type                   \tab mvmesh.type     \tab m   \tab vps \cr
---------------------  \tab ------------- \tab ------ \tab ------ \cr
UnitSimplex           \tab 1              \tab n-1 \tab n    \cr
SolidSimplex          \tab 2              \tab n   \tab n+1  \cr
UnitSphere, edgewise  \tab 3              \tab n-1 \tab n    \cr
UnitSphere, dyadic    \tab 4              \tab n-1 \tab n    \cr
UnitBall, edgewise    \tab 5              \tab n   \tab n+1  \cr
UnitBall, dyadic      \tab 6              \tab n   \tab n+1  \cr
SolidRectangle        \tab 7              \tab n   \tab 2^n  \cr
Icosahedron           \tab 8              \tab 2   \tab 3    \cr
PolarSphere           \tab 9              \tab n-1 \tab 2^(n-1) \cr
PolarBall             \tab 10             \tab n   \tab 2^(n-1) + 1 \cr
HollowTube            \tab 11             \tab n-1 \tab 2*(n-1) \cr
SolidTube             \tab 12             \tab n   \tab 2*n \cr
HollowRectangle       \tab 13             \tab n   \tab 2^(n-1)  \cr
}                                        

There are two generic S3 methods for objects of class mvmesh: print and plot.  
They are basic.  The plot command only works for dimensions n=2 and n=3, is slow,
and has some limitations.  The main goal of this package is to provide grids/meshes in 
arbitrary dimensions, where plots are not possible.

This package represents points in n dimensional space as 
double precision numbers.  This is convenient, but has potential problems.
For example, determining whether points lie on a line or in a plane or on a sphere may
not be possible with floating point arithmetic because coordinates can't be
represented exactly.  The computational geometry package rcdd on CRAN
gives a way around this by using exact rational arithmetic.  Using rational arithemetic works
fine when points can be expressed as rational numbers, but not for points shifted by an irrational
number or on more general surfaces, e.g. (sqrt(2)/2,sqrt(2)/2) is on the unit circle, but
cannot be represented exactly as a rational number.  Since we want to work in more
situations, we use floating point numbers everywhere, accepting the fact that points may not
be represented exactly.  When the required package \code{rcdd} is loaded,
it prints out a warning message about double precision numbers and
encourages the use of rational arithmetic.  I do not know how to suppress this message.
That package warns that using doubles can lead to crashes in certain circumstances.
I don't know what circumstances cause crashes; I have not seen any in the kinds of 
computations done in this package.
}
\examples{
UnitSimplex( n=2, k=3 )
UnitBall( n=3, k= 2 )

\dontrun{

plot( SolidSimplex( n=2, k=3 ), col="red" )
title("2d solid simplex")

plot( SolidSimplex( n=3, k=4 ) )
plot(  UnitSimplex( n=3,k=4), new.plot=FALSE, col="red", lwd=5 )
title3d("solid and unit simplex in 3d")
rgl.viewpoint( -45, 15)

# two plots on one window
plot( UnitSphere( n=3, k=2 ), col="blue")
mesh2 <- AffineTransform( UnitBall( n=3,k=2 ), A=diag(c(1,1,1)), shift=c(3,0,0) )
plot( mesh2, new.plot=FALSE, col="magenta" )
title3d("unit sphere and ball in 3d")


demo(mvmesh) # shows a range of meshes
demo(mvhist) # shows a range of multivariate histograms
}

}
