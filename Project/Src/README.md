# Project
- Multiform (statist and operator) application fo Postgre-db.
                   
![](postgresql-relational-database.png) 

# Features  
- Connect application to PostgreSQL server.
- Select, search and edit data with stored procedures.
- Each form have separate connection to DB from connection-pool.

## Files

| File | Contents | 
| --- | --- |
| Components\CgyDtPicker.pas | TDateTimePicker modified components |
| Frames\Search.pas | Base search frame unit |
| Forms\Oper.pas | Edit data unit |
| Forms\Statist.pas | Statistic functions unit |
| Forms\Child.pas | parent form for Statist and Oper units |
| Forms\Main.pas | main application form unit |
| Db\Dm.pas | common DataModule for db connection |
| PgARMsProject.dpr | The main project file |
| PgARMsProject.dproj | The MSBUILD project file |
| README.md | This readme file |
