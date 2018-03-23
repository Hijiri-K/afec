  function getPosition() {
    console.log('gps')
    // 現在地を取得
    navigator.geolocation.getCurrentPosition(
      // 取得成功した場合
      function(position) {

          lat = position.coords.latitude;
          lng = position.coords.longitude;
          // alert("緯度:"+lat+",経度"+lng);
        $('.lat').val(lat);
        $('.lng').val(lng);
        // $('.gps').addClass("fa fa-location-arrow").text(" Ready");

        if (35.757776 <= lat && lat <= 35.781182 && 140.380987 <= lng && lng <= 140.393842) {
        // if (30 <= lat && lat <= 40 && 120 <= lng && lng <= 150) {
          airport = "Narita";
        }else{
          airport = "Out of Service";
          alert("afec is not available in your place.\nRedirect to mypage.");
          location.href = '/users/history';
        };

        $('.airport').val(airport);
          $(function() {
              $('.exchange-show').click( function() {
                if ($('input[name=sample1radio]:checked').val() === 'outside'){
                  var securityArea = 'OUT'
                }else{
                  var securityArea = 'IN'
                }
              var terminal = $('#terminal').val()
              $('.airport2').val(airport);
              $('.terminal2').val(terminal);
              $('.security_area').val(securityArea);
              console.log(terminal)
            });
          });
      },
      // if failed
      function(error) {
        switch(error.code) {
          case 1: //PERMISSION_DENIED
            alert("Request for location information was denieded");
            break;
          case 2: //POSITION_UNAVAILABLE
            alert("Location information is unavailable.");
            break;
          case 3: //TIMEOUT
            alert("The request to get user location timed out.");
            break;
          default:
            alert("An unknown error occurred.(error code:"+error.code+")");
            break;
        }
      }
      // ,{enableHighAccuracy:true;}
    );

// setInterval(getPosition, 5000); //5秒おきに現在地を取得

}
