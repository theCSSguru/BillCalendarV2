component {

    this.repeat_types = {
        "None" = 1,
        "Daily" = 2,
        "Weekly" = 3,
        "Monthly" = 4,
        "Yearly" = 5
    };

    this.types = {
        "Bill" = 1,
        "Deposit" = 2,
        "Savings" = 3,
        "Income" = 4
        
    };

    remote function add(){
        param name="user_id" required=true;
        param name="dayDate" default="";
        param name="type" default="";
        param name="name" default="";
        param name="amount" default="";
        param name="repeat" default="";
        param name="frequency" default="";

        var resp = structNew();
            resp.statuscode = 200;
            resp.statustext="Success";

        var errors = [];

        if (len(form.dayDate) eq 0) { arrayAppend(errors,"Missing Date"); }
        if (len(form.type) eq 0) { arrayAppend(errors,"Missing Type"); }
        if (len(form.name) eq 0) { arrayAppend(errors,"Missing Name"); }
        if (len(form.amount) eq 0) { arrayAppend(errors,"Missing Amount"); }
        if (len(form.repeat) eq 0) { arrayAppend(errors,"Missing Repeat"); }
        if (isNumeric(form.repeat) and form.repeat gt 1) {
            if (len(form.frequency) eq 0) { arrayAppend(errors,"Missing Frequency"); }
        }
        
        cfheader(name="Content-Type" value="application/json");

        if (arraylen(errors) gt 0){
            resp.statustext="There were errors.";
            resp.errors = errors;

            writeOutput(serializeJSON(resp));
            exit;
        }

        //now we can do an add.

        var entry = arguments;
        var now = arguments.dayDate;
        entry.ipaddress = cgi.REMOTE_ADDR;
        entry.repeat = this.repeat_types[entry.repeat];
        entry.type = this.types[entry.type];

        application.oEntry.addEntry(argumentCollection=entry);


    }
}