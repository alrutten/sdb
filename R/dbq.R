setGeneric("dbq", function(con,q, ...)   standardGeneric("dbq") )


setMethod("dbq",  
          signature  = c(con = "RODBC", q = "character"), 
          definition = function(con, q, ...) {
			# cat("--> DB query via ODBC\n")
			sqlQuery(con, q,error = TRUE, ... )
          }
)

setMethod("dbq",  
          signature  = c(con = "MySQLConnection", q = "character"), 
          definition = function(con, q, ...) {
		  # cat("--> DB query via DBI\n")
			qstr = dbSendQuery(con, q, ...)
			fetch(qstr, n = -1)
           }
)

setMethod("dbq",  
          signature  = c(con = "missing", q = "character"), 
          definition = function(q, native = FALSE, ...) {
			if(!native) {
				con = dbcon()
				on.exit(closeCon(con))
				return(dbq(con, q)	)
				}
			if(native) {
			# cat("--> DB query via native mysql CLI\n")
				return(mysqlCLI(q))
			}	

		  }
)




















 
 