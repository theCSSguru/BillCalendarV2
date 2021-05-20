<!doctype html>
<html lang="en-US" data-theme="dark">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0">
  <meta name="description" content="Bill Calendar">
  <meta name="keywords" content="Bill,Calendar">
	<title>Bill Calendar</title>
	<link rel="preload" href="assets/css/app.min.css" as="style">
  <link rel="preload" href="assets/js/app.min.js" as="script">
  <link rel="stylesheet" href="assets/css/app.min.css" type="text/css" media="screen, projection">
	<!--- Pure JS for Theme Setting on page load, needs to be here --->
	<script type="text/javascript">
	var html = document.querySelector('html');
	var ls = localStorage.getItem('theme');
	html.dataset.theme = ls
	</script>
  <link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
  <link rel="manifest" href="site.webmanifest">
  <link rel="mask-icon" href="safari-pinned-tab.svg" color="#5bbad5">
  <meta name="msapplication-TileColor" content="#2d89ef">
	<meta name="theme-color" content="#ffffff">
</head>
<body>
  <cfinclude template="index_.cfm" />
  <div class="bc-header-navigation">
    <ul class="bc-header-navigation-list">
      <li><a href="/">Account</a></li>
      <li><a href="/">Settings</a></li>
      <li><a href="/">Upgrade</a></li>
    </ul>
  </div>
  <div class="bc-wrapper">
    <div class="bc-header">
      <div class="bc-header-logo-wrap">
        <button class="bc-header-menu-toggle" aria-hidden="true">
          <span class="bc-header-menu-icon">
            <span class="bc-header-menu-icon-bar"></span>
            <span class="bc-header-menu-icon-bar"></span>
            <span class="bc-header-menu-icon-bar"></span>
            <span class="bc-header-menu-icon-text">Menu</span>
          </span>
        </button>
        <div class="bc-header-logo">
          <div class="bc-header-logo-icon" aria-hidden="true">
            <div class="bc-header-logo-icon-tab"></div>
            <div class="bc-header-logo-icon-tab"></div>
            <div class="bc-header-logo-icon-calendar">
              <div class="bc-header-logo-icon-calendar-header"></div>
              <div class="bc-header-logo-icon-dollar-sign">$</div>
            </div>
          </div>
          <span><strong>Bill</strong>Calendar</span>
        </div>
			</div>
			<div class="bc-header-actions">
				<button class="btn btn-primary bc-header-actions-signup">
					<!--- <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-plus" class="svg-inline--fa fa-user-plus fa-w-20" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><path fill="currentColor" d="M624 208h-64v-64c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v64h-64c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h64v64c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16v-64h64c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zm-400 48c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm89.6 32h-16.7c-22.2 10.2-46.9 16-72.9 16s-50.6-5.8-72.9-16h-16.7C60.2 288 0 348.2 0 422.4V464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48v-41.6c0-74.2-60.2-134.4-134.4-134.4z"></path></svg> --->
					<span>Sign Up</span>
				</button>
				<button class="btn btn-dark bc-header-actions-signup">
					<!--- <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="sign-in-alt" class="svg-inline--fa fa-sign-in-alt fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M416 448h-84c-6.6 0-12-5.4-12-12v-40c0-6.6 5.4-12 12-12h84c17.7 0 32-14.3 32-32V160c0-17.7-14.3-32-32-32h-84c-6.6 0-12-5.4-12-12V76c0-6.6 5.4-12 12-12h84c53 0 96 43 96 96v192c0 53-43 96-96 96zm-47-201L201 79c-15-15-41-4.5-41 17v96H24c-13.3 0-24 10.7-24 24v96c0 13.3 10.7 24 24 24h136v96c0 21.5 26 32 41 17l168-168c9.3-9.4 9.3-24.6 0-34z"></path></svg> --->
					<span>Log In</span>
				</button>
			</div>
    </div>
    <div class="bc-header-two">
			<div class="bc-theme-switch-wrapper">
				<label class="bc-theme-switch-label" for="bc-theme-switch-checkbox">
					<input type="checkbox" id="bc-theme-switch-checkbox">
					<div class="bc-theme-switch-slider bc-theme-switch-round"></div>
				</label>
			</div>
      <div class="bc-header-month-wrap">
        <span class="bc-header-month-prev"><span>Prev Month</span></span>
        <span class="bc-header-month"><cfoutput>#monthAsString(url.month)#</cfoutput></span>
        <span class="bc-header-year"><cfoutput>#url.year#</cfoutput></span>
        <span class="bc-header-month-next"><span>Next Month</span></span>
      </div>
      <cfset currentMonth = dateFormat(now(),'mm')>
      <cfquery name="billCount" dataSource="billcalendar">
        select * from entries where entry_month = #currentMonth# and entry_type = 1
      </cfquery>
      <cfquery name="depositCount" dataSource="billcalendar">
        select * from entries where entry_month = #currentMonth# and entry_type = 2
      </cfquery>
      <cfquery name="savingsCount" dataSource="billcalendar">
        select * from entries where entry_month = #currentMonth# and entry_type = 3
      </cfquery>
      <cfquery name="incomeCount" dataSource="billcalendar">
        select * from entries where entry_month = #currentMonth# and entry_type = 4
      </cfquery>
      <ul class="bc-header-stats">
        <cfoutput>
          <li class="bc-header-stats-bills" data-tooltip="Bills" data-tooltip-placement="bottom"><span>#billCount.RecordCount#</span></li>
          <li class="bc-header-stats-deposits" data-tooltip="Deposits" data-tooltip-placement="bottom"><span>#depositCount.RecordCount#</span></li> 
          <li class="bc-header-stats-savings" data-tooltip="Savings" data-tooltip-placement="bottom"><span>#savingsCount.RecordCount#</span></li>
          <li class="bc-header-stats-income" data-tooltip="Income" data-tooltip-placement="bottom" data-tooltip-edge="right"><span>#incomeCount.RecordCount#</span></li>
        </cfoutput>
      </ul>
    </div>
    <div class="bc-calendar">
      <div class="bc-calendar-header">
        <div class="bc-calendar-header-day">Sun</div>
        <div class="bc-calendar-header-day">Mon</div>
        <div class="bc-calendar-header-day">Tue</div>
        <div class="bc-calendar-header-day">Wed</div>
        <div class="bc-calendar-header-day">Thu</div>
        <div class="bc-calendar-header-day">Fri</div>
        <div class="bc-calendar-header-day">Sat</div>
      </div>
      <div class="bc-calendar-week">
        <cfloop index="intDate" from="#dtMonthStart#" to="#dtMonthEnd#" step="1">
          <cfset getDate = dateFormat(intDate,'yyyy-mm-dd')>
          <cfset getMonth = dateFormat(intDate,'mm')>
          <cfset todaysMonth = dateFormat(now(),'mm')>
          <cfset todaysDate = dateFormat(now(),'yyyy-mm-dd')>
          <cfset qEntries = application.oEntry.getEntriesQry(qEntriesAll,getDate)/>
          <div class="bc-calendar-day<cfif todaysDate eq getDate> bc-calendar-day-today</cfif><cfif getMonth neq todaysMonth> bc-calendar-day-other-month</cfif>" data-date="<cfoutput>#getDate#</cfoutput>">
            <span class="bc-calendar-day-number"><cfoutput>#Day(intDate)#</cfoutput></span>

            <div class="bc-calendar-day-events-wrap">
              <div class="bc-calendar-day-events">
                <cfoutput query="qEntries">
                  <cfset type = lcase(types[entry_type]) />
                  <!---
                  <div class="bc-calendar-day-#type#-wrap" data-type="#types[entry_type]#" data-repeat="#repeat_types[entry_repeat]#" data-frequency="#entry_frequency#">
                    <div class="bc-calendar-day-#type#">
                      <span class="badge badge-#type#" data-type="#types[entry_type]#" data-repeat="#repeat_types[entry_repeat]#" data-frequency="#entry_frequency#">
                        <span class="price">#entry_amount#</span>
                        <span class="item">#entry_name#</span>
                      </span>
                    </div>
                  </div>
                  --->
                  <span class="badge badge-#type#" data-type="#types[entry_type]#" data-repeat="#repeat_types[entry_repeat]#" data-frequency="#entry_frequency#">
                    <span class="price">#entry_amount#</span>
                    <span class="item">#entry_name#</span>
                  </span>
                </cfoutput>
                <cfif len(qEntries)>
                  <span class="badge badge-total">
                    <span class="price">156.43</span>
                  </span>
                </cfif>
              </div>
            </div>
            
            <!--- Temporary --->
            <!--- 
              *** I replaced this to be inside of the 
              *** normal list instead of by itself ~ Chris
              
            <cfif getDate eq '2019-04-10'>
              <div class="bc-calendar-day-income-wrap">
                <div class="bc-calendar-day-income">
                  <span class="badge badge-income">
                    <span class="price">3256.24</span>
                    <!--- <span class="item">#entry_name#</span> --->
                  </span>
                </div>
              </div>
            </cfif>
            --->

            <!--- Temporary --->
            <cfif getDate eq '2019-04-25x'>
              <div class="bc-calendar-day-events-wrap">
                <div class="bc-calendar-day-events">
                  <span class="badge badge-savings">
                    <span class="price">75.00</span>
                    <span class="item">Savings</span>
                  </span>
                  <span class="badge badge-bill">
                    <span class="price">76.43</span>
                    <span class="item">Duke Energy</span>
                  </span>
                  <span class="badge badge-bill">
                    <span class="price">105.00</span>
                    <span class="item">Comcast</span>
                  </span>
                  <span class="badge badge-deposit">
                    <span class="price">100.00</span>
                    <span class="item">Deposit</span>
                  </span>
                  <span class="badge badge-total">
                    <span class="price">156.43</span>
                  </span>
                </div>
              </div>
            </cfif>

          </div>
          <cfif ((MyDayOfWeek(intDate) EQ 7) AND (intDate LT dtMonthEnd))>
            </div>
            <div class="bc-calendar-week">
          </cfif>
        </cfloop>      
      </div>
    </div>
    <div class="bc-mobile-list hidden">
      <div class="bc-mobile-list-date"></div>
      <div class="bc-mobile-list-items"></div>
      <div class="bc-mobile-list-actions">
        <button class="btn btn-dark bc-mobile-list-close">Close</button>
        <button class="btn btn-primary bc-mobile-list-add">Add</button>
      </div>
    </div>
  </div>
  <div class="bc-modal hidden" id="bcModalDay" tabindex="-1" role="dialog" aria-labelledby="bcModalDay" aria-hidden="true">
    <div class="bc-modal-dialog bc-modal-dialog-centered" role="document">
      <div class="bc-modal-content">
        <div class="bc-modal-header">
          <h5 class="bc-modal-title" id="bcModalDayTitle">bc-modal title</h5>
        </div>
        <div class="bc-modal-body">
          <form class="bc-modal-form">
            <div class="row bc-modal-type-row bc-modal-hr">
              <div class="col">
                <div class="bc-modal-type">
                  <div class="row">
                    <div class="col">
                      <button type="button" class="bc-modal-type-bill">Bill</button>
                    </div>
                    <div class="col">
                      <button type="button" class="bc-modal-type-deposit">Deposit</button>
                    </div>
                    <div class="col">
                      <button type="button" class="bc-modal-type-savings">Savings</button>
                    </div>
                    <div class="col">
                      <button type="button" class="bc-modal-type-income">Income</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="row bc-modal-name-row bc-modal-hr bc-modal-faded">
              <div class="col col-8">
                <div class="bc-modal-name">
                  <label for="bcModalDayName">Name</label>
                  <input type="text" placeholder="Enter Name Here" id="bcModalDayName">
                </div>
              </div>
              <div class="col col-4">
                <div class="bc-modal-amount">
                  <label for="bcModalDayAmount">Amount</label>
                  <span class="bc-modal-amount-dollar-sign">$</span>
                  <input type="number" min="0.00" max="99999.99" step="0.01" placeholder="0.00" id="bcModalDayAmount">
                </div>
              </div>
            </div>
						<div class="bc-modal-repeat-row bc-modal-hr bc-modal-faded">	
							<div class="bc-modal-repeat">
								<label for="bcModalDayRepeat">Repeat</label>
							</div>
							<div class="row bc-modal-repeat-items">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="bc-modalRepeat" id="bcModalDayRepeatNone" value="None">
									<label class="form-check-label" for="bcModalDayRepeatNone">None</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="bc-modalRepeat" id="bcModalDayRepeatDaily" value="Daily">
									<label class="form-check-label" for="bcModalDayRepeatDaily">Daily</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="bc-modalRepeat" id="bcModalDayRepeatWeekly" value="Weekly">
									<label class="form-check-label" for="bcModalDayRepeatWeekly">Weekly</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="bc-modalRepeat" id="bcModalDayRepeatMonthly" value="Monthly">
									<label class="form-check-label" for="bcModalDayRepeatMonthly">Monthly</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="bc-modalRepeat" id="bcModalDayRepeatYearly" value="Yearly">
									<label class="form-check-label" for="bcModalDayRepeatYearly">Yearly</label>
								</div>
							</div>
            </div>
            <div class="bc-modal-frequency-row bc-modal-faded">
							<div class="bc-modal-frequency">
								<label for="bcModalDayFrequency">Frequency</label>
							</div>
							<div class="bc-modal-frequency-count-wrap">
								<span>Every</span>
								<input type="number" value="1" min="1" max="31" class="bc-modal-frequency-count" name="bc-modalFrequency" id="bcModalDayFrequency">
								<span class="bc-modal-frequency-repeat-name">day(s)</span>
							</div>
            </div>
          </form>
        </div>
        <div class="bc-modal-footer">
          <button type="button" class="btn btn-dark bc-modal-close" data-dismiss="bcModalDay">Close</button>
          <button type="button" class="btn btn-primary bc-modal-add bc-modal-faded">Add</button>
        </div>
      </div>
    </div>
  </div>
  <script defer src="assets/js/app.min.js"></script>
</body>
</html>