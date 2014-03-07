

credentialsPath <- function(host) {
  lp = file.access(.libPaths() , 2)
  dir = paste(names(lp[lp == 0][1]), "sdb_conf", sep = .Platform$file.sep)
  if(!file.exists(dir)) dir.create(dir)
  paste(dir, paste0("cnf_", host, ".txt"), sep = .Platform$file.sep)
}


saveCredentials <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", 
                            path = credentialsPath(host)) {
  
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
	file.remove(credentialsPath(host))
	}

credentialsExist <-function(host = "scidb.mpio.orn.mpg.de") {
	file.exists(credentialsPath(host))
	}

