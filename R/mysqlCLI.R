
mysqlCLI <- function(query, host = "scidb.mpio.orn.mpg.de", outfileDir = "/srv/www/htdocs/temp") {
  creds = credentialsPath(host)
  mysql = paste0("mysql --defaults-file=", creds )
  temp  = paste(outfileDir, basename(tempfile(fileext=".txt")) , sep = .Platform$file.sep)
  
  strg  = paste(mysql, "-e", 
               shQuote((paste(
                 paste(query, collapse = ";"), 
                 "INTO OUTFILE", shQuote(temp, type = "sh"), ";")))
  )
  
  
  system(strg)
  
  read.table( paste("http:/",host, basename(dirname(temp)) , basename(temp), sep = "/" ) )
  
# mysql> system rm /tmp/results.out
  
}

#qstr = c("SET @v1 = 1","SET @v2 = 'a'", "SELECT * FROM table1 where Column1 = @v1 and Column2 = @v2")
#mysqlCLI(qstr)
