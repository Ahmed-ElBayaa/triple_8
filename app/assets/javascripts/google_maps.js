var marker;

function initializeMap(lat, lng){	

	var	cntr = new google.maps.LatLng(lat, lng);
	
	var mapProp = { 
		center: cntr,
    zoom:4,
    panControl:false,
    zoomControl:true,
    mapTypeControl:false,
    scaleControl:false,
    streetViewControl:false,
    overviewMapControl:false,
    rotateControl:false,    
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

	var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);

	  marker = new google.maps.Marker({
		position: cntr,
		map: map,
		draggable: true,
		raiseOnDrag: false,
		icon: new google.maps.MarkerImage('/pinkball.png',
			new google.maps.Size(48, 48))
	});

	google.maps.event.addListener(map, 'click', function(event) {
		var location = event.latLng
  	marker.setPosition(location)
  	codeLatLng(marker)
  });
}

function codeLatLng(marker) {
		var geocoder = new google.maps.Geocoder();
    var lat =  marker.position.lat();
    var lng =  marker.position.lng();
    var latlng = new google.maps.LatLng(lat, lng);
    geocoder.geocode({'latLng': latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
      	var l = results.length;
      	var i = l-1 ;
      	if(l > 2){
      		i = l - 3
      	}
      	result = results[i].formatted_address+"\n"
        for (var i=0; i<l; i++) {
        	result += results[i].formatted_address + "\n"
        }
        alert(result)
      } else {
        alert("Geocoder failed due to: " + status);
      }
    });
}

$(function(){
	var form = $("[id*=_classified]");

	form.submit(function(){
		document.getElementById('classified_latitude').value = marker.position.lat();
	  document.getElementById('classified_longitude').value = marker.position.lng();
  })

  form.children(".control-group").css({'display': 'inline'})
});