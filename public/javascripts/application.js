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
  
  $('a.dewski').live('click', function (e) {
    e.preventDefault();
    var dewskis = $('#dewskis'),
        x = 1,
        img = "<img src='/images/content/dewski.gif' style='display:none' alt='' />";
    dewskis.fadeIn();
    for(var i = 0; i < 154; i++) {
      dewskis.append(img);
      dewskis.find('img:last').hide(0).delay(i*10).fadeIn(50);
    }
    window.setTimeout(function () {
      $('#thirsty').hide();
      $('#quenched').show();
      $('body.about #work').css({
        backgroundImage: 'url("/images/content/about_dewski.jpg")'
      });
      dewskis.fadeOut("fast");
    }, 2500);
  });
});