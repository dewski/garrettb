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
    
    if(!target.hasClass('displayed')) {
      $('img.displayed').fadeOut("fast", function () {
        $(this).removeClass('displayed').css('z-index', '1');
        target.fadeIn(function () {
          $(this).addClass('displayed');
        });
      });
    }
  });
});