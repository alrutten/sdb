

#' dumps tables on localhost
#'
#' my_remote2local uses mysql CLI and mysqldump to copy tables from remote to localhost
#'
#' @return NULL
#' @param tables   tables are given as a "tableName1 tableName2".
#' @note non-table objects (views, procedures, etc) are exported by default.
#' @aliases my_remote2local
#' @seealso \code{\link{getCredentials}},\code{\link{mysqlCLI}}


my_remote2local <- function(db, tables, pwdLocal, userLocal = 'root') {

	ini = paste0('mysql --host=localhost --user=', userLocal ,
					  ' --password=', pwdLocal ,' -e ',
			shQuote(paste('CREATE DATABASE IF NOT EXISTS', db ) ) )

	system(ini)

	x = getCredentials()

	mysqldump = paste0('mysqldump --host=',      x['host'],
								' --user=' ,     x['user'],
								' --password=' , x['password'],
								' --databases ',  db,
	if(!missing(tables))   paste(' --tables ',     paste(tables, collapse = " ") ) else NULL ,
								' --routines',
								' --verbose')

	mysql = paste0('mysql --host=localhost --user=', userLocal ,' --password=', pwdLocal ,' --database=', db, ' --max_allowed_packet=1GB ')

	call = paste(mysqldump, mysql, sep = "|")
	# cat(call)
	system( call )

	}




