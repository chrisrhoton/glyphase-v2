window.Glyphbase = window.Glyphbase || {};
window.Glyphbase.Geo = (function() {

  function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
  }

  function readCookie(name) {
      var nameEQ = name + "=";
      var ca = document.cookie.split(';');
      for(var i=0;i < ca.length;i++) {
          var c = ca[i];
          while (c.charAt(0)==' ') c = c.substring(1,c.length);
          if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
      }
      return null;
  }

  function eraseCookie(name) {
      createCookie(name,"",-1);
  }

  function trackPosition(callback) {
    var positionFound = false;
    var latitude, longitude;
    var latCookieName = "user_lat";
    var lngCookieName = "user_lng";

    if(navigator.geolocation) {

      navigator.geolocation.getCurrentPosition(
        function(position) {
          if(!positionFound) {
            positionFound = true;
            latitude  = position.coords.latitude;
            longitude = position.coords.longitude;
            createCookie(latCookieName, latitude, 0);
            createCookie(lngCookieName, longitude, 0);
            callback(latitude, longitude);
          }
        }
      );

      navigator.geolocation.watchPosition(
        function(position) {
          positionFound = true;
          latitude  = position.coords.latitude;
          longitude = position.coords.longitude;
          createCookie(latCookieName, latitude, 0);
          createCookie(lngCookieName, longitude, 0);
          callback(latitude, longitude);
        }
      );
    } // End if(navigator.geolocation)
  }// End trackPosition()

  return {
    trackPosition: trackPosition
  };

}());