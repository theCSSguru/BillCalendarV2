component {

    function getEntries(user_id, month, year){
        var qGetEntries = new Query();

        qGetEntries.setSQL("

            select entry_id, entry_dt, entry_type, entry_name, entry_amount, entry_repeat, entry_frequency 
            from entries 
            where user_id = :user_id and entry_year=:entry_year and entry_month = :entry_month
        ");

        qGetEntries.addParam(name="user_id", value="#arguments.user_id#", cf_sql_type = "cf_sql_integer");
        qGetEntries.addParam(name="entry_year", value="#arguments.year#", cf_sql_type = "cf_sql_integer");
        qGetEntries.addParam(name="entry_month", value="#arguments.month#", cf_sql_type = "cf_sql_integer");

		return qGetEntries.execute().getResult();


    }

    function getEntriesQry(qry, dt){

        var qGetEntries = new Query();

        qGetEntries.setDBType("query");
        qGetEntries.setAttributes(sourceQuery=arguments.qry);
        
        qGetEntries.setSQL("
            select entry_id, entry_dt, entry_type, entry_name, entry_amount, entry_repeat, entry_frequency 
            from sourceQuery 
            where entry_dt = :entry_dt
        ");

        qGetEntries.addParam(name="entry_dt", value="#arguments.dt#", cf_sql_type="cf_sql_date");

        return qGetEntries.execute().getResult();

    }

    function addEntry(entry){
        var qAddEntry = new Query();

        var ts = now();

        /*

        qAddEntry.setSQL("
        insert into entries 
        set
        user_id = :user_id,
        added_dt = :added_dt,
        entry_dt = :entry_dt,
        entry_ts = :entry_ts,
        entry_day = :entry_day,
        entry_month = :entry_month,
        entry_year = :entry_year,
        entry_type = :entry_type,
        entry_name = :entry_name,
        entry_amount = :entry_amount,
        entry_repeat = :entry_repeat,
        entry_frequency = :entry_frequency,
        ipaddress = :ipaddress
        ");

        qAddEntry.addParam(name="user_id", value="#arguments.user_id#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="added_dt", value="#ts#", cf_sql_type = "cf_sql_timestamp");
        qAddEntry.addParam(name="entry_dt", value="#arguments.dayDate#", cf_sql_type = "cf_sql_date");
        qAddEntry.addParam(name="entry_ts", value="#arguments.dayDate#", cf_sql_type = "cf_sql_timestamp");
        qAddEntry.addParam(name="entry_day", value="#day(arguments.dayDate)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_month", value="#month(arguments.dayDate)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_year", value="#year(arguments.dayDate)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_type", value="#day(arguments.type)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_name", value="#arguments.name#", cf_sql_type = "cf_sql_varchar");
        qAddEntry.addParam(name="entry_amount", value="#arguments.amount#", cf_sql_type = "cf_sql_double");
        qAddEntry.addParam(name="entry_repeat", value="#arguments.repeat#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_frequency", value="#arguments.frequency#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="ipaddress", value="#arguments.ipaddress#", cf_sql_type = "cf_sql_varchar");

        */

        qAddEntry.setSQL("
        insert into entries 
        set
        user_id = :user_id,
        added_dt = #ts#,
        entry_dt = :entry_dt,
        entry_ts = :entry_ts,
        entry_day = :entry_day,
        entry_month = :entry_month,
        entry_year = :entry_year,
        entry_type = :entry_type,
        entry_name = :entry_name,
        entry_amount = :entry_amount,
        entry_repeat = :entry_repeat,
        entry_frequency = :entry_frequency,
        ipaddress = :ipaddress
        ");

        qAddEntry.addParam(name="user_id", value="#arguments.user_id#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_dt", value="#arguments.dayDate#", cf_sql_type = "cf_sql_date");
        qAddEntry.addParam(name="entry_ts", value="#arguments.dayDate#", cf_sql_type = "cf_sql_timestamp");
        qAddEntry.addParam(name="entry_day", value="#day(arguments.dayDate)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_month", value="#month(arguments.dayDate)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_year", value="#year(arguments.dayDate)#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_type", value="#arguments.type#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_name", value="#arguments.name#", cf_sql_type = "cf_sql_varchar");
        qAddEntry.addParam(name="entry_amount", value="#arguments.amount#", cf_sql_type = "cf_sql_double");
        qAddEntry.addParam(name="entry_repeat", value="#arguments.repeat#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="entry_frequency", value="#arguments.frequency#", cf_sql_type = "cf_sql_integer");
        qAddEntry.addParam(name="ipaddress", value="#arguments.ipaddress#", cf_sql_type = "cf_sql_varchar");

        return qAddEntry.execute();

    }

}