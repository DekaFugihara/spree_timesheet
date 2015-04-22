jQuery(function() {
	
  $('form').on('click', '.remove_task_field', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('p').hide();
    event.preventDefault();
  });
  
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    regexp = void 0;
    time = void 0;
    time = (new Date).getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
	
});