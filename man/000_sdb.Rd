
\name{sdb}
\alias{sdb}
\docType{package}

\title{sdb: an R-MySQL interface}
\description{ 
	\pkg{sdb} is a meta-package on top of RMySQL, RODBC and mysql CLI
	}
  
\note{

 \itemize{
	\item Under Windows \pkg{sdb} needs \pkg{RODBC} and the \href{https://dev.mysql.com/downloads/connector/odbc}{ODBC connector}
	In order to add and set a mysql-ODBC driver connection Run: 
	   \preformatted{ shell("\%SystemRoot\%\\system32\\odbcad32.exe") }

	   \item Under Linux \pkg{sdb} needs \pkg{RMySQL}.
	
	\item \pkg{sdb} has host = "scidb.mpio.orn.mpg.de" as default argument for several functions but host is not hard-wired. 
 
  }

 
}  

\keyword{package}

\author{
	Mihai Valcu \email{valcu@orn.mpg.de} }



\examples{
\dontrun{ 
# "Generic" connection; no database is chosen.
 con = dbcon(user = "test", password = "test")
 d = dbq(con, "select * from test.table1")
 d
# Connection to the "test" database.
 con = dbcon(user = "test", password = "test", database = "test")
 d = dbq(con, "select * from table1")
 d
# You can save your settings (and optionally, a default database) on disk. 
 saveCredentials(user = 'test', password = 'test', database = 'test')

# ... then  you can run dbq without an explicit connection.
 d = dbq(q = "select * from table1")
 d	

 # Using mysql native interface and a saved connection.
 #(for the moment only available for Linux).
qstr =c("SET @v1 = 1", 	
		"SET @v2 = 'a'", 
		"SELECT * FROM table1 
			WHERE Column1 = @v1 and Column2 = @v2")
			
 d = dbq(q = qstr, native = TRUE)
 d

 
 
 
}

}





























 
 







