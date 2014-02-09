
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
	
	if(file.info(path)$size > 1) return(TRUE)
}


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


closeCon <- function(con) {
  if(Sys.info()["sysname"] == "Linux") dbDisconnect(con) else close(con)
  }


# query = c("SET @v1 = 1","SET @v2 = 'a'", "SELECT * FROM table1 where Column1 = @v1 and Column2 = @v2")


mysqlCLI = function("query", host = "scidb.mpio.orn.mpg.de", outfileDir = "/srv/www/htdocs/temp") {
  creds = credentialsPath(host)
  mysql = paste0("mysql --defaults-file=", creds )
  temp = paste(outfileDir, basename(tempfile(fileext=".txt")) , sep = .Platform$file.sep)
  
  strg = paste(mysql, "-e", 
               shQuote((paste(
                paste(query, collapse = ";"), 
                  "INTO OUTFILE", shQuote(temp, type = "sh"), ";")))
               )
  
  # todo: select into a file on /srv ----> then wget
  
  system(strg)
  
  read.table( paste("http:/",host, basename(dirname(temp)) , basename(temp), sep = "/" ) )

  
  }




  
  



 
 