window.Glyphbase = window.Glyphbase || {};
window.Glyphbase.Glyphs = (function() {

  function displayNearby(latitude, longitude) {
    $.get('/nearby', 
      {lat: latitude, lng: longitude}, 
      function(glyphs) {
        var marker;
        glyphs.forEach(function(glyph) {
          marker = Glyphbase.Maps.addMarker(glyph.latitude, glyph.longitude, glyph.tagline);
          Glyphbase.Maps.addInfoWindowToMarker(marker, glyph);
        });
      }
    );
  };

  return {
    displayNearby: displayNearby
  };
}());