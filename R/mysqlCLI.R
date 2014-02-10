
mysqlCLI <- function(query, host, args = paste0("--defaults-file=",credentialsPath(host)) ) {
  mysql = paste("mysql", args)
  temp  = tempfile()
  
  strg  = paste(mysql, "-e", 
               shQuote(paste(query, collapse = ";") ), 
               " >", temp)

  system(strg)

  return(read.table(temp, header = TRUE, stringsAsFactors = FALSE))
  
  file.remove(temp)
  
}

# qstr = c("SET @v1 = 1","SET @v2 = 'a'", "SELECT * FROM table1 where Column1 = @v1 and Column2 = @v2")
# mysqlCLI(qstr)
