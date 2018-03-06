$(document).ready(function(){



// function initMap() {
//
//   var map = new google.maps.Map(document.getElementById('map'), {
//     // center: {lat: 35.839500, lng: 139.794899},
//     // center: {lat: 35.7644094, lng: 140.3834945},
//     zoom: 17,
//     // mapTypeId: 'satellite',
//     disableDefaultUI: true,
//     draggable: true
//
//   });
//   var Marker = new google.maps.Marker({map: map});//マーカーを青い点に変更予定（maps.Markerを変更すればできるはず？）
//
//
// // マーカーとしてフロアマップをカスタム
//   var narita = new google.maps.LatLng(35.7644094,140.3834945);
//   var doutor_narita = new google.maps.LatLng(35.766149, 140.384623);
//
//   // Try HTML5 geolocation.
//   if (navigator.geolocation) {
//     navigator.geolocation.watchPosition(function(position) {
//       var pos = {
//         lat: position.coords.latitude,
//         lng: position.coords.longitude
//       };
//
// // ルート描画用---------------------------------------------------------------------------------------
//       var request = {
//              origin: pos, // 出発地
//              destination: doutor_narita, // 目的地
//              travelMode: google.maps.DirectionsTravelMode.WALKING // 交通手段(歩行。DRIVINGの場合は車)
//          };
//
//
//          var d = new google.maps.DirectionsService(); // ルート検索オブジェクト
//          var r = new google.maps.DirectionsRenderer({ // ルート描画オブジェクト
//              map: map, // 描画先の地図
//              preserveViewport: true, // 描画後に中心点をずらさない
//          });
//          // ルート検索
//          d.route(request, function(result, status){
//              // OKの場合ルート描画
//              if (status == google.maps.DirectionsStatus.OK) {
//                  r.setDirections(result);
//              }
//          });
//
// // ----------------------------------------------------------------------------------------------------
//       Marker.setPosition(pos);
//       // infoWindow.setContent('Location found.');
//       map.setCenter(pos);
//     }, function() {
//       handleLocationError(true, infoWindow, map.getCenter());
//     });
//   } else {
//     // Browser doesn't support Geolocation
//     handleLocationError(false, infoWindow, map.getCenter());
//   }
//
// }
//
// function handleLocationError(browserHasGeolocation, infoWindow, pos) {
//   infoWindow.setPosition(pos);
//   infoWindow.setContent(browserHasGeolocation ?
//                         'Error: The Geolocation service failed.' :
//                         'Error: Your browser doesn\'t support geolocation.');
// }
//






// OSM用コード

// function routing(){
// navigator.geolocation.watchPosition(successCallback, errorCallback);
//
// function successCallback(position) {
//
//     var lat = position.coords.latitude;
//     var lng = position.coords.longitude;
//
// var o_std = new L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//     attribution: '<a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
// });
//
// var map = L.map('map', {
//     center: [lat,lng],
//     zoom: 17,
//     zoomControl: false,
//     layers: [o_std]
// });
//
//   var mapMarker = L.marker([lat, lng], { title: '現在地' }).addTo(map);
//
// L.Routing.control({
//     waypoints: [
//         L.latLng(lat,lng),
//         L.latLng(35.766149, 140.384623)
//     ],
// }).addTo(map)
// }
//
// function errorCallback(error) {
//     alert("位置情報取得に失敗しました。");
// }
// }



// Open layer用

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
             url: '../narita_map_f4_ver3.png',
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
         rotation: 2.092
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

    // var centerLat = 34.693591
    // var centerLng = 135.504256

    var centerLat = 35.837105
    var centerLng = 139.797005


    // var currentLat = (1/0.0090133729745762*1000)*coordinates[1] - (1/0.0090133729745762*1000)*centerLat + 500
    // var currentLng = (1/0.010966404715491394*1000)*coordinates[0]- (1/0.010966404715491394*1000)*centerLng + 500

    pixByLat = (1/0.0090133729745762*1000);
    pixByLng = (1/0.010966404715491394*1000);

    var currentLat = (pixByLat*coordinates[1] - pixByLat*centerLat)*10 + 2500;
    var currentLng = (pixByLng*coordinates[0] - pixByLng*centerLng)*10 + 2500;
//
    pixCoordinates = [currentLat, currentLng];
    positionFeature.setGeometry(pixCoordinates ?
      new ol.geom.Point(pixCoordinates) : null);
      console.log(pixCoordinates)
  });



  var iconPosition = [1755,2273]
  iconFeature.setGeometry(iconPosition ?
    new ol.geom.Point(iconPosition) : null);
    console.log(iconPosition)

  new ol.layer.Vector({
    map: map,
    source: new ol.source.Vector({
      features: [positionFeature, iconFeature]
    })
  });
});
