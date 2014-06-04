#' (connect to and) query the database
#' 
#' connect to and query the database in one fell swoop
#' 
#' this function either queries the database using a specified connection, or, when no connection is specified, uses the information stored using \code{\link{saveCredentials}} to open a connection (which is closed after executing the query)
#' @param con an active MySQL or RODBC database connection
#' @param q a querystring
#' @seealso \code{\link{saveCredentials}},\code{\link{dbcon}}
#' @return returns the result of running query q.
#' @author AR 2014-05-12
setGeneric("dbq", function(con,q, ...)   standardGeneric("dbq") )


setMethod("dbq",  
          signature  = c(con = "RODBC", q = "character"), 
          definition = function(con, q, ...) {
			# cat("--> DB query via ODBC\n")
			sqlQuery(con, q,error = TRUE, as.is=TRUE, ... )
          }
)

setMethod("dbq",  
          signature  = c(con = "MySQLConnection", q = "character"), 
          definition = function(con, q, ...) {
		  # cat("--> DB query via DBI\n")
			#qstr = dbSendQuery(con, q, ...)
			#fetch(qstr, n = -1)
			dbGetQuery(con, q, ...)
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




















 
 
