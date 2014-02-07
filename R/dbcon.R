
# connect to one of the scidb. databases 

dbcon <- function (username , password, dbname, host = "scidb.mpio.orn.mpg.de") {
   
   if(missing(username)) username = readline("Username: ")
   if(missing(password)) password = readline("Password: ")
   
   if(missing(dbname)) 	 dbname = readline("Database name: ")
   
	
	dbConnect(dbDriver("MySQL"), username = username, password = password, dbname = dbname, host = host)
   




  
  } 














 
 