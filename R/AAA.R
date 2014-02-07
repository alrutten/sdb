
x <- function() {
  if( ! OS %in% c("Linux", "Windows")) stop(OS, "not supported.")
  
  # shell("%windir%/system32/odbcad32.exe")
  # http://dev.mysql.com/downloads/connector/odbc/#downloads
  # http://dev.mysql.com/doc/connector-odbc/en/connector-odbc-configuration-dsn-windows.html  
  }