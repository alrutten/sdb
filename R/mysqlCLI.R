
mysqlCLI <- function(query, host = "scidb.mpio.orn.mpg.de", args = paste0("--defaults-file=", shQuote(credentialsPath(host))) ) {
  mysql = paste("mysql", args)
  temp  = tempfile()
  on.exit(file.remove(temp))
  
  strg  = paste(mysql, "-e", 
               shQuote(paste(query, collapse = ";") ), 
               " > ", shQuote(temp) )

  system(strg)

  res = try(read.table(temp, header = TRUE, stringsAsFactors = FALSE), silent = TRUE)
  if( inherits(res, 'try-error')) res = NULL
  return(res)
  
  
  
}

