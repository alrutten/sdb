#' query the database
#'
#' query the database using an user-defined connection or a temp connection based on saved credentials.
#'
#' run an SQL query.
#' @param con a connection object returned by \code{\link{dbcon}}
#' @param q a query string. credentials are storred on disk.
#' @seealso \code{\link{saveCredentials}},\code{\link{dbcon}}
#' @return a data.frame for a SELECT query or otherwise NULL.

setGeneric("dbq", function(con,q, ...)   standardGeneric("dbq") )


setMethod("dbq",
          signature  = c(con = "RODBC", q = "character"),
          definition = function(con, q, ...) {
			sqlQuery(con, q,error = TRUE, as.is=TRUE, ... )
          }
	)

setMethod("dbq",
          signature  = c(con = "MySQLConnection", q = "character"),
          definition = function(con, q, ...) {
			dbGetQuery(con, q, ...)
           }
	)

setMethod("dbq",
          signature  = c(con = "missing", q = "character"),
          definition = function(q, ...) {
			con = dbcon(...)
			on.exit(closeCon(con))
			return(dbq(con, q)	)
		  }
	)






















