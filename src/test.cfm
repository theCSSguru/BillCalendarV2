
The following code throws this error on MySQL and MariaDB and Lucee 5.2.9.31 Error (database)


Data truncation: Incorrect datetime value: '{ts '2019-02-26 19:20:40'}' for column 'ts' at row 1

The database field ts is a timestamp column.

Any idea what is causing this and how to fix?

ts would normally be a passed in variable, used now() for this example.

<cfscript>
    var qAddEntry = new Query();

    var ts = now();

    ts = dateformat (now(), 'yyyy-mm-dd') & ' ' & timeformat(now(),'HH:mm:ss');

    qAddEntry.setSQL("
        insert into test 
        set
        id=1,
        ts = :ts
        ");

    qAddEntry.addParam(name="ts", value="#ts#", cf_sql_type = "cf_sql_timestamp");
    qAddEntry.execute();
</cfscript>