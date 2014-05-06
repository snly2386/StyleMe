$(document).ready(function(){
  $(".list").on('click',function(e){
    e.preventDefault();
    if($('.login').css('display') == 'none') {
      $('.login').show();
      $('.login').draggable();
    } else {
      $('.login').hide();
    }
  })
  $('.close').on('click',function(){
    $('.login').hide();
  })
});