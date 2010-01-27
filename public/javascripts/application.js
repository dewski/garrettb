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
  
  $('#sorting a').live('click', function (e) {
    e.preventDefault();
    var rel = $(this).attr('rel'), items = $('#listing .item');
    
    if($('#sorting .active').attr('rel') == rel) {
      return;
    }
    
    $('#sorting .active').removeClass('active');
    $(this).addClass('active');
    
    if(rel == 'all') {
      items.fadeIn(250);
    } else {
      items.each(function () {
        if(!$(this).hasClass(rel)) {
          $(this).fadeOut(250);
        } else {
          $(this).fadeIn(250);
        }
      });
    }
  });
});

(function($) {
  var cache = [];
  $.preLoadImages = function() {
    var args_len = arguments.length;
    for (var i = args_len; i--;) {
      var cacheImage = document.createElement('img');
      cacheImage.src = arguments[i];
      cache.push(cacheImage);
    }
  }
})(jQuery);

(function($) {
  $.hasKey = function() {
    var args_len = arguments.length;
    for (var i = args_len; i--;) {
      var cacheImage = document.createElement('img');
      cacheImage.src = arguments[i];
      cache.push(cacheImage);
    }
  }
})(jQuery);

function oc(a) {
  var args_len = a.length, o = {};
  for(var i = 0; i < args_len; i++) {
    o[a[i]] = '';
  }
  return o;
}