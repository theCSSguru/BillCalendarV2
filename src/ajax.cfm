<cfscript>
    stUser = application.oUser.checkLogin();
    request.stUser = stUser;
    action = listLast(cgi.PATH_INFO,"/");
    form.user_id = request.stUser.user_id;
    application.oAjax.add(argumentCollection=form);
</cfscript>

<cfset j = structNew()/>
<cfset j.errors=""/>
<cfsavecontent variable="j.entry"><cfoutput>
    <span class="badge badge-#lcase(form.type)#" data-type="#form.type#" data-repeat="#form.repeat#" data-frequency="#form.frequency#">
        <span class="price">#form.amount#</span>
        <span class="item">#form.name#</span>
      </span></cfoutput>
</cfsavecontent>

<cfoutput>#serializeJSON(j)#</cfoutput>