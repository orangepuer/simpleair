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

function initCalendar(reservedDates) {
  let unavailableDates = [];

  function checkDate(date) {
    dayMonthYear = date.getDate() +  '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

    return [!unavailableDates.includes(dayMonthYear)]
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
    }
  });

  $('#reservation_end_date').datepicker({
    dateFormat: 'dd-mm-yy',
    minDate: 0,
    maxDate: '3m',
    beforeShowDay: checkDate,
    onSelect: function (selected) {
      $('#reservation_start_date').datepicker('option', 'maxDate', selected);
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