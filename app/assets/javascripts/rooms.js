function initMap(room) {
  let myCoords = new google.maps.LatLng(room.latitude, room.longitude);
  let mapOptions = {
    center: myCoords,
    zoom: 14
  };
  let googleMap = document.getElementById('map');

  if (googleMap) {
    let map = new google.maps.Map(googleMap, mapOptions);

    addMarker(room, map)
  }
}

function initMapWithRooms(rooms) {
  let myCoords;

  if (rooms.length > 0) {
    myCoords = new google.maps.LatLng(rooms[0].latitude, rooms[0].longitude);
  } else {
    myCoords = new google.maps.LatLng(37.7792808, -122.4192363);
  }

  let mapOptions = {
    center: myCoords,
    zoom: 14
  };
  let googleMap = document.getElementById('map');

  if (googleMap) {
    let map = new google.maps.Map(googleMap, mapOptions);

    rooms.forEach(function (room) {
      addMarker(room, map)
    })
  }
}

function addMarker(room, map) {
  new google.maps.Marker({
    position: new google.maps.LatLng(room.latitude, room.longitude),
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

  let averageRatings = $('.average-ratings');

  averageRatings.each(function () {
    $(this).raty({
      path: '/assets',
      readOnly: true,
      score: $(this).data('averageRating')
    });
  });
});

document.addEventListener("turbolinks:load", function() {
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

  let sliderRange = $('#slider-range');

  if (sliderRange) {
    let priceGreaterThan = $('#q_price_gteq').val('50');
    let pricelessThan = $('#q_price_lteq').val('700');

    sliderRange.slider({
      range: true,
      min: 0,
      max: 1500,
      values: [50, 700],
      slide: function(event, ui) {
        priceGreaterThan.val(ui.values[0]);
        pricelessThan.val(ui.values[1]);
      }
    });

    $('.ui-widget-header').css('background', '#00A699');
    $('.ui-state-default, .ui-widget-content').css('background', 'white');
    $('.ui-state-default, .ui-widget-content').css('border-color', '#00A699');
  }

  $(document).on("turbolinks:load", function(){
    $('#autogeocomplete').geocomplete();
  });
});