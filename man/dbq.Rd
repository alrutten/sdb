\name{dbq}
\alias{dbq}
\title{(connect to and) query the database}
\usage{
dbq(con, q, ...)
}
\arguments{
  \item{con}{an active MySQL or RODBC database connection}

  \item{q}{a querystring}
}
\value{
returns the result of running query q.
}
\description{
connect to and query the database in one fell swoop
}
\details{
this function either queries the database using a specified
connection, or, when no connection is specified, uses the
information stored using \code{\link{saveCredentials}} to
open a connection (which is closed after executing the
query)
}
\author{
AR 2014-05-12
}
\seealso{
\code{\link{saveCredentials}},\code{\link{dbcon}}
}

