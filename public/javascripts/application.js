var items, last_height;

$(document).ready(function () {
  
  /*
   * Appends the strong element on hover of homepage
   * work items.
   **/
  $('body.welcome #right a').hover(function () {
    $(this).append($('<strong>').text($(this).find("img").attr('alt')));
  }, function () {
    $(this).find('strong').fadeOut(1000, function () {
      $(this).remove();
    });
  });
  
  
  /*
   * The small and sweet gallery.
   **/
  $('body.works #thumbs a').live('click', function (e) {
    e.preventDefault();
    var index = $(this).parent().prevAll().size();
    $('#featured').prepend($('<img/>', { src: items[index].large, alt: 'alt', style: 'z-index:5' }));
    $('#featured img:eq(0)').hide().fadeIn(250, function () {
      $(this).css('z-index', '1');
      $('#featured img:eq(1)').remove();
    });
  });
  
  /*
   * On the about page when you click on "Give me a mountain dew"
   * it will show an overlay with mountain dews flying in.
   **/
  $('a.dewski').live('click', function (e) {
    e.preventDefault();
    var dewskis = $('#dewskis'),
        x = 1
    dewskis.fadeIn();
    
    for(var i = 0; i < 154; i++) {
      // todo: storing the <img/> in a variable makes it flash
      dewskis.append($('<img/>', { src: '/images/content/dewski.gif', alt: '', style: 'display:none' }));
      dewskis.find('img:last').hide(0).delay(i*10).fadeIn(50);
    }
    
    window.setTimeout(function () {
      $('#thirsty').hide();
      $('#quenched').show();
      $('body.about #right').css({
        backgroundImage: 'url("/images/content/about_dewski.jpg")'
      });
      dewskis.fadeOut(1000);
    }, 2500);
  });
  
  $('#sorting a').live('click', function (e) {
    e.preventDefault();
    var points = [], unmatched = [], b = 0, left, top,
        rel = $(this).attr('rel'),
        items = $('#listing .item'),
        listing = $('#listing');
    
    // stop everything if $(this) is already active
    if($('#sorting .active').attr('rel') == rel) return;
    
    // Add active class to the current skill selected.
    $('#sorting .active').removeClass('active');
    $(this).addClass('active');
    
    items.each(function (i) {
      // offset because it will be absolute
      left = Math.round((i%2)*234);
      top = (Math.round(Math.round((i+1)/2)*195)-195);
      
      // If it isn't absolute yet, make it.
      if($(this).css('position') != 'absolute') {
        $(this).css({
          position: 'absolute',
          marginTop: top,
          marginLeft: left
        });
      }
      
      if(rel != 'all' && !$(this).hasClass(rel)) {
        unmatched.push($(this));
      } else {
        left = Math.round((b%2)*234);
        top = (Math.round(Math.round((b+1)/2)*195)-195);
        
        // Need to retain second counter for actual
        // items that are pushed to the array
        b++;
        
        points.push({
          'item' : $(this),
          'x' : left,
          'y' : top
        });
      }
    });
    
    var total_height = Math.round(Math.round((points.length+1)/2)*195);
    // Running for the first time
    if(typeof last_height == 'undefined') {
      last_height = total_height;
    }
    
    listing.css('height', last_height).animate({
      height: total_height
    }, 700);
    last_height = total_height;
    
    // Any item that isn't what we selected, fade it out first.
    $(unmatched).each(function (i, item) {
      item.animate({
        opacity: 0
      }, 700, 'easeInOutExpo', function () {
        $(this).hide();
      });
    });
    
    // Move the matched items around to the new order.
    $(points).each(function (i, point) {
      point['item'].show().animate({
        opacity: 1,
        marginTop:  point['y'],
        marginLeft: point['x']
      }, 725, 'easeInOutExpo');
    });
      
  });
});

(function($) {
  /*
   * 
   **/
  var cache = [];
  $.preloadImages = function() {
    var args_len = arguments.length;
    for (var i = args_len; i--;) {
      var cacheImage = document.createElement('img');
      cacheImage.src = arguments[i];
      cache.push(cacheImage);
    }
  }
  
  
  /*
   * Since jQuery doesn't really have an easy to use
   * reset function, this is to replicate $.clear();
   **/
  $.fn.clearForm = function() {
    return this.each(function() {
      var type = this.type, tag = this.tagName.toLowerCase();
      if (tag == 'form')
        return $(':input',this).clearForm();
      if (type == 'text' || type == 'password' || tag == 'textarea')
        this.value = '';
      else if (type == 'checkbox' || type == 'radio')
        this.checked = false;
      else if (tag == 'select')
        this.selectedIndex = -1;
    });
  }
})(jQuery);

/* Rails 3.0 jQuery UJS Plugin */
jQuery(function ($) {
    $.fn.extend({
        /**
         * Triggers a custom event on an element and returns the event result
         * this is used to get around not being able to ensure callbacks are placed
         * at the end of the chain.
         *
         * TODO: deprecate with jQuery 1.4.2 release, in favor of subscribing to our
         *       own events and placing ourselves at the end of the chain.
         */
        triggerAndReturn: function (name, data) {
            var event = new jQuery.Event(name);
            this.trigger(event, data);

            return event.result !== false;
        },
        
        /**
         * Handles execution of remote calls firing overridable events along the way
         *
         */
        callRemote: function () {
            var el      = $(this),
                data    = [],
                method  = el.attr('method') || el.attr('data-method') || 'GET',
                url     = el.attr('action') || el.attr('href');

            if (el.context.tagName.toUpperCase() === 'FORM') {
                data = el.serializeArray();
            }

            // TODO: should let the developer know no url was found
            if (url !== undefined) {
                if (el.triggerAndReturn('ajax:before')) {
                    $.ajax({
                        url: url,
                        data: data,
                        type: method.toUpperCase(),
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("Accept", "text/javascript");
                            el.trigger('ajax:loading', xhr);
                        },
                        success: function (data, status, xhr) {
                            el.trigger('ajax:success', [data, status, xhr]);
                        },
                        complete: function (xhr) {
                            el.trigger('ajax:complete', xhr);
                        },
                        error: function (xhr, status, error) {
                            el.trigger('ajax:failure', [xhr, status, error]);
                        }
                    });
                }

                el.trigger('ajax:after');
            }
        }
    });

    /**
     *  confirmation handler
     */
    $('a[data-confirm],input[data-confirm]').live('click', function () {
        var el = $(this);
        if (el.triggerAndReturn('confirm')) {
            if (!confirm(el.attr('data-confirm'))) {
                return false;
            }
        }
    });

    /**
     * remote handlers
     */
    $('form[data-remote="true"]').live('submit', function (e) {
        $(this).callRemote();        
        e.preventDefault();
    });

    $('a[data-remote="true"],input[data-remote="true"]').live('click', function (e) {
        $(this).callRemote();        
        e.preventDefault();
    });

    /**
     * disable_with handlers
     */ 
    $('form[data-remote="true"]').live('ajax:before', function () {
        $(this).children('input[data-disable-with]').each(function (i, el) {
            var input = $(el);
            input.data('enable_with', input.val())
                 .attr('value', input.attr('data-disable-with'))
                 .attr('disabled', 'disabled');
        });
    });

    $('form[data-remote="true"]').live('ajax:after', function () {
        $(this).children('input[data-disable-with]').each(function (i, el) {
            var input = $(el);
            input.removeAttr('disabled')
                 .val(input.data('enable_with'));
        });
    });
});