

credentialsPath <- function(host) {
  lp = file.access(.libPaths() , 2)
  dir = paste(names(lp[lp == 0][1]), "sdb_conf", sep = .Platform$file.sep)
  if(!file.exists(dir)) dir.create(dir)
  paste(dir, paste0("cnf_", host, ".txt"), sep = .Platform$file.sep)
}

#' manage database credentials
#'
#' manage database credentials for easier database access
#'
#' saveCredentials saves the specified credentials to a file in your library, unless you specify a custom path. This information can be used by \code{\link{dbcon}} and \code{\link{dbq}} to connect to and query the database.
#' Currently, you can store credentials for different hosts (e.g., scidb and scicomp), but not for different users within a host.
#' removeCredentials removes the credentialsfile for the specified host
#' credentialsExist checks if there is a credentialfile for the specified host.
#' @return credentialsExist,removeCredentials, and saveCredentials all return TRUE if successful; credentialsPath returns the filename of the credentialsfile.
#' @aliases credentialsPath credentialsExist removeCredentials
#' @seealso \code{\link{dbcon}},\code{\link{dbq}}
#' @author AR 2014-05-12

saveCredentials <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", path = credentialsPath(host)) {

  # as well for mysql --defaults-file="/path/to/credentials.txt"
  cat('[client]\n',
      'host=', shQuote(host), '\n',
      'user=', shQuote(user),'\n',
      'password=', shQuote(password),'\n',
      'database=', shQuote(database),'\n',
      file = path, sep = "")
  Sys.chmod(path)
  if(file.info(path)$size > 1) return(TRUE)
}


removeCredentials <-function(host = "scidb.mpio.orn.mpg.de") {
	if (credentialsExist(host)) file.remove(credentialsPath(host))
	}

credentialsExist <-function(host = "scidb.mpio.orn.mpg.de") {
	file.exists(credentialsPath(host))
	}

