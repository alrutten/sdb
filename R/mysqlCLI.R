
mysqlCLI <- function(query, host = "scidb.mpio.orn.mpg.de", args = paste0("--defaults-file=", shQuote(credentialsPath(host))) ) {
  mysql = paste("mysql", args)
  temp  = tempfile()
  on.exit(file.remove(temp))
  
  strg  = paste(mysql, "-e", 
               shQuote(paste(query, collapse = ";") ), 
               " > ", shQuote(temp) )

  system(strg)

  return(read.table(temp, header = TRUE, stringsAsFactors = FALSE))
  
  
  
}

