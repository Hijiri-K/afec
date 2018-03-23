// $(document).ready(
  // Geolocation APIに対応している
  // if (navigator.geolocation) {
  //   alert("この端末では位置情報が取得できます");
  // // Geolocation APIに対応していない
  // } else {
  //   alert("この端末では位置情報が取得できません");
  // }
  $(function getPosition() {
    // 現在地を取得
    navigator.geolocation.getCurrentPosition(
      // 取得成功した場合
      function(position) {

          lat = position.coords.latitude;
          lng = position.coords.longitude;
          // alert("緯度:"+lat+",経度"+lng);
        $('.lat').val(lat);
        $('.lng').val(lng);
        $('.gps').addClass("fa fa-location-arrow").text(" Ready");

        if (30 <= lat && lat <= 40 && 120 <= lng && lng <= 150) {
          airport = "Narita";
        }else{
          airport = "Out of Airport";
        }

    ;

        $('.airport').val(airport);
          $(function() {
              $('.exchange-show').click( function() {
                if ($('input[name=sample1radio]:checked').val() === 'outside'){
                  var securityArea = 'OUT'
                }else{
                  var securityArea = 'IN'
                }
              var terminal = $('#terminal').val() + securityArea
              $('.airport2').val(airport);
              $('.terminal2').val(terminal);
              console.log(terminal)
            });
          });
      },
      // 取得失敗した場合
      function(error) {
        switch(error.code) {
          case 1: //PERMISSION_DENIED
            alert("位置情報の利用が許可されていません");
            break;
          case 2: //POSITION_UNAVAILABLE
            alert("現在位置が取得できませんでした");
            break;
          case 3: //TIMEOUT
            alert("タイムアウトになりました");
            break;
          default:
            alert("その他のエラー(エラーコード:"+error.code+")");
            break;
        }
      }
      // ,{enableHighAccuracy:true;}
    );

// setInterval(getPosition, 5000); //5秒おきに現在地を取得

}
);
