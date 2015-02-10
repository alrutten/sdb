

#' dumps tables on localhost
#'
#' my_remote2local uses mysql CLI and mysqldump to copy tables from remote to localhost
#'
#' @return NULL
#' @param tables   tables are given as a "tableName1 tableName2".
#' @note non-table objects (views, procedures, etc) are exported by default.
#' @aliases my_remote2local
#' @examples my_remote2local("dbnam", "table", 'user')



my_remote2local <- function(db, tables, remoteUser, remoteHost = 'scidb.orn.mpg.de', localUser = 'root') {

	localhost = .getCredentials(localUser, 'localhost')
	remote = .getCredentials(remoteUser, remoteHost)

	ini = paste0('mysql --host=localhost --user=', localhost$user ,
					  ' --password=', localhost$pwd ,' -e ',
			shQuote(paste('CREATE DATABASE IF NOT EXISTS', db ) ) )
	system(ini)


	mysqldump = paste0('mysqldump --host=',      remote$host,
								' --user=' ,     remote$user,
								' --password=' , remote$pwd,
								' --databases ',  db,
	if(!missing(tables))   paste(' --tables ',     paste(tables, collapse = " ") ) else NULL ,
								' --routines',
								' --verbose')

	mysql = paste0('mysql --host=localhost --user=', localhost$user ,' --password=', localhost$pwd ,' --database=', db, ' --max_allowed_packet=1GB ')

	call = paste(mysqldump, mysql, sep = "|")
	# cat(call)
	system( call )

	}



