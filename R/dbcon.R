

dbcon <- function(user, password, database, host = "scidb.mpio.orn.mpg.de", path) {

  OS = Sys.info()["sysname"]
  
	if(missing(path) & missing(user) ) path = credentialsPath(host)  
	
	if(missing(user) && file.exists(path))
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
    con = odbcConnect(host, uid = user, pwd = password, case = "nochange") 
    if( !missing(database) )
      sqlQuery(con, paste("USE", database))
  }
  
  return(con)
	
 } 


closeCon <- function(con) {
  if(Sys.info()["sysname"] == "Linux") dbDisconnect(con) else close(con)
  }






  
  



 
 