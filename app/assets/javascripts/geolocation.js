window.Glyphbase = window.Glyphbase || {};
window.Glyphbase.Geo = (function() {

  function trackPosition(callback) {
    var positionFound = false;
    var latitude,
        longitude;

    if(navigator.geolocation) {

      navigator.geolocation.getCurrentPosition(
        function(position) {
          if(!positionFound) {
            positionFound = true;
            latitude  = position.coords.latitude;
            longitude = position.coords.longitude;
            callback(latitude, longitude);
          }
        }
      );

      navigator.geolocation.watchPosition(
        function(position) {
          positionFound = true;
          latitude  = position.coords.latitude;
          longitude = position.coords.longitude;
          callback(latitude, longitude);
        }
      );
    } // End if(navigator.geolocation)
  }// End trackPosition()

  return {
    trackPosition: trackPosition
  };

}());