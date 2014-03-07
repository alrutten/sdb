



dbcon <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", path) {

  # figure out credentials
  if( missing(user) & !credentialsExist(host) & missing(path) ) 
	stop("Run ", dQuote("saveCredentials()"), " first, enter your user name & password or add a path to a credentials file")

   if(missing(user) ) {
		if(missing(path)) p = credentialsPath(host) else p = path
		eval(parse(text = readLines(p)[-1]))
	}
	
  #run query
  OS = Sys.info()["sysname"]
  
  if(OS == "Linux"){
    require(RMySQL) 
    con = dbConnect(dbDriver("MySQL"), username = user, password = password, host = host)
    if( !missing(database) )
      mysqlQuickSQL(con, paste("USE", database))
  }
  
  if(OS == "Windows") {
    require(RODBC)
    con = odbcConnect(host, uid = user, pwd = password, case = "nochange") 
    if( !missing(database) )
      sqlQuery(con, paste("USE", database))
  }
  
  return(con)
	
 } 


closeCon <- function(con) {
  if(Sys.info()["sysname"] == "Linux") dbDisconnect(con) else close(con)
  }






  
  



 
 