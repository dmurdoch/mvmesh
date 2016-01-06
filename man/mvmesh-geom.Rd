\name{mvmesh-geom}
\alias{Icosahedron}
\alias{AffineTransform}
\alias{Rotate2D}
\alias{Rotate3D}
\alias{MatchRow}
\alias{H2Vrep}
\alias{V2Hrep}
\alias{SatisfyHrep}
\alias{HrepCones}
\alias{EdgeSubdivision}
\alias{EdgeSubdivisionMulti}
\alias{ConvertBase}
\alias{NumVertices}
\alias{PointCoord}
\alias{SimplexCoord}
\alias{SVIFromColor}
\alias{IntersectMultipleSimplicesV}
\alias{IntersectMultipleSimplicesH}
\alias{Intersect2SimplicesH}
\alias{Lift2UnitSimplex}
%\alias{TransposeMultipleMatrices}

\title{Miscellaneous computational geometry and utility functions
}
\description{\code{EdgeSubdivision} calculates an equal area/volume subdivision of a simplex.
\code{AffineTransform} defines a new mesh by translating all points x to x' = A %*% x + shift.
\code{Rotate2D} and \code{Rotate3D} calculate rotation matrices for use by \code{AffineTransform}.

\code{Icosahedron} returns the vertices of an icosahedron with vertices on the unit sphere

Other functions are internal functions, use at your own risk.
}
\usage{
EdgeSubdivision( n, k )
EdgeSubdivisionMulti( V, SVI, k, normalize = FALSE, p = 2)
ConvertBase( m, b, n)
NumVertices( n, k, single = TRUE)
PointCoord( S, color )
SimplexCoord( S, color )
SVIFromColor( S, T )

MatchRow(v, table, first = 1, last = nrow(table))
AffineTransform( mesh, A, shift ) 
Rotate2D( theta )
Rotate3D( theta )
Icosahedron( )

V2Hrep( S ) 
H2Vrep( H ) 
SatisfyHrep( x, Hsingle )
HrepCones( S )
IntersectMultipleSimplicesV( S1, S2 )
IntersectMultipleSimplicesH( H1, H2 )
Intersect2SimplicesH( H1, H2, tesselate=FALSE )
Lift2UnitSimplex(S)
%TransposeMultipleMatrices(B)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{v}{a vector of length n
}
  \item{table}{matrix of size m3 x n
}
  \item{first}{row to start search
}
  \item{last}{row to end search
}
  \item{mesh}{object of class "mvmesh"
}
  \item{A}{n x n matrix
}
  \item{shift}{shift vector of length n 
}
  \item{theta}{rotation angle; in 2D, this is a single angle; in 3D is it a vector of length 3,
  with theta[i] giving rotation around i-th axis
}
  \item{\dots}{optional parameters to rgl plot commands
}
  \item{k}{number of subdivisions
}
  \item{n}{dimension of simplex
}
  \item{V}{matrix of vertices; each row is a point in R^n
}
  \item{normalize}{TRUE to normalize vertices to lie on the unit sphere in the l^p norm
}
  \item{p}{power in the l^p norm
}
  \item{S,S1,S2}{matrix of size (vps x n) specifying the vertices of a single simplex; S[j,] is the j-th vertex of S
}
  \item{SVI}{Simplex Vertex Indices, see \code{\link{mvmesh}}
}
  \item{m}{positive integer to be converted to base 'b'
}
  \item{b}{positive integer, the base used to expess 'x'
}
  \item{single}{If TRUE, return only one value; if FALSE, return table of values
}
  \item{color}{color matrix, internal matrix used by \code{EdgeSubdivision} to subdivide a simplex
}
  \item{T}{array giving a list of color matrices
}
  \item{H,H1,H2}{array of simplices in the H-representation, H[,,k] is the H-representation for the k-th simplex
}
  \item{x}{matrix with columns giving the points
}
  \item{Hsingle}{matrix giving the H-representation of a single simplex
}
  \item{tesselate}{TRUE to tesselate the resulting intersection
}
% \item{B}{an (m x n x p) array}
}
\details{\code{AffineTransform} computes a new mesh from a previous one, with each vertex v being replaced
by A %*% v + shift. \code{Rotate2D} computes a 2D rotation matrix, 
\code{Rotate3D} computes a 3D rotation matrix.

\code{Icosahedron} returns the vertices of the icosahedron with vertices on the
unit sphere

\code{H2Vrep} converts from the half-space (H) representation to the vertex (V) representation
of a simplex.  \code{V2Hrep} converts from the V-representation to the H-representation.
It is assumed that all the resulting value are of the same dimension.  If this is not the case,
an error will occur.  To work with such cases, call the function separately for each simplex and save the result in 
different size objects. The one place where this can occur with mvmesh objects is with a
PolarSphere or PolarBall: at the places where polar coordinates are nonunique, vertices
will repeat and the H-representation will have fewer constraints than other simplices.

\code{IntersectMultipleSimplicesV} computes the pairwise intersection of two lists of simplices given in the V-representation.
\code{IntersectMultipleSimplicesH} computes the pairwise intersection of two lists of simplices given in the H-representation.
\code{Intersect2SimplicesH} computes the intersection of two simplices, both specified in the H-representation.

\code{Lift2UnitSimplex} reverses the projection from the unit simplex in n-space to the first (n-1) coordinates.  That is,
it 'lifts' each  (n-1) dimensional simplex in R^(n-1) to the unit simplex in R^n by appending an n-th coordinate, with x[n] <- 1-sum(x[1:(n-1)]).

%\code{TransposeMultipleMatrices} computes an array C of size (n x m x p), with C[,,i]=t(B[,,i]). 
}

\value{\code{MatchRow} returns an integer vector, showing which rows of table match v.
If there are no matches, it returns integer(0).

\code{AffineTransform} returns an object of class "mvmesh". 
\code{Rotate2D} returns a 2 x 2 rotation matrix, 
\code{Rotate3D} returns a 3 x 3 rotation matrix.

\code{EdgeSubdivision} computes an edgewise subdivision of a simplex using the method of 
Edelsbrunner and Grayson. The algorithm of Concalves, et. al. was implemented in R.  It is a coordinate free
method. \code{ConvertBase} is an internal routine used by the subdivision algorithm.
\code{NumVertices} is a utility routine to recursively 
calculate the number of vertices in an edgewise subdivision.

\code{EdgeSubdivMulti} is roughly a vectorized version of \code{EdgeSubdivison}. It takes a list
of simplices, and performs a k-subdivision of each simplex for function \code{UnitSphere} and
related functions.  Since some simplices may share edges, the
same vertex can be occur multiple times, so this function goes through the resulting 
vertices and eliminates repeats.  This function is not meant to be called by an end user; it is not 
guaranteed to be general. 

\code{ConvertBase} is an internal function that converts a positve integer 'x' to an 'n' digit base 'b' representation.
\code{NumVertices} is an internal function that computes the number of simplices in an 
edgewise subdivision (without doing the subdivision).
\code{PointCoord} is an internal function that computes a single vertex of a simplex.  
\code{SimplexCoord} is an internal function that computes the coordinates of a simplex 'S' given color matrix 'color'.
\code{SVIFromColor} is an internal function that computes the SVI from a starting simplex 'S' and color array 'T'.

Note that rays and lines are not allowed in \code{V2Hrep}; use rcdd funtion \code{makeH} directly to use them.

\code{EdgeSubdivision} returns a color matrix, a coordinate free representaion of the subdivision.
One generally uses \code{UnitSimplex} or \code{UnitBall} to get a vertex representation of the subdivision.

\code{EdgeSubdivMulti} returns a list of class 'mvmesh'
}

\references{
Edelsbrunner and Grayson, Discrete Comput. Geom., Vol 24, 707-719 (2000).

Goncalves, Palhares, Takahashi, and Mesquita, Algorithm 860: SimpleS -- 
an extension of Freudenthal's simplex subdivision, ACM Trans. Math. Softw., 
32, 609-621 (2006).
}
\examples{
Icosahedron( )

T <- EdgeSubdivision( n=2, k=2 )
T

ConvertBase( 10, 2, 6 )  # note order of digits

NumVertices( n=4, k=8, single=FALSE )

S <- rbind( diag(rep(1,2)), c(0,0) ) # solid simplex in 2D
PointCoord( S, T[,,1] )

SimplexCoord( S, T[,,1] )

SVIFromColor( S, T )

S1 <- rbind( c(0,0,0), diag( rep(1,3) ) )
S2 <- rbind( c(1,1,1), diag( rep(1,3) ) )
S3 <- rbind( c(1,1,1), c(0,1,0), c(1,0,0), c(1,1,0) )
S <- array( c(S1,S2,S3), dim=c(4,3,3) )

( H1 <- V2Hrep( S ) )
( S4 <- H2Vrep( H1 ) )

( H2 <- HrepCones( UnitSphere(n=2,k=1)$S )[,,2] )  # cone between 0 <= y <= x, x >= 0
x <- matrix( rnorm(100), ncol=2 )
( i <- SatisfyHrep( x, H2 ) )
x[i,]

(table <- matrix( c(1:12,1:3 ), ncol=3, byrow=TRUE ))
MatchRow( 1:3, table )

\dontrun{
plot( Icosahedron( ), col="green" )

mesh <- SolidSimplex( n=3, k=2 )
plot(mesh, col="blue")
mesh2 <- AffineTransform( mesh, A=Rotate3D( rep(pi/2,3) ), shift=c(1,1,1) ) 
plot(mesh2, new.plot=FALSE, col="red" )


}
}

