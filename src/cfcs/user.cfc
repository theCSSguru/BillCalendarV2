component {

    function init(){
        return this;
    }

    function checkLogin(){

        //check for cookie.

        //if it doesn't exist we need to create a temporary cookie, encrypt it and set it until the user logs in.
        var stUser = structNew();

        if ( ! structKeyExists(cookie,'user')) {

            stUser = createTempUser(cgi.REMOTE_ADDR);

            cfcookie(name="user", expires="never", value="#application.oUtils.stringEncrypt(application.encryptKey,'#stUser.user_id#,#stUser.uuid#')#");

        } else {
            var strUser = application.oUtils.stringDecrypt(application.encryptKey,cookie.user);
            stUser = structNew();
            stUser.user_id = listGetAt(strUser,1);
            stUser.uuid = listGetAt(strUser,2);
        }

        return stUser;

    }

    function getUser(numeric user_id, string uuid="") {

        var qUser = new Query();

        var sql = "select * from users where user_id = ?";

        if (len(arguments.uuid)){
            sql = sql & " and uuid = ?";
        }

        qUser.addParam(name="user_id", value="#arguments.user_id#", cf_sql_type = "cf_sql_integer");

        if (len(arguments.uuid)){
            qUser.addParam(name="uuid", value="#arguments.uuid#", cf_sql_type = "cf_sql_varchar");
        }

        return qUser.execute().getResult();

    }

    function createTempUser(ipaddress){

        var uuid = createUUID();

        var qAddEntry = new Query();

        var ts = createodbcdatetime(now());
        var ret = structNew();

        qAddEntry.setSQL("
        insert into users 
        set
        uuid = :uuid,
        signup_dt = #ts#,
        ipaddress = :ipaddress,
        active = 1
        ");

        qAddEntry.addParam(name="uuid", value="#uuid#", cf_sql_type = "cf_sql_varchar");
        qAddEntry.addParam(name="signup_dt", value="#ts#", cf_sql_type = "cf_sql_timestamp");
        qAddEntry.addParam(name="ipaddress", value="#arguments.ipaddress#", cf_sql_type = "cf_sql_varchar");

        var result = qAddEntry.execute();

        ret.user_id = result.getPrefix().generatedKey;
        ret.uuid = uuid;

        return ret;
    }

}