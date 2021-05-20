<cfcomponent>

    <cffunction name="stringEncrypt" access="public" output="no" hint="I encrypt a given string employing the AES algorithm and Base64 encoding." returntype="string" displayname="Utility > stringEncrypt()">
        
            <cfargument name="key" type="string" required="true"/>
            <cfargument name="textToEncrypt" type="string" required="true"/>
    
            <!---
            Tech note:
            AES is the Advanced Encryption Standard specified by the National Institute of Standards and Technology (NIST) FIPS-197.
            The Base64 algorithm, as specified by IETF RFC 2045 represents the binary encoding in which to represent the data as a string.
            Our application used to employ the application scoped applicationName as part of the encryption key. We still use it app wide as the named target
            for popup windows so as to not spawn off to many windows in a session. This is done consistently throughout all ColdFusion and all Flex code.
            --->
            
            <cfscript>
            
                // init
                local.strEncrypted = "";
                //local.strKey = generateSecretKey( "AES" );
            
                local.strEncrypted = encrypt( arguments.textToEncrypt,arguments.key,"AES","Base64" ); 
    
                // return the final container to the caller
                return local.strEncrypted;
                
            </cfscript>
            
        </cffunction>
    
    <!---<cfset decrypted = objUtils.stringDecrypt(key,textToDecrypt)>--->    
    <cffunction name="stringDecrypt" access="public" output="no" hint="I encrypt a given string employing the AES algorithm and Base64 encoding." returntype="string" displayname="Utility > stringEncrypt()">
        
            <cfargument name="key" type="string" required="true"/>
            <cfargument name="textToEncrypt" type="string" required="true"/>
    
            <!---
            Tech note:
            AES is the Advanced Encryption Standard specified by the National Institute of Standards and Technology (NIST) FIPS-197.
            The Base64 algorithm, as specified by IETF RFC 2045 represents the binary encoding in which to represent the data as a string.
            Our application used to employ the application scoped applicationName as part of the encryption key. We still use it app wide as the named target
            for popup windows so as to not spawn off to many windows in a session. This is done consistently throughout all ColdFusion and all Flex code.
            --->
            
            <cfscript>
            
                // init
                local.strEncrypted = "";
                //local.strKey = generateSecretKey( "AES" );
            
                local.strEncrypted = decrypt( arguments.textToEncrypt,arguments.key,"AES","Base64" ); 
    
                // return the final container to the caller
                return local.strEncrypted;
                
            </cfscript>
            
        </cffunction>    
     <cfscript>
    /**
     * Generates a structure of days for the week, including the beginning and end of the week.
     * Rewrite by Raymond Camden
     * 
     * @param date      Date to use. Defaults to this week. 
     * @return Returns a structure. 
     * @author Rich Rein (richard.rein@medtronic.com) 
     * @version 2, February 25, 2002 
     */
    function thisWeek() {
        var dayOrdinal = 0;
        var returnStruct = structNew();
        var current_date = now();
        
        if (arrayLen(arguments)) current_date = arguments[1];
        dayOrdinal = DayOfWeek(current_date);
        
        returnStruct.weekBegin = dateAdd("d",-1 * (dayOrdinal-1), current_date);
        returnStruct.weekEnd = dateAdd("d",7-dayOrdinal, current_date);
        returnStruct.weekNo = Week(returnStruct.weekBegin);
        
        for(i=1; i LTE 7; i=i+1) {
            StructInsert(returnStruct,DayOfWeekAsString(i),dateAdd("d",i-1,returnStruct.weekBegin));
        }
    
            
        returnStruct.nextSunday = dateAdd("d",1,returnStruct.weekEnd);
    
        if (datecompare(now(),returnStruct.friday)==1) {
            returnStruct.nextFriday = dateAdd("d",6,returnStruct.weekEnd);
        } else {
    
            returnStruct.nextFriday = returnStruct.Friday;
        }
        
        return returnStruct;
    
    }
    
    function lastWeek() {
        var dayOrdinal = 0;
        var returnStruct = structNew();
        var current_date = dateadd('w',-1,now());
        
        if (arrayLen(arguments)) current_date = arguments[1];
        dayOrdinal = DayOfWeek(current_date);
        
        returnStruct.weekBegin = dateAdd("d",-1 * (dayOrdinal-1), current_date);
        returnStruct.weekEnd = dateAdd("d",7-dayOrdinal, current_date);
        returnStruct.weekNo = Week(returnStruct.weekBegin);
        
        for(i=1; i LTE 7; i=i+1) {
            StructInsert(returnStruct,DayOfWeekAsString(i),dateAdd("d",i-1,returnStruct.weekBegin));
        }
    
            
        returnStruct.nextSunday = dateAdd("d",1,returnStruct.weekEnd);
        return returnStruct;
    
    }
    </cfscript>   
    
    <cfscript>
    /**
     * Generates a structure of days for the week, including the beginning and end of the week.
     * Rewrite by Raymond Camden
     * 
     * @param date      Date to use. Defaults to this week. 
     * @return Returns a structure. 
     * @author Rich Rein (richard.rein@medtronic.com) 
     * @version 2, February 25, 2002 
     */
    function LastWeek() {
        var dayOrdinal = 0;
        var returnStruct = structNew();
        var current_date = dateAdd('ww',-1,now());
        
        if (arrayLen(arguments)) current_date = arguments[1];
        dayOrdinal = DayOfWeek(current_date);
        
        returnStruct.weekBegin = dateAdd("d",-1 * (dayOrdinal-1), current_date);
        returnStruct.weekEnd = dateAdd("d",7-dayOrdinal, current_date);
        returnStruct.weekNo = Week(returnStruct.weekBegin);
        
        for(i=1; i LTE 7; i=i+1) {
            StructInsert(returnStruct,DayOfWeekAsString(i),dateAdd("d",i-1,returnStruct.weekBegin));
        }
    
            
        returnStruct.nextSunday = dateAdd("d",1,returnStruct.weekEnd);
        return returnStruct;
    
    }
    </cfscript>   
    
    <cfscript>
    /**
     * Generates a structure of days for the week, including the beginning and end of the week.
     * Rewrite by Raymond Camden
     * 
     * @param date      Date to use. Defaults to this week. 
     * @return Returns a structure. 
     * @author Rich Rein (richard.rein@medtronic.com) 
     * @version 2, February 25, 2002 
     */
    function NextWeek() {
        var dayOrdinal = 0;
        var returnStruct = structNew();
        var current_date = dateAdd('ww',1,now());
        
        if (arrayLen(arguments)) current_date = arguments[1];
        dayOrdinal = DayOfWeek(current_date);
        
        returnStruct.weekBegin = dateAdd("d",-1 * (dayOrdinal-1), current_date);
        returnStruct.weekEnd = dateAdd("d",7-dayOrdinal, current_date);
        returnStruct.weekNo = Week(returnStruct.weekBegin);
        
        for(i=1; i LTE 7; i=i+1) {
            StructInsert(returnStruct,DayOfWeekAsString(i),dateAdd("d",i-1,returnStruct.weekBegin));
        }
    
            
        returnStruct.nextSunday = dateAdd("d",1,returnStruct.weekEnd);
        return returnStruct;
    
    }
    </cfscript>   
    <cfscript>
    /**
     * Converts a delimited list of key/value pairs to a structure.
     * v2 mod by James Moberg
     * 
     * @param list      List of key/value pairs to initialize the structure with.  Format follows key=value. (Required)
     * @param delimiter      Delimiter seperating the key/value pairs.  Default is the comma. (Optional)
     * @return Returns a structure. 
     * @author Rob Brooks-Bilson (rbils@amkor.com) 
     * @version 2, April 1, 2010 
     */
    function listToStruct(list){
           var myStruct = StructNew();
           var i = 0;
           var delimiter = "&";
           var tempList = arrayNew(1);
           if (ArrayLen(arguments) gt 1) {delimiter = arguments[2];}
           tempList = listToArray(list, delimiter);
           for (i=1; i LTE ArrayLen(tempList); i=i+1){
                   if (not structkeyexists(myStruct, trim(ListFirst(tempList[i], "=")))) {
                           StructInsert(myStruct, trim(ListFirst(tempList[i], "=")), trim(ListLast(tempList[i], "=")));
                   }
           }
           return myStruct;
    }
    </cfscript>
    
    <cffunction name="convertQuantity">
            <cfargument name="qty">
            <cfargument name="showMinus" default="true">
            
            <cfset var sign = "">
            <cfset var newQty = arguments.qty>
            <cfset var cases  = 0>
            <cfset var bottles = 0>
            <cfset var ret = structNew()>
            <cfset var caseunit="case">
            <cfset var bottleunit="bottle">
            
            <cfif abs(arguments.qty) gte 12>
                <cfset type ="C">
            <cfelse>
                <cfset type="B">    
            </cfif>
            
            <cfif arguments.qty lt 0>
                <cfset sign = "-">
            </cfif>
            
            <cfif abs(arguments.qty) gte 12>
                <cfset cases = Int(arguments.qty / 12)>
                <cfset bottles = arguments.qty mod 12>
            </cfif>
            
            <cfif abs(arguments.qty) lt 12>
                <cfset bottles = arguments.qty>
            </cfif>
            
            
            
            <cfif abs(cases) gt 1><cfset caseunit="cases"></cfif>
            <cfif abs(bottles) gt 1><cfset bottleunit="bottles"></cfif>
            
            <cfif cases lt 0>
                <cfif arguments.showminus is true><cfset cases = "#sign##cases#"></cfif>
            </cfif>
    
           <cfif bottles lt 0>
                <cfif arguments.showminus is true><cfset bottles = "#sign##bottles#"></cfif>
            </cfif>
            
            
            
            <cfset ret.cases = cases>
            <cfset ret.bottles = bottles>
            <cfreturn ret>
        </cffunction>
        
         <cffunction name="HTMLStringFormat" access="public" output="No" >
      <cfargument name="string" type="string" required="Yes" >
      <cfset local.special = "&ndash;,&mdash;,&iexcl;,&iquest;,&quot;,&ldquo;,&rdquo;,&lsquo;,&rsquo;,&laquo;,&raquo;,&nbsp;,&amp;,&cent;,&copy;,&divide;,&gt;,&lt;,&micro;,&middot;,&para;,&plusmn;,&euro;,&pound;,&reg;,&sect;,&trade;,&yen;,&aacute;,&Aacute;,&agrave;,&Agrave;,&acirc;,&Acirc;,&aring;,&Aring;,&atilde;,&Atilde;,&auml;,&Auml;,&aelig;,&AElig;,&ccedil;,&Ccedil;,&eacute;,&Eacute;,&egrave;,&Egrave;,&ecirc;,&Ecirc;,&euml;,&Euml;,&iacute;,&Iacute;,&igrave;,&Igrave;,&icirc;,&Icirc;,&iuml;,&Iuml;,&ntilde;,&Ntilde;,&oacute;,&Oacute;,&ograve;,&Ograve;,&ocirc;,&Ocirc;,&oslash;,&Oslash;,&otilde;,&Otilde;,&ouml;,&Ouml;,&szlig;,&uacute;,&Uacute;,&ugrave;,&Ugrave;,&ucirc;,&Ucirc;,&uuml;,&Uuml;,&yuml;">
      <cfset local.normal = "#chr(8211)#,#chr(8212)#,#chr(161)#,#chr(191)#,#chr(34)#,#chr(8220)#,#chr(8221)#,#chr(39)#,#chr(39)#,#chr(171)#,#chr(187)#,#chr(32)#,#chr(38)#,#chr(162)#,#chr(169)#,#chr(247)#,#chr(62)#,#chr(60)#,#chr(181)#,#chr(183)#,#chr(182)#,#chr(177)#,#chr(8364)#,#chr(163)#,#chr(174)#,#chr(167)#,#chr(8482)#,#chr(165)#,#chr(225)#,#chr(193)#,#chr(224)#,#chr(192)#,#chr(226)#,#chr(194)#,#chr(229)#,#chr(197)#,#chr(227)#,#chr(195)#,#chr(228)#,#chr(196)#,#chr(230)#,#chr(198)#,#chr(231)#,#chr(199)#,#chr(233)#,#chr(201)#,#chr(232)#,#chr(200)#,#chr(234)#,#chr(202)#,#chr(235)#,#chr(203)#,#chr(237)#,#chr(205)#,#chr(236)#,#chr(204)#,#chr(238)#,#chr(206)#,#chr(239)#,#chr(207)#,#chr(241)#,#chr(209)#,#chr(243)#,#chr(211)#,#chr(242)#,#chr(210)#,#chr(244)#,#chr(212)#,#chr(248)#,#chr(216)#,#chr(245)#,#chr(213)#,#chr(246)#,#chr(214)#,#chr(223)#,#chr(250)#,#chr(218)#,#chr(249)#,#chr(217)#,#chr(251)#,#chr(219)#,#chr(252)#,#chr(220)#,#chr(255)#">
      <cfset local.formated = ReplaceList(arguments.string, local.special, local.normal)>
      <cfreturn local.formated>
     </cffunction>
    
     <cfscript>
    /**
     * Returns the passed string with all non-numbers removed (letters, punctuation, whitespace, etc.).
     * 
     * @param textStr      String containing numbers you want returned. 
     * @param allowDec      Boolean (yes/no) indicating whether to preserve decimal points.  Default is No. 
     * @return Returns a number. 
     * @author Mark Andrachek (hallow@webmages.com) 
     * @version 1, December 18, 2001 
     */
    function GetNumbers(textstr) {
      if (arraylen(arguments) GTE 2) { 
        return REReplace(textstr,"[^0-9\.]",'','ALL'); }
      else { 
        return REReplace(textstr,"[^0-9]",'','ALL');  }
    }
    </cfscript>
    
    <cffunction name="isAjax" returntype="boolean" access="public" output="false" hint="Returns whether the page was called from JavaScript or not."
        examples=
        '
            <cfset requestIsAjax = isAjax()>
        '
        categories="controller-request,miscellaneous" chapters="" functions="isGet,isPost,isSecure">
        <cfreturn (cgi.http_x_requested_with is "XMLHTTPRequest")>
    </cffunction>
    
    <cfscript>
    
        function dollarFPFormat(numberToRound) {
    
            return "$" & decimalRound(arguments.numberToRound,4,"up");
    
        }
    
    
        /**
     * Rounds a number to a specific number of decimal places by using Java's math library.
     * 
     * @param numberToRound      The number to round. (Required)
     * @param numberOfPlaces     The number of decimal places. (Required)
     * @param mode   The rounding mode. Defaults to even. (Optional)
     * @return Returns a number. 
     * @author Peter J. Farrell (pjf@maestropublishing.com) 
     * @version 1, March 3, 2006 
     */
    function decimalRound(numberToRound, numberOfPlaces) {
        // Thanks to the blog of Christian Cantrell for this one
        var bd = CreateObject("java", "java.math.BigDecimal");
        var mode = "even";
        var result = "";
        
        if (ArrayLen(arguments) GTE 3) {
            mode = arguments[3];
        }
     
        bd.init(arguments.numberToRound);
        if (mode IS "up") {
            bd = bd.setScale(arguments.numberOfPlaces, bd.ROUND_HALF_UP);
        } else if (mode IS "down") {
            bd = bd.setScale(arguments.numberOfPlaces, bd.ROUND_HALF_DOWN);
        } else {
            bd = bd.setScale(arguments.numberOfPlaces, bd.ROUND_HALF_EVEN);
        }
        result = bd.toString();
        
        if(result EQ 0) result = 0;
    
        return result;
    }
    </cfscript>
    
    </cfcomponent>