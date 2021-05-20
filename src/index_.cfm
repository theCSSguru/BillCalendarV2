<cfscript>
  param name="url.month" default="#month(now())#";
  param name="url.year" default="#year(now())#";
  dtThisMonth = CreateDate( url.year, url.month, 1 );
  dtMonthStart = (dtThisMonth + 1 - MyDayOfWeek( dtThisMonth ));
  dtMonthEnd = (dtThisMonth + 7 + DaysInMonth( dtThisMonth ));
  dtMonthEnd = (dtMonthEnd + (7 - MyDayOfWeek( dtMonthEnd )));



  //This runs to see if there are any db updates. Eventually we'll use url detection and only run it in dev
  cfinclude(template="index_db_.cfm");

  //make sure the user is logged in, if not create a temp account and set a cookie
  stUser = application.oUser.checkLogin();

  qEntriesAll = application.oEntry.getEntries(stUser.user_id,url.month,url.year);
  //dump(var=#qEntriesAll#);
</cfscript>
<!--- 
<cfoutput>
  dtThisMonth: #dtThisMonth#<br/>
  dtMonthStart: #dtMonthStart#<br/>
  dtMonthEnd: #dtMonthEnd# <br/>
</cfoutput> 
--->
<cffunction
  name="MyDayOfWeek"
  access="public"
  returntype="numeric"
  output="false"
  hint="Returns our proxy day of week value.">
  <!--- Define arguments. --->
  <cfargument
    name="Date"
    type="date"
    required="true"
    hint="The date that we are using to get the day of week."
  />
  <cfargument
    name="FirstDayOfWeek"
    type="numeric"
    required="false"
    default="1"
    hint="This is the day (1 = Sunday) that we are treating as the first day of the week."
  />
  <!---
  Translate the actual day of the week to the pseudo
  day of the week using the passed in FirstDayOfWeek.
  --->
  <cfreturn
    (
      (
        (
          DayOfWeek( ARGUMENTS.Date ) +
          (7 - ARGUMENTS.FirstDayOfWeek)
        ) MOD 7
      ) +
    1
  ) />
</cffunction>

