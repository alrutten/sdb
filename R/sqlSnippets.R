

headQuery <- function(z, nchar = 50) {
	gsub("^\\s+", "", gsub("\\s+", " ", gsub("\n", " ", substring(z, 1, nchar)), perl = TRUE), perl = TRUE )
	}

snipSave <- function(query, description='', format = TRUE, host = "scidb.mpio.orn.mpg.de") {

  if(!credentialsExist(host)) stop("Pls. save your credentials first.\nRun: saveCredentials(user = '', password = '', database = '') " )
	eval(parse(text = readLines(credentialsPath(host))[-1]))


	cat("\n--> Saving snippet ", paste0( headQuery(query)  , "... by ", user) )
	v = paste("INSERT INTO DBLOG.snippets (query, author, description) VALUES(",
			paste(shQuote(query),shQuote(user), shQuote(description), sep = ",")   ,");")

	dbq(q = v, native = TRUE)

	res = dbq(q = 'SELECT max(ID) id from DBLOG.snippets')

	cat( paste(" as  ID: ", res[1,1]), "\n")

 }

snipLoadFromFile <- function(f, sep = ';', ...) {

	x = paste(scan(f, what = 'character',multi.line = FALSE), collapse = " ")
	x = strsplit(x, sep, fixed = TRUE)[[1]]

	for(i in 1:length(x)) {
		xi = x[[i]]
		snipSave(xi, ...)

		}



	}

snipFetch <- function(id, ...) {
	res = dbq(q = paste('SELECT query from DBLOG.snippets where ID = ', id) , ...)[1,1]
	return(invisible(res))
	}

snipDrop <- function(id) {
	dbq(q = paste('DELETE FROM DBLOG.snippets where ID = ', id, 'and author = ', dQuote(user) ) , native = TRUE)
	}

snipClone <-function(id) {

	snipSave( snipFetch(id))

	}

snipSearch <- function(kw, author, ...) {

	if(missing(kw) & missing(author) ) res = dbq(q = 'SELECT * from DBLOG.snippets')
	if(missing(kw) & !missing(author) ) res = dbq(q = paste0('SELECT * from DBLOG.snippets where author =', shQuote(author) ) )
	if(!missing(kw) & missing(author) ) res = dbq(q = paste0('SELECT * from DBLOG.snippets where query like "%', kw, '%"') )
	if(!missing(kw) & !missing(author) ) res = dbq(q = paste0('SELECT * from DBLOG.snippets where query like "%', kw, '%" and author =', shqQuote(author) ) )

	prt = res; prt$query = unlist(lapply(res$query, headQuery))

	print(prt)
	return(invisible(res))
	}



