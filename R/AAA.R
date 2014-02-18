

.onLoad <- function(libname, pkgname){
    packageStartupMessage(paste('This is', pkgname, dcf[, "Version"] ))
  if( ! Sys.info()["sysname"] %in% c("Linux", "Windows")) 
    packageStartupMessage("sdb might not work under", OS)
}