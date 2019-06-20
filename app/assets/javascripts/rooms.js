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

document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('#reservation_start_date').datepicker({
      dateFormat: 'dd-mm-yy'
    });

    $('#reservation_end_date').datepicker({
      dateFormat: 'dd-mm-yy'
    });
  });
});

document.addEventListener("turbolinks:before-cache", function() {
  $.datepicker.dpDiv.remove();

  for (let element of Array.from(document.querySelectorAll("input.hasDatepicker"))) {
    $(element).datepicker("destroy");
  }
});

document.addEventListener("turbolinks:before-render", function() {
  $.datepicker.dpDiv.appendTo(event.data.newBody);
});