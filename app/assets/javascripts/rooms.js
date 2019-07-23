function initMap(lat, lng) {
  var myCoords = new google.maps.LatLng(lat, lng);
  var mapOptions = {
    center: myCoords,
    zoom: 14
  };

  var googleMap = document.getElementById('map');

  if (googleMap) {
    var map = new google.maps.Map(googleMap, mapOptions);
  }

  var marker = new google.maps.Marker({
    position: myCoords,
    map: map
  });
}

function initCalendar(reservedDates, price) {
  let unavailableDates = [];

  function checkDate(date) {
    dayMonthYear = date.getDate() +  '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

    return [!unavailableDates.includes(dayMonthYear)]
  }

  function validateDate(userStartDate, userEndDate) {
    let isDateValid = true;

    reservedDates.forEach(function (value) {
      let reservedStartDate = new Date(new Date(value.start_date) - new Date(3*1000*60*60));
      let reservedEndDate = new Date(new Date(value.end_date) - new Date(3*1000*60*60));

      if (userStartDate < reservedStartDate && userEndDate > reservedEndDate) {
        isDateValid = false;
      }
    });

    return isDateValid
  }

  function getNumberOfDays(userStartDate, userEndDate) {
    let days = (userEndDate - userStartDate)/1000/60/60/24 + 1;

    return days
  }
  
  function showDetailsReservation(countDays) {
    if (countDays > 0) {
      $('#btn-reservation').attr('disabled', false);
      $('#reservation_nights').text(countDays);
      $('#reservation_total').text(countDays * price);
    }

    $('#error-message').text('');
    $('#preview').show();
  }

  function hideDetailsReservation() {
    $('#error-message').text('These dates are not unavailable');
    $('#preview').hide();
    $('#btn-reservation').attr('disabled', true);
  }

  function changeCalendar(isDateValid, countDays) {
    if (isDateValid) {
      showDetailsReservation(countDays);
    } else {
      hideDetailsReservation();
    }
  }

  reservedDates.forEach(function (value) {
    for(let day = new Date(value.start_date); day <= new Date(value.end_date); day.setDate(day.getDate() + 1)) {
      unavailableDates.push($.datepicker.formatDate('d-m-yy', day));
    }
  });

  $('#reservation_start_date').datepicker({
    dateFormat: 'dd-mm-yy',
    minDate: 0,
    maxDate: '3m',
    beforeShowDay: checkDate,
    onSelect: function (selected) {
      $('#reservation_end_date').datepicker('option', 'minDate', selected);
      $('#reservation_end_date').attr('disabled', false);

      let userStartDate = $('#reservation_start_date').datepicker('getDate');
      let userEndDate = $('#reservation_end_date').datepicker('getDate');
      let isDateValid = validateDate(userStartDate, userEndDate);
      let countDays = 0;

      if (userEndDate) {
        countDays = getNumberOfDays(userStartDate, userEndDate);
      }

      changeCalendar(isDateValid, countDays);
    }
  });

  $('#reservation_end_date').datepicker({
    dateFormat: 'dd-mm-yy',
    minDate: 0,
    maxDate: '3m',
    beforeShowDay: checkDate,
    onSelect: function (selected) {
      $('#reservation_start_date').datepicker('option', 'maxDate', selected);

      let userStartDate = $('#reservation_start_date').datepicker('getDate');
      let userEndDate = $('#reservation_end_date').datepicker('getDate');
      let isDateValid = validateDate(userStartDate, userEndDate);
      let countDays = getNumberOfDays(userStartDate, userEndDate);

      changeCalendar(isDateValid, countDays);
    }
  });
}

document.addEventListener("turbolinks:before-cache", function() {
  $.datepicker.dpDiv.remove();

  for (let element of Array.from(document.querySelectorAll("input.hasDatepicker"))) {
    $(element).datepicker("destroy");
  }
});

document.addEventListener("turbolinks:before-render", function() {
  $.datepicker.dpDiv.appendTo(event.data.newBody);
});

document.addEventListener("DOMContentLoaded", function() {
  $('.review-stars').each(function () {
    let reviewStar = $(this).data('reviewStar');

    $(this).raty({
      path: '/assets',
      readOnly: true,
      score: reviewStar
    });
  });

  let averageRating = $('#average-rating');

  if (averageRating) {
    averageRating.raty({
      path: '/assets',
      readOnly: true,
      score: averageRating.data('averageRating')
    });
  }

  $('#start_date').datepicker({
    dateFormat: 'dd-mm-yy',
    minDate: 0,
    maxDate: '3m',
    onSelect: function (selected) {
      $('#end_date').datepicker('option', 'minDate', selected);
      $('#end_date').attr('disabled', false);
    }
  });

  $('#end_date').datepicker({
    dateFormat: 'dd-mm-yy',
    minDate: 0,
    maxDate: '3m',
    onSelect: function (selected) {
      $('#start_date').datepicker('option', 'maxDate', selected);
    }
  });
});

document.addEventListener("turbolinks:load", function() {
  $('.guest-review-stars').raty({
    path: '/assets',
    scoreName: 'guest_review[star]',
    score: 1
  });

  $('.host-review-stars').raty({
    path: '/assets',
    scoreName: 'host_review[star]',
    score: 1
  });

  let isFilterOpen = false;

  $('#filter').click(function () {
    if(isFilterOpen) {
      $('#filter').html('More filters <i class="fa fa-chevron-down"></i>')
    } else {
      $('#filter').html('More filters <i class="fa fa-chevron-up"></i>')
    }

    isFilterOpen = !isFilterOpen
  });
});