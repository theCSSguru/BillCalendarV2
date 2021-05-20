$(document).ready(function () {

	// Main Navigation - Toggle
	$('.bc-header-menu-toggle').on('click', function () {
		if (!$(this).hasClass('open')) {
			$(this).insertBefore('.bc-header-navigation-list');
			$('.bc-header-logo').insertBefore('.bc-header-navigation-list');
		} else {
			$('.bc-header-logo').prependTo('.bc-header-logo-wrap');
			$(this).prependTo('.bc-header-logo-wrap');
		}
		$(this).toggleClass('open');
		$('.bc-header-navigation').toggleClass('open');
		$('body').toggleClass('open');
	});
	// Main Navigation - Close when clicking out side of Main Navigation
	var $win = $(window);
	var $box = $('.bc-header-navigation');
	$win.on('click.Bst', function (event) {
		if ($box.has(event.target).length == 0 && !$box.is(event.target)) {
			$('.bc-header-logo').prependTo('.bc-header-logo-wrap');
			$('.bc-header-menu-toggle').prependTo('.bc-header-logo-wrap').removeClass('open');
			$('.bc-header-navigation').removeClass('open');
			$('body').removeClass('open');
		}
	});

	// Theme Toggle for Dark to Light
	$('#bc-theme-switch-checkbox').on('change', function () {
		if ($(this).prop('checked') === true) {
			//$('.bc-theme-switch-label').attr('data-original-title', 'Dark Mode').tooltip('show');
			$('[data-theme]').attr('data-theme', 'light');
			localStorage.setItem('theme', 'light');
		} else {
			//$('.bc-theme-switch-label').attr('data-original-title', 'Light Mode').tooltip('show');
			$('[data-theme]').attr('data-theme', 'dark');
			localStorage.setItem('theme', 'dark');
		}
	});
	if (localStorage.getItem('theme') === 'light') {
		//$('.bc-theme-switch-label').tooltip({ placement: 'bottom', title: 'Dark Mode' });
		//$('[data-theme]').attr('data-theme', 'light');
		$('#bc-theme-switch-checkbox').prop('checked', true);
	} else {
		//$('.bc-theme-switch-label').tooltip({ placement: 'bottom', title: 'Light Mode' });
		//$('[data-theme]').attr('data-theme', 'dark');
		$('#bc-theme-switch-checkbox').prop('checked', false);
	}

	// Modal Toggle Default Controls
	$('[data-dismiss]').on('click', function () {
		var modal = $(this).data('dismiss');
		$('#' + modal).addClass('hidden');
	});
	$('.bc-modal').on('click', function (e) {
		if (e.target == this) {
			var modal = $(this).attr('id');
			$('#' + modal).addClass('hidden');
		}
	});
	function modalSnapToTop() {
		$('.bc-modal, .bc-modal-dialog').scrollTop(0);
	}

	// Modal Day Reset Function
	function modalDayReset() {
		$('#bcModalDay .bc-modal-type button').removeClass('bc-selected');
		$('#bcModalDay #bcModalDayAmount').val('');
		$('#bcModalDay #bcModalDayName').val('');
		$('#bcModalDay .bc-modal-repeat-items .form-check-label').prop('checked', false);
		$('#bcModalDay .bc-modal-frequency-count').val('1');
		$('#bcModalDay #bcModalDayRepeatNone').prop('checked', true);
		$('#bcModalDay .bc-modal-frequency-repeat-name').text('day(s)');
		$('#bcModalDay .bc-modal-faded input').attr('tabindex', '-1');
		$('#bcModalDay .bc-modal-add').addClass('bc-modal-faded').text('Add');
		$('#bcModalDay .bc-modal-update').addClass('bc-modal-add').addClass('bc-modal-faded').removeClass('bc-modal-update').text('Add');
	}

	// Add New Event - Click on the number of the day
	$('.bc-calendar-day-number, .bc-mobile-list-add').on('click', function () {
		var dayDate = $(this).closest('.bc-calendar-day').data('date');
		var formatDate = moment(dayDate).format('dddd, MMMM Do, YYYY');
		$('#bcModalDay').data('dayDate', dayDate);
		// Show Date
		$('#bcModalDayTitle').text(formatDate);
		// Reset Event Modal
		modalDayReset();
		// Show the Modal
		$('#bcModalDay').removeClass('hidden');
	});

	// Modal - Pick a Type - Go to Next Step
	$('.bc-modal-type button').on('click', function () {
		$('.bc-modal-type button').removeClass('bc-selected');
		$(this).addClass('bc-selected');
		$('.bc-modal-name-row').removeClass('bc-modal-faded');
		$('.bc-modal-name-row input').removeAttr('tabindex');
	});
	// Limit the Max Amount for the Amount Input
	$('#bcModalDayAmount').on('keyup', function (e) {
		var result = ($(this).val() - Math.floor($(this).val())) !== 0;
		if (result) {
			var maxChars = 9;
		} else {
			var maxChars = 6;
		}
		if ($(this).val().length > maxChars) {
			$(this).val($(this).val().substr(0, maxChars));
			e.preventDefault();
		}
	});
	// Force Currency to Amount Input
	$('#bcModalDayAmount').on('blur', function () {
		var amount = parseFloat(this.value);
		$(this).val(amount.toFixed(2));
	});
	// Amount and Name Key Up to go to Next Step
	$('#bcModalDayAmount, #bcModalDayName').on('keyup', function () {
		var bcModalAmount = $('#bcModalDayAmount').val();
		var bcModalName = $('#bcModalDayName').val();
		if (bcModalAmount && bcModalName) {
			$('.bc-modal-repeat-row').removeClass('bc-modal-faded');
			$('.bc-modal-repeat-items input').removeAttr('tabindex');
		} else {
			$('.bc-modal-repeat-row').addClass('bc-modal-faded');
			$('.bc-modal-repeat-items input').attr('tabindex', '-1');
		}
	});
	// Turn on the 'Add' button at this step
	$('#bcModalDayName, #bcModalDayAmount').on('blur', function () {
		var bcModalAmount = $('#bcModalDayAmount').val();
		var bcModalName = $('#bcModalDayName').val();
		if (bcModalAmount.length > 0 && bcModalName.length > 0) {
			$('.bc-modal-add').removeClass('bc-modal-faded');
		} else {
			$('.bc-modal-add').addClass('bc-modal-faded');
		}
	});
	// Repeat - choose a repeate item or not, opens frequency option
	$('.bc-modal-repeat-items .form-check-input').on('click', function () {
		var thisValue = $(this).val();
		var frequency = $('.bc-modal-frequency-repeat-name');
		$('.bc-modal-frequency-row').removeClass('bc-modal-faded');
		$('.bc-modal-frequency-row input').removeAttr('tabindex');
		if (thisValue == 'None') {
			frequency.text('day(s)');
			$('.bc-modal-frequency-count').val('1');
			$('.bc-modal-frequency-row').addClass('bc-modal-faded');
			$('.bc-modal-frequency-row input').attr('tabindex', '-1');
		}
		if (thisValue == 'Daily') {
			frequency.text('day(s)');
		}
		if (thisValue == 'Weekly') {
			frequency.text('week(s)');
		}
		if (thisValue == 'Monthly') {
			frequency.text('month(s)');
		}
		if (thisValue == 'Yearly') {
			frequency.text('year(s)');
		}
	});
	// Limit the Max Amount for the Frequency Input
	$('.bc-modal-frequency-count').on('keyup', function (e) {
		var result = ($(this).val() - Math.floor($(this).val())) !== 0;
		if (result) {
			var maxChars = 0;
		} else {
			var maxChars = 2;
		}
		if ($(this).val().length > maxChars) {
			$(this).val($(this).val().substr(0, maxChars));
			e.preventDefault();
		}
	});
	// Add Event to Calendar
	$('.bc-modal-add, .bc-modal-update').on('click', function () {
		var type = $('.bc-modal-type button.bc-selected').html();
		var name = $('#bcModalDayName').val();
		var amount = $('#bcModalDayAmount').val();
		var repeat = $('input[name=bc-modalRepeat]:checked').val();
		var frequency = $('#bcModalDayFrequency').val();
		var dayDate = $('#bcModalDay').data('dayDate');
		// Assign handlers immediately after making the request,
		// and remember the jqXHR object for this request
		var jqxhr = $.ajax({
			method: 'POST',
			url: 'ajax.cfm/add',
			data: {
				type: type,
				name: name,
				amount: amount,
				repeat: repeat,
				frequency: frequency,
				dayDate: dayDate
			},
			dataType: 'json'
		})
			.done(function (data) {
				console.log("Debug:");
				//data = JSON.parse()
				console.log(data);
				console.log(data.ERRORS.length);
				if (data.ERRORS.length > 0) {
					//display errors
				} else {
					//add the entry to the table and recalculate       
					$(".bc-calendar-week").find(".bc-calendar-day[data-date='" + dayDate + "'] .bc-calendar-day-events").prepend(data.entry);
				}
				//add the entry to the calendar.
				//trigger recalculation.
			})
			.fail(function () {
				console.log('error');
			})
			.always(function () {
				console.log('complete');
			});
		// Perform other work here ...
		// Set another completion function for the request above
		jqxhr.always(function () {
			console.log('second complete');
			$('#bcModalDay').addClass('hidden');
		});
		//ajax call
	});
	// Edit Event on the Calendar
	function editEvent() {
		$('.bc-calendar-day .bc-calendar-day-events .badge:not(.badge-total), .bc-mobile-list .badge:not(.badge-total)').on('click', function () {
			// Snap the Modal to the top of the scroll position
			modalSnapToTop();
			// Reset Event Modal
			modalDayReset();
			// Change 'Add' to 'Update'
			$('.bc-modal-add').removeClass('bc-modal-faded').removeClass('bc-modal-add').addClass('bc-modal-update').text('Update');
			// Grab Event Date
			var dayDate = $(this).closest('.bc-calendar-day').data('date');
			var formatDate = moment(dayDate).format('dddd, MMMM Do, YYYY');
			$('#bcModalDay').data('dayDate', dayDate);
			// Show Date
			$('#bcModalDayTitle').text(formatDate);
			// Un-fade values
			$('#bcModalDay .bc-modal-form .bc-modal-faded').removeClass('bc-modal-faded');
			// Add Current Event Values
			var type = $(this).data('type');
			var name = $(this).find('.item').text();
			var amount = $(this).find('.price').text();
			var repeat = $(this).data('repeat');
			var frequency = $(this).data('frequency');
			var dayDate = $(this).closest('.bc-calendar-day').data('date');
			$('.bc-modal-type button').each(function () {
				var buttonText = $(this).text();
				if (type == buttonText) {
					$(this).addClass('bc-selected');
				}
			});
			$('#bcModalDayName').val(name);
			$('#bcModalDayAmount').val(amount);
			$('.bc-modal-repeat-items .form-check-input').each(function () {
				var labelName = $(this).next('.form-check-label').text();
				if (repeat == labelName) {
					$(this).prop('checked', true);
				}
			});
			$('#bcModalDayFrequency').val(frequency);
			// Show Modal
			$('#bcModalDay').removeClass('hidden');
		});
	}
	editEvent();

	// Bootstrap 4 Tooltip
	//$('[data-toggle="tooltip"]').tooltip();

	// Close Mobile List
	$('.bc-mobile-list-close, .bc-modal-close').on('click', function () {
		$('.bc-mobile-list').addClass('hidden');
		// Remove selected day if selected
		$('.bc-calendar-day').removeClass('bc-mobile-day-selected');
	});

	// Mobile Only (768px and below)
	$(window).on('resize', function () {
		if ($(window).outerWidth() <= 768) {
			// Snap the Modal to the top of the scroll position
			modalSnapToTop();
			// Cover the day on the calendar to prevent unwanted taps
			if (!$('.bc-calendar-day .bc-calendar-day-mobile-cover').length) {
				$('.bc-calendar-day').append(`<div class="bc-calendar-day-mobile-cover"></div>`);
			}
			// Tap on Calendar Day to see the events in list view
			$('.bc-calendar-day').on('click', function () {
				// Grab the current days date
				var dayDate = $(this).data('date');
				var formatDate = moment(dayDate).format('dddd, MMMM Do, YYYY');
				$('.bc-mobile-list-date').text(formatDate);
				// Remove selected border from all days
				$('.bc-calendar-day').removeClass('bc-mobile-day-selected');
				// Add selected border to tapped day
				$(this).addClass('bc-mobile-day-selected');
				// Find Events of tapped day
				var dayEvents = $(this).find('.bc-calendar-day-events').html();
				// Empty out the mobile list events
				$('.bc-mobile-list-items').html('');
				// Populate the list with events from tapped day
				$('.bc-mobile-list-items').html(dayEvents);
				$('.bc-mobile-list-items').attr('data', dayDate);
				// Income from tapped day, then add it to the list at the top
				var dayIncome = $(this).find('.bc-calendar-day-income-wrap').html();
				$('.bc-mobile-list-items').prepend(dayIncome);
				// Show the list if there's something in there
				$('.bc-mobile-list-items').parent().removeClass('hidden');
				// Envoke the click event for editEvent
				editEvent();
			});
			// Invoke the Add Event Modal from the Mobile List Add Button
			$('.bc-mobile-list-add').on('click', function () {
				// Snap the Modal to the top of the scroll position
				modalSnapToTop();
				// Hide the current Mobile List
				$('.bc-mobile-list').addClass('hidden');
			});
		} else {
			// Remove the day cover for desktop
			$('.bc-calendar-day-mobile-cover').remove();
		}
	}).resize();

});