Using snippets
==============

#### Saving an arbitrary query to DBLOG.snippets with snipSave().

`snipSave()` has a [format](https://github.com/andialbrecht/sqlparse/) argument (default `TRUE`) which allows formating of messy querries. 
`snipSave()` requires to save your credentials with `saveCredentials()`.


```r
require(sdb)
```

```
## Loading required package: sdb
## This is sdb 0.0.4
```

```r
dbq(q = "select 1")
```

```
## Loading required package: RMySQL
## Loading required package: DBI
```

```
##   1
## 1 1
```




```r
snipSave("SelecT SPECIFIC_NAME,ROUTINE_SCHEMA FROm information_schema.ROUTINES ")
```

```
## Loading required package: rPython
## Loading required package: RJSONIO
```

```
## Saving snippet  SELECT SPECIFIC_NAME, ROUTINE_SCHEMA FROM i... by mihai as  ID:  1
```


#### Clonning a snippet simply makes a copy of that snippet and replaces the author with your name.

```r
snipClone(1)
snipDrop(2)
```


#### Saving a bunch of queries from a file with snipLoadFromFile().

```r
snipLoadFromFile("~/__queries.sql")
```

```
## Saving snippet  SELECT TIME(t), TIME_TO_SEC(t), 2* P... by mihai as  ID:  2 
## Saving snippet  SELECT f.box, gap_x, laying_gap FROM... by mihai as  ID:  3 
## Saving snippet  SELECT radioFr, FUNCTIONS.combo(c.ll, c.lr,... by mihai as  ID:  4 
## Saving snippet  SELECT ROUND_DATE(datetime_, 5) datetime_, ... by mihai as  ID:  5
```

```r
snipLoadFromFile("~/__queries_noformat.sql", sep = ";;;", format = FALSE)
```

```
## Saving snippet  SELECT CONCAT_WS('_', CONCAT(UCASE(SUBSTRING(SUBST... by mihai as  ID:  6 
## Saving snippet  SET @species = buteo buteo ; select distinct x.ID... by mihai as  ID:  7
```




#### Searching by keyword and/or author.

```r
s = snipSearch("date")
```

```
##   ID                                       query author description
## 1  3        SELECT f.box, gap_x, laying_gap FROM  mihai            
## 2  4 SELECT radioFr, FUNCTIONS.combo(c.ll, c.lr,  mihai            
## 3  5 SELECT ROUND_DATE(datetime_, 5) datetime_,   mihai
```


#### Fetching a snippet by ID.

```r
s1 = snipFetch(1)
```

```
## SELECT SPECIFIC_NAME,
##        ROUTINE_SCHEMA
## FROM information_schema.ROUTINES
```

```r

dbq(q = s1)
```

```
##   SPECIFIC_NAME ROUTINE_SCHEMA
## 1         combo      FUNCTIONS
## 2     RoundTime      FUNCTIONS
## 3   secs_to_rad      FUNCTIONS
## 4         combo          mysql
## 5     RoundTime          mysql
## 6   secs_to_rad          mysql
```







