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
//= require_tree

//エラー防止のためjquery.turbolinksとturbolinksと require_treeのgemを無効化中

$(document).ready(function(){


  $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
});

// 未投稿時にモーダル表示
  if($('.mypost-status').text() == ""){
    $('#location-modal').fadeIn();
  };

  $('.offer-decline').on("click", function(){
    console.log("test");
    $(this).parents('.slide').hide()
    $('.offered').remove();
    $('.slideSet').css('width', $('.initial').width());
    $('.slideSet').animate({
      left: slideCurrent * slideNum
    });
    $('.offer-modal-wrapper-test').fadeOut();

  });

  $('.close-map').on('click', function(){
    $('.map-modal-wrapper').css('z-index', '-1');
    location.href="/users/history"
  })


  $('.login-show').click(function(){
    $('#login-modal').fadeIn();
  });

  $('.signup-show').click(function(){
    $('#signup-modal').fadeIn();
  });

  $('.exchange-show').click(function(){
    $('#exchange-modal').fadeIn();
  });

  $('.exchange-show2').click(function(){
    $('#exchange-modal2').fadeIn();
  });

  $('.location-show').click(function(){
    $('.location-modal-wrapper').fadeIn();
  });

  // $('.open-map').click(function(){
  //   $('#map-modal').fadeIn();
  // });



  $('.close-modal').click(function(){
            $('#login-modal').fadeOut();
            $('#signup-modal').fadeOut();
            // $('#exchange-modal').fadeOut();
            $('#show-modal').fadeOut();
            $('#map-modal').fadeOut();
            $('#location-modal').fadeOut();
            $('.location-modal-wrapper').fadeOut();
  });

  $('.close-modal2').click(function(){
            $('#exchange-modal').fadeOut();
  });

// actioncable投稿のモーダル表示（_messageに移行済み）

  // $('td').on('click',function(){
  //     $('#show-modal').fadeIn();
  //       var postmessageshow = $(this).find('.postmessage').text();
  //           getshow = $(this).find('.getinfo').text();
  //           giveshow = $(this).find('.giveinfo').text();
  //           saveshow = $(this).find('.saveinfo').text();
  //           coffeeshow = $(this).find('.coffeeinfo').html();
  //           postusernameshow = $(this).find('.post-user-name').html();
  //           myid = $(this).find('.myid').text();
  //           userid = $(this).find('.userid').text();
  //           postsavemoffer = $(this).find('.offer_save_amount').text();
  //           $('#postmessageshow').text(postmessageshow);
  //           $('#getshow').text(getshow);
  //           $('#giveshow').text(giveshow);
  //           $('#saveshow').text(saveshow);
  //           $('#coffeeshow').html(coffeeshow);
  //           $('#post-user-name-show').html(postusernameshow);
  //           $('#post-userid').text(userid);
  //           $('#post_offer_savemoffer').text(postsavemoffer);
  //           $('#post-myid').text(myid);
  //   });

        // $('#offfersubmit').click(function(){
        //     $.ajax({
        //         url: "/posts/offer",
        //         type: "post",
        //         // dataType: "html",
        //         data: {id: postid},
        //         success: function(responce) {
        //           var postmessageshow = null
        //               getshow = null
        //               giveshow = null
        //               saveshow = null
        //               coffeeshow = null
        //               postusernameshow = null
        //               postid = null
        //     },
        //     error: function(xhr) {
        //         alert("errror");
        //     }
        //     });
        //   });
        // });
        //

    $('.found-btn').on('click', function(){
      $.ajax({
        url: '/posts/successed_transaction',
        type: 'POST',
        data: {
          hoge:1
        },
      })
      .done(function(response){
        // Railsのアクションが正しく実行された時の処理
      })
      .fail(function(xhr){
        // Railsのアクションなどでエラーが発生した時の処理
      });
    })

    $('.not-found-btn').on('click', function(){
      $.ajax({
        url: '/posts/failed_transaction',
        type: 'POST',
        data: {
          hoge:1
        },
      })
    })


// スライダーのファンクション
  $(function() {
    $(".offer-modal-wrapper-test").on('touchstart', onTouchStart); //指が触れたか検知
    $(".offer-modal-wrapper-test").on('touchmove', onTouchMove); //指が動いたか検知
    $(".offer-modal-wrapper-test").on('touchend', onTouchEnd); //指が離れたか検知
    console.log();
    var direction, position;

    //スワイプ開始時の横方向の座標を格納
    function onTouchStart(event) {
      position = getPosition(event);
      direction = ''; //一度リセットする
    }

    //スワイプの方向（left／right）を取得
    function onTouchMove(event) {
      console.log(direction)
      if (position - getPosition(event) > 30) { // 70px以上移動しなければスワイプと判断しない
        direction = 'left'; //左と検知
      } else if (position - getPosition(event) < -30){  // 70px以上移動しなければスワイプと判断しない
        direction = 'right'; //右と検知
      }
    }

    function onTouchEnd(event) {
      console.log("end")
      moveNum = slideNum - 1
      if (direction == 'right'){
        slideCurrent--;
        sliding();
      } else if (direction == 'left'){
        slideCurrent++;
        sliding();
      }
    }

    //横方向の座標を取得
    function getPosition(event) {
      return event.originalEvent.touches[0].pageX;
    }
  });

});
