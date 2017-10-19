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
//= require jquery.turbolinks
//= require turbolinks
// = require_tree .

//エラー防止のためjquery.turbolinksとturbolinksのgemを無効化中

$(document).ready(function(){

  $('.login-show').click(function(){
    $('#login-modal').fadeIn();
  });

  $('.signup-show').click(function(){
    $('#signup-modal').fadeIn();
  });

  $('.exchange-show').click(function(){
    $('#exchange-modal').fadeIn();
  });

  $('.close-modal').click(function(){
            $('#login-modal').fadeOut();
            $('#signup-modal').fadeOut();
            $('#exchange-modal').fadeOut();
            $('#show-modal').fadeOut();
  });



  $('td').click(function(){
      $('#show-modal').fadeIn();
        var postmessageshow = $(this).find('.postmessage').text();
            getshow = $(this).find('.getinfo').text();
            giveshow = $(this).find('.giveinfo').text();
            saveshow = $(this).find('.saveinfo').text();
            coffeeshow = $(this).find('.coffeeinfo').html();
            postusernameshow = $(this).find('.post-user-name').html();
            postid = $(this).find('.postid').text();

            $('#postmessageshow').text(postmessageshow);
            $('#getshow').text(getshow);
            $('#giveshow').text(giveshow);
            $('#saveshow').text(saveshow);
            $('#coffeeshow').html(coffeeshow);
            $('#post-user-name-show').html(postusernameshow);

        $('#offersubmit').click(function(){
            $.ajax({
                url: "/posts/offer",
                type: "post",
                data: {id: postid},
                success: function(responce) {
                  var postmessageshow = null
                      getshow = null
                      giveshow = null
                      saveshow = null
                      coffeeshow = null
                      postusernameshow = null
                      postid = null
            },
            error: function(xhr) {
                // alert("errror");
            }
            });
          });
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
          $('.gps').addClass("fa fa-location-arrow").text(" Ready");
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

  setInterval(getPosition, 5000); //5秒おきに現在地を取得
  }
);

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


//レートテスト
//================================================================================================================================================================================================
            // var url = 'http://api.aoikujira.com/kawase/get.php?format=jsonp2&callback=json&code=' + selectedCode;  //====================================自分でアレン
            //
            // $.ajax({
            //     url: url,
            //     type: 'GET',
            //     dataType: 'jsonp',
            //     success: function(json) {
            //         update = json.update;           // アップデート日時
            //         if (selectedCode_base === 'jpy'){
            //         rate = json.JPY;
            //         }else if (selectedCode_base === 'eur') {
            //           rate = json.EUR;
            //         } else if (selectedCode_base === 'usd') {
            //           rate = json.USD;
            //         }else{
            //           rate = 1;
            //         }

            // example1 = 300;                 // サンプル
            // exampleYen1 = example1 * rate;  // サンプル計算

            // $("#code").append(selectedCodeText.toUpperCase());
            // $("#code_base").append(selectedCode_baseText.toUpperCase());
            // // $("#code2").append(selectedCodeText.toUpperCase());
            // $("#update").append(update);
            // $("#rate").append(rate);
            // $("#example1").append(example1);
            // $("#exampleYen1").append(exampleYen1);
            //
            // calc();
// }

//==有料のAPI======================================================================================================================================================================================================
// set endpoint and your access key
endpoint = 'convert';
access_key = '356b689f4db8b2616a786c31a7023829';
inputCurrency = $('#currency').val();
// define from currency, to currency, and amount
from = selectedCode;
to = selectedCode_base;
amount = inputCurrency;

// execute the conversion using the "convert" endpoint:
$.ajax({
    url: 'https://apilayer.net/api/' + endpoint + '?access_key=' + access_key +'&from=' + from + '&to=' + to + '&amount=' + amount,
    // "http://apilayer.net/api/convert?access_key=356b689f4db8b2616a786c31a7023829&from=jpy&to=usd&amount=5000"
    dataType: 'jsonp',
    success: function(json) {

        // access the conversion result in json.result
        ansJpy = json.result
        ansJpy = Math.floor(ansJpy);

        $('#returnYen').val(ansJpy + selectedCode_baseText);
    }


//============================================================================================================================================================================================================


            })
      })

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
      }

        // リセットボタン押下処理
        $('#resetButton').click(function(){
            $('#returnYen').text("Result");
        });
    });


    //  3桁のカンマ区切りの値をセット
    function insertComma(num) {
        return String(num).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
    }


    $('.show-show').click(function showshow() {
      get = $('.getinfo').text();
      give = $('.giveinfo').text()
      $('#gettest').text(get);
      $('#givetest').text(give);
      });


  // $(function(){
  //     setInterval(function(){
  //       $.ajax({
  //           url: "/posts/checkoffer",
  //           type: "post",
  //
  //           success: function(responce) {
  //             // alert("ok");
  //           },
  //           error: function(xhr) {
  //             // alert("error");
  //           }
  //       });
  //     },5000);
  // });
});
