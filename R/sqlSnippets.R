
sqlFormat <-function(x ){
  
  # https://github.com/andialbrecht/sqlparse/
  
	  if( require(rPython)  & !inherits(try(python.exec("import sqlparse"), silent = TRUE), "try-error") ){  
	x = gsub("\n", " ", x)
	python.exec("
	def pyf( sql ):
	  'sqlparse.format wrapper '
	  return sqlparse.format(sql, reindent=True, keyword_case='upper')
	  ")
	  x = python.call ("pyf", x)
	  } 
	return(x)


}


snipSave <- function(query, description='', format = TRUE, host = "scidb.mpio.orn.mpg.de") {

  if(!credentialsExist(host)) stop("Pls. save your credentials first.\nRun: saveCredentials(user = '', password = '', database = '') " )
	eval(parse(text = readLines(credentialsPath(host))[-1]))	

  if(format) query = sqlFormat(query)
  
	v = paste("INSERT INTO DBLOG.snippets (query, author, description) VALUES(",
			paste(shQuote(query),shQuote(user), shQuote(description), sep = ",")   ,");")

	dbq(q = v, native = TRUE)

	res = dbq(q = 'SELECT max(ID) id from DBLOG.snippets')

	cat("snippet ID: ", res$id)
	
	

}

snipLoadFromFile <-function(f) {
	
	x = paste(scan(f, what = 'character',multi.line = FALSE), collapse = " ")
	x = strsplit(x, ";", fixed = TRUE)[[1]]
	
	for(i in 1:length(x)) snipSave(x[[i]])
	
	
	
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	