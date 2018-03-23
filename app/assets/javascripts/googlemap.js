// $(document).ready(function(){
function routing(){
// Open layer用

var cafeLat = Math.round($('#cafe_lat').val());
var cafeLng = Math.round($('#cafe_lng').val());

var extent = [0, 0, 5000, 5000];
     var projection = new ol.proj.Projection({
       code: 'xkcd-image',
       units: 'pixels',
       extent: extent
     });

     var map = new ol.Map({
       layers: [
         new ol.layer.Image({
           source: new ol.source.ImageStatic({
             // attributions: '© <a href="http://xkcd.com/license.html">xkcd</a>',
             url: $('#floor_maps').val(),
             // url:'../map_narita_terminal2_f4.png',
             projection: projection,
             imageExtent: extent
           })
         })
       ],
       target: 'map',
       view: new ol.View({
         projection: projection,
         center: ol.extent.getCenter(extent),
         zoom: 1.2,
         maxZoom: 8,
         rotation: $('#rotations').val()
       })
     });

  var view = new ol.View({
    center: [0, 0],
    zoom: 2
  });

  var geolocation = new ol.Geolocation({
    projection: view.getProjection()
  });

  function el(id) {
    return document.getElementById(id);
  }

    geolocation.setTracking(true);
  // el('track').addEventListener('change', function() {
  //   geolocation.setTracking(this.checked);
  // });

  // update the HTML page when the position changes.
  geolocation.on('change', function() {
    // el('lat').innerText =  ol.proj.transform(geolocation.getPosition(), 'EPSG:3857', 'EPSG:4326')[0]
    // el('lng').innerText =  ol.proj.transform(geolocation.getPosition(), 'EPSG:3857', 'EPSG:4326')[1]
    // el('pixLat').innerText = pixCoordinates[0]
    // el('pixLng').innerText = pixCoordinates[1]
  });

  // handle geolocation error.
  geolocation.on('error', function(error) {
    var info = document.getElementById('info');
    info.innerHTML = error.message;
    info.style.display = '';
  });

  var accuracyFeature = new ol.Feature();
  geolocation.on('change:accuracyGeometry', function() {
    accuracyFeature.setGeometry(geolocation.getAccuracyGeometry());
    console.log(geolocation.getAccuracyGeometry())
  });

  var positionFeature = new ol.Feature();
  positionFeature.setStyle(new ol.style.Style({
    image: new ol.style.Circle({
      radius: 8,
      fill: new ol.style.Fill({
        color: '#3399CC'
      }),
      stroke: new ol.style.Stroke({
        color: '#fff',
        width: 2
      })
    })
  }));

  var iconFeature = new ol.Feature();
  iconFeature.setStyle(new ol.style.Style({
    image: new ol.style.Icon({
      anchor: [0.5,0.95],
      src: '../meet_up_here3.png'
    })
  }));

  geolocation.on('change:position', function() {
    var coordinates = geolocation.getPosition();
    coordinates = ol.proj.transform(coordinates, 'EPSG:3857', 'EPSG:4326')


    // var centerLat = 35.764116
    // var centerLng = 140.384421

    // 35.764116, 140.384421

    var centerLat = $('#center_lat').val()
    var centerLng = $('#center_lng').val()


    // var currentLat = (1/0.0090133729745762*1000)*coordinates[1] - (1/0.0090133729745762*1000)*centerLat + 500
    // var currentLng = (1/0.010966404715491394*1000)*coordinates[0]- (1/0.010966404715491394*1000)*centerLng + 500

    pixByLat = (1/0.0090133729745762*1000);
    pixByLng = (1/0.010966404715491394*1000);



    var currentLat = (pixByLat*coordinates[1] - pixByLat*centerLat)*10 + cafeLng;
    var currentLng = (pixByLng*coordinates[0] - pixByLng*centerLng)*10 + cafeLat;

    pixCoordinates = [currentLng, currentLat];
    positionFeature.setGeometry(pixCoordinates ?
      new ol.geom.Point(pixCoordinates) : null);
      console.log(pixCoordinates)
  });



  // var iconPosition = [1755,2273]
  var iconPosition = [cafeLat,cafeLng]
  iconFeature.setGeometry(iconPosition ?
    new ol.geom.Point(iconPosition) : null);
    console.info(iconPosition)

  new ol.layer.Vector({
    map: map,
    source: new ol.source.Vector({
      features: [positionFeature, iconFeature]
    })
  });
// });
}
