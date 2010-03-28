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
    if ($(this).attr('href') == '#') {
      e.preventDefault();
      var index = $(this).parent().prevAll().size();
      $('#featured').prepend($('<img/>', { src: items[index].large, alt: 'alt', style: 'z-index:5' }));
      $('#featured img:eq(0)').hide().fadeIn(250, function () {
        $(this).css('z-index', '1');
        $('#featured img:eq(1)').remove();
      });
    }
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
  
  $('body.works #sorting a').live('click', function (e) {
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

jQuery(function ($) {
    var csrf_token = $('meta[name=csrf-token]').attr('content'),
        csrf_param = $('meta[name=csrf-param]').attr('content');

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
            var event = new $.Event(name);
            this.trigger(event, data);

            return event.result !== false;
        },

        /**
         * Handles execution of remote calls firing overridable events along the way
         */
        callRemote: function () {
            var el      = this,
                data    = el.is('form') ? el.serializeArray() : [],
                method  = el.attr('method') || el.attr('data-method') || 'GET',
                url     = el.attr('action') || el.attr('href');

            if (url === undefined) {
              throw "No URL specified for remote call (action or href must be present).";
            } else {
                if (el.triggerAndReturn('ajax:before')) {
                    $.ajax({
                        url: url,
                        data: data,
                        dataType: 'script',
                        type: method.toUpperCase(),
                        beforeSend: function (xhr) {
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
    $('form[data-remote]').live('submit', function (e) {
        $(this).callRemote();
        e.preventDefault();
    });

    $('a[data-remote],input[data-remote]').live('click', function (e) {
        $(this).callRemote();
        e.preventDefault();
    });

    $('a[data-method]:not([data-remote])').live('click', function (e){
        var link = $(this),
            href = link.attr('href'),
            method = link.attr('data-method'),
            form = $('<form method="post" action="'+href+'">'),
            metadata_input = '<input name="_method" value="'+method+'" type="hidden" />';

        if (csrf_param != null && csrf_token != null) {
          metadata_input += '<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';
        }

        form.hide()
            .append(metadata_input)
            .appendTo('body');

        e.preventDefault();
        form.submit();
    });

    /**
     * disable-with handlers
     */
    var disable_with_input_selector = 'input[data-disable-with]';
    var disable_with_form_selector = 'form[data-remote]:has(' + disable_with_input_selector + ')';

    $(disable_with_form_selector).live('ajax:before', function () {
        $(this).find(disable_with_input_selector).each(function () {
            var input = $(this);
            input.data('enable-with', input.val())
                 .attr('value', input.attr('data-disable-with'))
                 .attr('disabled', 'disabled');
        });
    });

    $(disable_with_form_selector).live('ajax:after', function () {
        $(this).find(disable_with_input_selector).each(function () {
            var input = $(this);
            input.removeAttr('disabled')
                 .val(input.data('enable-with'));
        });
    });
});