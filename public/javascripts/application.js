$(document).ready(function () {
  $('.welcome #work a').hover(function () {
    $(this).append("<strong>"+ $(this).find("img").attr('alt') +"</strong>");
  }, function () {
    $(this).find("strong").fadeOut(1000, function () {
      $(this).remove();
    });
  });
  
  $('.works #thumbs a').live('click', function (e) {
    if($(this).attr('href') == "#") e.preventDefault();
    var large_img = $(this).find('img').attr('id').replace('thumb', 'large');
    var target = $('#'+ large_img);
    
    if(!target.hasClassName('displayed')) {
      target.show();
      $('img.displayed').fadeOut("fast", function () {
        $(this).removeClass('displayed');
        target.addClass('displayed');
      });
    }
  });
});