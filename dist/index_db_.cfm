<cfscript>

new_dir = ExpandPath("../db/");
done_dir = expandPath("../db_done");

//if directory exists we are on dev
if ( directoryExists(done_dir)) {

    dl = directoryList(new_dir,false,'query');

    //dump(var=#dl#);
    if (dl.recordcount gt 0) {

        for (row in dl) {

            //check to see if SQL file is in done folder

            if (! fileExists("#done_dir#/#row.name#") ) {
                //Execute Sql
                sql = fileRead("#row.directory#/#row.Name#");

                try {
                    q = new Query();

                    q.setSQL(sql);

                    q.execute();

                    //copy to done folder
                    fileCopy("#row.directory#/#row.name#","#done_dir#/#row.name#");
                }
                catch (any e) {
                    writeOutput("Error: " & e.message);
                    cfmail( to = "randy@billcalendar.app", from = "website@billcalendar.app", type="html", subject = "db error on dev ", server="#request.mail_host#", username="#request.mail_username#", password="#request.mail_password#", port="#request.mail_port#" ) { 
                        dump(var=#e#);
                        dump(var=#cgi#);
                        dump(var=#form#);
                        dump(var=#url#);
                        dump(var=#row#);
                    }
                }


                
            }
            
        }
        
    }

}


</cfscript>
