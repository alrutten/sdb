

scidbQuery <-  function (con, string) {

	if(missing(con)) dbcon()
	if(missing(string)) string = "SELECT 'ARE YOU JOKING?'"

	mysqlQuickSQL(con, string)

		 
	}















 
 