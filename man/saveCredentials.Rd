\name{saveCredentials}
\alias{saveCredentials}
\title{saveCredentials}
\usage{
saveCredentials(user, password, database, host = "scidb.mpio.orn.mpg.de",
  path = credentialsPath(host))
}
\description{
Saves user name and password locally
}
\examples{
saveCredentials(user = 'test', password = 'test')
}

