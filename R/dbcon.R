#' connect to a database
#' 
#' connects to a database
#' 
#'
#'  
#' this functions returns a database connection. If user & password remain unspecified, it looks for credentials saved by running \code{\link{saveCredentials}}. Under Linux, the RMySQL package is used to establish the connection; under Windows, RODBC is used.
#' If database is specified but username and password are not, the database argument in the call to dbcon() is used.
#' @param user username
#' @param password password
#' @param database database to connect to
#' @param path to credentialsfile (if different from the default \code{\link{credentialsPath}}
#' @return a connection object
#' @seealso \code{\link{saveCredentials}}, \code{\link{dbq}}
#' #' @author AR 2014-05-12
dbcon <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", path) {

  # figure out credentials
  if( missing(user) & !credentialsExist(host) & missing(path) ) 
	stop("Run ", dQuote("saveCredentials()"), " first, enter your user name & password or add a path to a credentials file")

   if(missing(user) ) {
		if(missing(path)) p = credentialsPath(host) else p = path
    text = readLines(p)[-1]
		if (!missing(database)) text = text[-4]
    eval(parse(text = text))
	}
	
  #run query
  OS = Sys.info()["sysname"]
  
  if(OS == "Linux"){
    require(RMySQL) 
    con = dbConnect(dbDriver("MySQL"), username = user, password = password, host = host)
   # if( !missing(database) )
      mysqlQuickSQL(con, paste("USE", database))
  }
  
  if(OS == "Windows") {
    require(RODBC)
    
    drv = utils::readRegistry("SOFTWARE\\ODBC\\ODBCINST.INI",   hive="HLM", maxdepth=1)
    
    if( length (drv) == 0) 
      stop('Please download and install the latest MySQL ODBC connector from https://dev.mysql.com/downloads/connector/odbc/')
        
    drv = grep("MySQL",  names(drv), value = TRUE)
    drv = sort(drv, decreasing = TRUE)[1]
    
    conStr=paste0("SERVER=",host,";DRIVER=",drv,";UID=",user,";PWD=",password,";case=nochange;option=268435456")
    
    con = odbcDriverConnect(connection=conStr) 
  
    if( !missing(database) )
      sqlQuery(con, paste("USE", database))
  }
  
  return(con)
	
 } 


closeCon <- function(con) {
  if(Sys.info()["sysname"] == "Linux") dbDisconnect(con) else close(con)
  }




  
  



 
 
