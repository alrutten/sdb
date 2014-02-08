

dbq <- function(query, con) {

	if(missing(con)) {
  	con = dbcon()
  	on.exit(closeCon(con))
  	}
		
	if(missing(query)) query = "SELECT 'You did not write any query!'"

  
	if(Sys.info()["sysname"] == "Linux") {
	  q = dbSendQuery(con, query)
    res = fetch(q, n = -1)
	} 
  
	if(Sys.info()["sysname"] == "Windows") {
  	res = sqlQuery(con, query,error = TRUE)
    }
  
  return(res)

	
}















 
 