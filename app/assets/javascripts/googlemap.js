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

function routing(){
navigator.geolocation.watchPosition(successCallback, errorCallback);

function successCallback(position) {

    var lat = position.coords.latitude;
    var lng = position.coords.longitude;

var o_std = new L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '<a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
});

var map = L.map('map', {
    center: [lat,lng],
    zoom: 17,
    zoomControl: false,
    layers: [o_std]
});

  var mapMarker = L.marker([lat, lng], { title: '現在地' }).addTo(map);

L.Routing.control({
    waypoints: [
        L.latLng(lat,lng),
        L.latLng(35.766149, 140.384623)
    ],
}).addTo(map)
}

function errorCallback(error) {
    alert("位置情報取得に失敗しました。");
}
}
