component {
    this.name = "BillCalendarApp";
    this.datasource = "billcalendar";
    this.sessionManagement = true;
    this.encryptKey="cuBgAcjtGwEy4hRnXdaIFQ==";
    this.setDomainCookies = "yes";
    this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0); //10 days

    function onApplicationStart() {
        application.config="xyz";
        application.encryptKey = this.encryptKey;
        application.applicationName = this.name;
        return true;
    }

    function onRequest( string targetPage ) {
        include arguments.targetPage;
    }
    
    function onRequestStart( string targetPage ) {

        /*if (structKeyExists(cookie,'privacy') eq false) {
            location(url="/privacy/", addtoken=false);
        }*/
    
        if (cgi.server_name does not contain 'billcalendar.app') {
            request.form_email ="randy@billcalendar.app";
            request.mail_host ="smtp.mailtrap.io";
            request.mail_username="20b8d46616794c";
            request.mail_password="debca6b074ee4f";
            request.mail_port="2525";
    
        } else {
            /*request.form_email ="randy@billcalendar.app";
            request.mail_host ="localhost";
            request.mail_username="";
            request.mail_password="";
            request.mail_port="25";*/

            request.form_email ="randy@billcalendar.app";
            request.mail_host ="smtp.mailtrap.io";
            request.mail_username="20b8d46616794c";
            request.mail_password="debca6b074ee4f";
            request.mail_port="2525";
        }
       
    

        url.randyinit = 1;

        if (!structKeyExists(Application, 'oUtils') or structKeyExists(url,'randyinit') ) {
            application.oUtils = new src.cfcs.utils();
        }

        if (!structKeyExists(Application, 'oEntry') or structKeyExists(url,'randyinit') ) {
            application.oEntry = new src.cfcs.entry();
        }

        if (!structKeyExists(Application, 'oAjax') or structKeyExists(url,'randyinit') ) {
            application.oAjax = new src.cfcs.ajax();
        }

        if (!structKeyExists(Application, 'oUser') or structKeyExists(url,'randyinit') ) {
            application.oUser = new src.cfcs.user();
        }

        repeat_types = {
            1 = "None",
            2 = "Daily",
            3 = "Weekly",
            4 = "Monthly",
            5 = "Yearly"
        };
        
        types = {
            1 = "Bill",
            2 = "Deposit",
            3 = "Savings",
            4 = "Income"
        };


   
    //dump(var=#application#);

    }

 }

 /*

box cfconfig datasource save name=billcalendar dbdriver=mysql host=127.0.0.1 port=3306 database=billcalendar username=billcalendar password=billcalendar242

box cfconfig mailserver save smtp=smtp.mailtrap.io username=20b8d46616794c password=debca6b074ee4f port=2525

 */