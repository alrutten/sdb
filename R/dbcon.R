#' connect to a database
#'
#' connects to a database
#'
#'
#'
#' this functions returns a database connection. If user & password remain unspecified, it looks for credentials saved by running \code{\link{saveCredentials}}. Under Linux, the RMySQL package is used to establish the connection; under Windows, RODBC is used.
#' @param user username
#' @param password password
#' @param database database to connect to
#' @param path to credentials file (if different from the default)
#' @return a connection object
#' @seealso \code{\link{saveCredentials}}, \code{\link{dbq} }

dbcon <- function(user, password, database = NA, host = "scidb.mpio.orn.mpg.de", path ) {
  if(missing(path)) path = .credentialsPath()

  if(!missing(user) & !missing(password) )
    X = data.frame(user, password, database, host, stringsAsFactors=FALSE) else
    X = .getCredentials(user = user, host = host, path = path  )
  
    names(X) = c('user', 'password', 'database', 'host')
    
    if( nrow(X) == 0 ) stop( "User ", dQuote(user), " is not saved as an user of ", dQuote(database) )

  #run query
  OS = Sys.info()["sysname"]

  if(OS == "Linux"){
    require(RMySQL)
    con = dbConnect(dbDriver("MySQL"), username = X$user, password = X$password, host = X$host)

   }

  if(OS == "Windows") {
    require(RODBC)

    drv = utils::readRegistry("SOFTWARE\\ODBC\\ODBCINST.INI",   hive="HLM", maxdepth=1)

    if( length (drv) == 0)
      stop('Please download and install the latest MySQL ODBC connector from https://dev.mysql.com/downloads/connector/odbc/')

    drv = grep("MySQL",  names(drv), value = TRUE)
    drv = sort(drv, decreasing = TRUE)[1]

    conStr=paste0("SERVER=",X$host,";DRIVER=",drv,";UID=",X$user,";PWD=",X$password,";case=nochange;option=268435456")

    con = odbcDriverConnect(connection=conStr)

    }


    if( !is.na(database) )
      dbq(con, paste("USE", database))

    return(con)

  }


closeCon <- function(con) {
  if(Sys.info()["sysname"] == "Linux") dbDisconnect(con) else close(con)
  }











