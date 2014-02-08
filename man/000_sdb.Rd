
\name{sdb}
\alias{sdb}
\docType{package}

\title{sdb: an R-mysql interface}
\description{ 
	\pkg{sdb} This is a meta-package on top of RMySQL (easy to install on Linux)
   and RODBC (easy to install on Windows)
   The packge has host = "scidb.mpio.orn.mpg.de" as default argument for some functions
   but host is not hardwired. 
	}

\keyword{package}

\author{
	Mihai Valcu \email{valcu@orn.mpg.de} }

\seealso{
\code{\link[sdb]{dbcon}}.
}


\examples{
\dontrun{ 
# "generic" connection: no database chosen
con = dbcon(user = "test", password = "test")
dbq( "select * from test.table1", con)

# connection to the "test" database
con = dbcon(user = "test", password = "test", database = "test")
dbq("select * from table1", con)

# You can save your settings locally on disk. 
# save a default database as well
saveCredentials(user = 'test', password = 'test', database = 'test')

#... then  you can run dbq without an explicit connection.
dbq("select * from table1")


}

}
 
 







