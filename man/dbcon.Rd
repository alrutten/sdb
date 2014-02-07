\name{dbcon}
\alias{dbcon}
\title{connect to db}
\usage{
dbcon(user, password, database, host = "scidb.mpio.orn.mpg.de", path)
}
\description{
connect to one of the scidb.mpio.orn.mpg.de databases
}
\examples{
con = dbcon(user = 'test', password = 'test')
con = dbcon("test", 'test', 'test')
# Once credentials are saved with saveCredentials().
con = dbcon()
con = dbcon('FIELD_BTatWESTERHOLZ')
}
\seealso{
\code{\link{saveCredentials}}
}

