

dbq <- function(query, con) {

	if(missing(con)) {
	con = dbcon()
	on.exit(dbDisconnect(con))
	}
		
	if(missing(query)) string = "SELECT 'You did not write any query!'"

	return(mysqlQuickSQL(con, query))

	
}















 
 