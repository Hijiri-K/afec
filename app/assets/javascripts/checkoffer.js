$(function(){
    setInterval(function(){
      $.ajax({
          url: "/posts/checkoffer",
          type: "post",

          success: function(responce) {
            // alert("ok");
          },
          error: function(xhr) {
            // alert("error");
          }
      });
    },5000);
});
