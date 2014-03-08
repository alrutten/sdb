

# https://github.com/andialbrecht/sqlparse/
# ???? pip install sqlparse

sqlFormat <-function(x ){
  require(rPython)
  
  
}


snipSave <- function(query, description='', host = "scidb.mpio.orn.mpg.de") {

  if(!credentialsExist(host)) stop("Pls. save your credentials first.\nRun: saveCredentials(user = '', password = '', database = '') " )
	eval(parse(text = readLines(credentialsPath(host))[-1]))	


	v = paste("INSERT INTO DBLOG.snippets (query, author, description) VALUES(",
			paste(shQuote(query),shQuote(user), shQuote(description), sep = ",")   ,");")

	dbq(q = v, native = TRUE)

	res = dbq(q = 'SELECT max(ID) id from DBLOG.snippets')

	cat("snippet ID: ", res$id)
	
	

}

