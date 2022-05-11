$(document).on("turbolinks:load", function(){
  $(".posts-index-button").click(function(){
    $(".favorites-index").hide();
    $(".posts-index").show();
  });
  $(".favorites-index-button").click(function(){
    $(".posts-index").hide();
    $(".favorites-index").show();
  });
});
