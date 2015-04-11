\name{mvmesh-package}
\alias{mvmesh}
\docType{package}
\title{Multivariate meshes and histograms in arbitrary dimensions}
\description{Define, manipulate and plot multivariate meshes/grids in n-dimensional 
Euclidean space. Multivariate histograms based on these meshes are provided.}
\details{
\tabular{ll}{
Package: \tab mvmesh\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2015-04-10\cr
License: \tab GPL (>= 3) \cr
}
A range of multivariate problems require looking at simplices, spheres, balls and rectangular grids 
in dimension n > 1.
Examples are multivariate stable distributions or multivariate extreme value distributions,
where a probability distribution is specified by a measure
on a sphere or simplex.  Also, simulation of generalized spherical laws involves a triangulation
of some surface.  Quadrature problems on a simplex or sphere require the ability to specify and
work with meshes, e.g. packages SphericalCubature and SimplicialCubature.
Another application of this is multivariate histograms.  For example, 
directional histograms tablulate the number of points in a
sequence of directions, see function \code{\link{histDirectional}}.

A key goal here is that the dimension n is not limited to 2 or 3, but in principle can
be arbitrary. Of course, as n increases compute times and required memory will increase 
quickly.  This package uses existing methods from computational geometry that work
in arbitrary dimension.  Several of these functions were written as prototypes, so
getting something to work was the immediate goal, speed was not.


In this documentation we will use the term grid to mean a collection of points,
usually approximately evenly spread on a solid or surface.  We will use the term mesh to mean both
the grid, and the grouping information that tells which points make up the
simplices that triangulate the region.

Please let me know if you find any mistakes.  I will try to fix bugs promptly.

Constructive comments for improvements are welcome;  
actually implementing any suggestions will be dependent on time constraints.


This research was supported by an agreement with Cornell University, Operations 
Research & Information Engineering, under contract W911NF-12-1-0385 from the Army 
Research Development and Engineering Command.


Version history: 
\itemize{
\item 1.0 (2015-03-01) original package
}


The remainder of this section describes some of the internal details of the package.
It is not needed for the average users.

Points in n-dimensional space are stored in row vectors as is customary in R. 
All simplices considered in this package are convex. 
A single convex simplex can be described/stored in two ways:
\itemize{
\item A vps x n matrix of (doubles) S; the rows S[1,], S[2, ], etc. are the vertices in R^n.  
The simplex is the convex hull of the vertices. Note: vps stands for 'vertices per simplex'.
\item An nV x n matrix of (doubles) vertices V with rows giving the
        points in R^n, and an integer vector of length vps called SVI (=Simplex Vertex Indices) 
        that specifies which vertices make up a simplex.  
}

Both of these descriptions have their uses, so the core functions in this package calculate
both.  Most geometric objects described be a list of simplices.  To store all the relevant
information needed, the basic functions in this package return an object of class mvmesh.  
An object of class mvmesh has the following fields, extending the definitions
above from a single simplex to a list of simplices:
\itemize{
\item type - a string describing the mesh, e.g. "unit simplex" (see table below)
\item mvmesh.type - an integer specifying the type of mesh (see table below)
\item n - dimension of the space
\item m - dimension of the mesh, e.g. the unit sphere in n=3 dimensions is an m=2 dimensional
   surface. (see table below)
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
type                   \tab mesh.type \tab m   \tab vps \cr
---------------------  \tab ------------- \tab ------ \tab ------ \cr
unit simplex           \tab 1         \tab n-1 \tab n    \cr
solid simplex          \tab 2         \tab n   \tab n+1  \cr
unit sphere, edgewise  \tab 3         \tab n-1 \tab n    \cr
unit sphere, dyadic    \tab 4         \tab n-1 \tab n    \cr
unit ball, edgewise    \tab 5         \tab n   \tab n+1  \cr
unit ball, dyadic      \tab 6         \tab n   \tab n+1  \cr
rectangular            \tab 7         \tab n   \tab 2^n  \cr
icosahedron            \tab 8         \tab 2   \tab 3    \cr
polar sphere           \tab 9        \tab n-1 \tab 2^(n-1) \cr
polar ball             \tab 10        \tab n   \tab 2^(n-1) + 1 \cr 
}

Currently two generic S3 methods work for objects of class mvmesh: print and plot.  

Notes: This package represents points in n dimensional space as 
double precision numbers.  This is convenient, but has potential problems.
For example, determining whether points lie on a line or in a plane may
not be possible with floating point arithmetic because coordinates can't be
represented exactly.  The computational geometry package rcdd on CRAN
gives a way around this by using exact rational arithmetic.  This works
fine for points on a linear space, but not for points on
the unit sphere: (sqrt(2)/2,sqrt(2)/2) is on the unit circle, but
cannot be represented exactly as a rational number.  So, we 
use floating point numbers everywhere.  When required package \code{rcdd} is loaded,
it prints out a warning message about double precision numbers and
encourages the use of rational arithmetic.  I do not know how to suppress this message.

}
\examples{
UnitSimplex( n=2, k=3 )
UnitBall( n=3, k= 2 )

\dontrun{

plot( SolidSimplex( n=2, k=3 ), col="red" )
title("2d solid simplex")

plot( SolidSimplex( n=3, k=4 ) )
plot(  UnitSimplex( n=3,k=4), new.plot=FALSE, col="red", lwd=5 )
title3d("unit simpex and solid simplex in 3d")
rgl.viewpoint( -45, 15)


plot( UnitSphere( n=3, k=2 ), col="blue")
mesh2 <- AffineTransform( UnitBall( n=3,k=2 ), A=diag(c(1,1,1)), shift=c(3,0,0) )
plot( mesh2, new.plot=FALSE, col="magenta" )
title3d("triangulation of unit sphere and ball in 3d")


demo(mvmesh) # shows a range of meshes
demo(mvhist) # shows a range of multivariate histograms
demo(mvmesh2) # miscellaneous examples
}

}
