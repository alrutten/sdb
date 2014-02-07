

dbq <- function(query, con) {

	if(missing(con)) {
  	con = dbcon()
  	on.exit(closeCon(con))
  	}
		
	if(missing(query)) query = "SELECT 'You did not write any query!'"

  
	if(Sys.info()["sysname"] == "Linux") 
  	return(mysqlQuickSQL(con, query)) else {
  	  return(sqlQuery(con, query,error = TRUE))
      
  	}

	
}















 
 