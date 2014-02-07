
\name{sdb}
\alias{sdb}
\docType{package}

\title{sdb: a db interface to scidb.mpio.orn.mpg.de}
\description{ 
	\pkg{sdb} a db interface to scidb.mpio.orn.mpg.de
	}

\keyword{package}

\author{
	Mihai Valcu \email{valcu@orn.mpg.de} }

\seealso{
\code{\link[sdb]{dbcon}}.
}


\examples{
\dontrun{ 
con = dbcon("test", "test")
dbq( "USE test", con)
dbq( "select * from table1", con)

# Once you save your settings locally you can run dbq without an explicit connection.
saveCredentials(user = 'test', password = 'test', dbname = 'test')

dbq("select * from table1")




}

}
 
 







