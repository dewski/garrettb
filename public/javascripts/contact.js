$('body.contact form').bind('ajax:before', function (e) {
  var validated = true;
  $(['name', 'email', 'body']).each(function (i, v) {
    var item = $('#contact_'+ v);
    if(item.val() === "") {
      e.preventDefault();
      alert('Please fill out the '+ v +' field.');
      item.addClass('has_errors');
      item.focus();
      validated = false;
      return false;
    } else {
      item.removeClass('has_errors');
    }
  });
  return validated;
});

$('body.contact form').bind('ajax:failure', function (xhr, status, error) {
  alert('Something went wrong, please email me at:\nxhtmlthis@me.com');
  $('body.contact form').clearForm();
});