#' @title credentialsPath
#' @name credentialsPath
#' @description path to credentials directory & file
#' @examples # credentialsPath("scidb.mpio.orn.mpg.de")
credentialsPath <- function(host) {
	lp = file.access(.libPaths() , 2)
	dir = paste(names(lp[lp == 0][1]), "sdb_conf", sep = .Platform$file.sep)
	if(!file.exists(dir)) dir.create(dir)
	paste(dir, paste0("cnf_", host, ".txt"), sep = .Platform$file.sep)
	}
	
#' @title saveCredentials
#' @name saveCredentials
#' @description Saves user name and password locally
#' @examples saveCredentials(user = 'test', password = 'test')
saveCredentials <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", 
                            path = credentialsPath(host)) {
	
	# as well for mysql --defaults-file="/path/to/credentials.txt"
	cat('[client]\n', 
		'host=', shQuote(host), '\n', 
		'user=', shQuote(user),'\n', 
		'password=', shQuote(password),'\n', 
		'database=', shQuote(database),'\n', 
	 file = path, sep = "")
	
	if(file.info(path)$size > 1) return(TRUE)
}


#' @title connect to db
#' @name dbcon
#' @description connect to one of the scidb.mpio.orn.mpg.de databases 
#' @seealso \code{\link{saveCredentials}}
#' @examples 
#' con = dbcon(user = 'test', password = 'test')
#' con = dbcon("test", 'test', 'test')
#' # Once credentials are saved with saveCredentials(). 
#' con = dbcon()
#' con = dbcon('FIELD_BTatWESTERHOLZ') 

dbcon <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", path) {

  OS = Sys.info()["sysname"]
  
	if(missing(path)) path = credentialsPath(host)  
	
	if(file.exists(path))
		eval(parse(text = readLines(path)[-1]))
 
  if(missing(path) && missing(user)) stop("Run", dQuote(" saveCredentials() "), "first or give an user & pwd")
    
  
  if(OS == "Linux"){
    require(RMySQL) 
    con = dbConnect(dbDriver("MySQL"), username = user, password = password, host = host)
    if( !missing(database) )
      mysqlQuickSQL(con, paste("USE", database))
  }
  
  if(OS == "Windows") {
    require(RODBC)
    con = odbcConnect(host, uid = user, pwd = password) 
    
    if( !missing(database) )
      sqlQuery(con, paste("USE", database))
  }
  
  return(con)
	
 } 


#' @title close connection
#' @name closeCon
#' @description close db connection
closeCon <- function(con) {
  if(Sys.info()["sysname"] == "Linux") dbDisconnect(con) else close(con)
  }







 
 