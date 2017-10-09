// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  $('.login-show').click(function(){

    $('#login-modal').fadeIn();
  });

  $('.signup-show').click(function(){

    $('#signup-modal').fadeIn();
  });

  $('.close-modal').click(function(){
    $('#login-modal').fadeOut();
    $('#signup-modal').fadeOut();
  });



// 現在地取得===================================================================
  $('.form-control').click(
    // Geolocation APIに対応している
    // if (navigator.geolocation) {
    //   alert("この端末では位置情報が取得できます");
    // // Geolocation APIに対応していない
    // } else {
    //   alert("この端末では位置情報が取得できません");
    // }

    function getPosition() {
      // 現在地を取得
      navigator.geolocation.getCurrentPosition(
        // 取得成功した場合
        function(position) {

            lat = position.coords.latitude;
            lng = position.coords.longitude;
            // alert("緯度:"+lat+",経度"+lng);
          $('.lat').val(lat);
          $('.lng').val(lng);
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
      );

    // $("div#source_form").click(function(){
    //   $.ajax({
    //     url: "sources/set_content",
    //     type: "GET",
    //     data: {content : $("div#editor").text()},
    //     datatype: "html",
    //     success: function(data){
    //       //成功時の処理
    //     },
    //     error: function(data){
    //       //失敗時の処理
    //     }
    //   });
    // });
    //
  });

// 通貨換算==================================================================================================

    $(function() {
        $('.form-control').change( function(e) {

            // 表示の初期化
            $('#code').empty();
            $("#code_base").empty();
            $('#code2').empty();
            $('#update').empty();
            $('#rate').empty();
            $('#example1').empty();
            $('#exampleYen1').empty();


            e.preventDefault();     // hrefが無効になり、画面遷移が行わない

            selectedCode = $('#Currency').val();  // 選択した通貨(value)
            selectedCode_base = $('#Currency_base').val()      //===========================================================================================================-自分でアレンジ
            selectedCodeText = $('#Currency option:selected').text();// 選択した通貨(key)
            selectedCode_baseText = $('#Currency_base option:selected').text();  //================================
            // var url = 'http://api.aoikujira.com/kawase/get.php?format=jsonp2&callback=json&to=jpy&code=' + selectedCode; //元のこーど
            var url = 'http://api.aoikujira.com/kawase/get.php?format=jsonp2&callback=json&code=' + selectedCode;  //====================================自分でアレン

            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'jsonp',
                success: function(json) {
                    update = json.update;           // アップデート日時
                    if (selectedCode_base === 'jpy'){
                    rate = json.JPY;
                    }else if (selectedCode_base === 'eur') {
                      rate = json.EUR;
                    } else if (selectedCode_base === 'usd') {
                      rate = json.USD;
                    }else{
                      rate = 1;
                    }     // 選択した通貨の対日本円レート(JPYは固定)``

                    example1 = 300;                 // サンプル
                    exampleYen1 = example1 * rate;  // サンプル計算

                    $("#code").append(selectedCodeText.toUpperCase());
                    $("#code_base").append(selectedCode_baseText.toUpperCase());
                    $("#code2").append(selectedCodeText.toUpperCase());
                    $("#update").append(update);
                    $("#rate").append(rate);
                    $("#example1").append(example1);
                    $("#exampleYen1").append(exampleYen1);

                    calc();
                }
            });
      })


        // Convertボタン 押下後処理
            function calc() {
          // $('#message').click( function(e) {
          //
          //   e.preventDefault();     // hrefが無効になり、画面遷移が行わない

            var inputCurrency = $('#currency').val();   // input通貨

            // 計算
            if (inputCurrency !== '') {
                var ansJpy = rate * inputCurrency;      // 計算
                ansJpy = Math.floor(ansJpy);            // 小数点切り捨て
                // ansJpy = insertComma(ansJpy);           // 3桁カンマ追加
                // $('#returnYen').text(ansJpy + selectedCode_baseText);   // 結果の表示
                $('#returnYen').val(ansJpy + selectedCode_baseText);
            }
        // })


      }



        // リセットボタン押下処理
        $('#resetButton').click(function(){
            $('#returnYen').text("Result");
        });
    });

    /**
     * 3桁のカンマ区切りの値をセット
     *
     */
    function insertComma(num) {
        return String(num).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
    }



  });
