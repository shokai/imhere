$(function(){
  console.log('start');
  Location.onGet = function(loc){
    console.log(loc);
    console.log('https://maps.google.com/?ll='+loc.lat+','+loc.lon);
    Map.setLocation(loc);
  };
  $('[name=btn_update_location]').click(function(){
    console.log('update');
    Location.start();
  });
});

var Map = new (function(){
  var self = this;
  this.xpath = "#map";
  this.setLocation = function(loc){
    $('#location #lat .val').html(loc.lat);
    $('#location #lon .val').html(loc.lon);
    var map = '<iframe width="640" height="480" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/?ie=UTF8&amp;t=h&amp;ll='+loc.lat+','+loc.lon+'&amp;output=embed"></iframe>'
    $(self.xpath).html(map);
  };
})();

var Location = new (function(){
  var self = this;
  this.wid = null;
  this.onGet = null;
  this.start = function(){
    if(self.wid) return !!self.wid;
    self.wid = navigator.geolocation.watchPosition(function(e){
      var loc = {
        lat : e.coords.latitude,
        lon : e.coords.longitude,
        acc : e.coords.accuracy
      };
      if(typeof self.onGet === 'function') self.onGet(loc);
    });
    return !!self.wid;
  };
  this.stop = function(){
    navigator.geolocation.clearWatch(self.wid);
    self.wid = null;
  };
})();
