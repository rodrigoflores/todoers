var Application = {
  add_to_do_item: {
    init: function() {
      $("#new_to_do_link").click( function (){
        fields = $("tr.inactive:first");
        fields.fadeIn();
        fields.removeClass('inactive');
        return false;
      }); 
    }
  },
  remove_to_do_item: {
    init: function(form) {
      $(".close_this_todo_item").click( function (){
        tr = $(this).parent().parent();
        tr.fadeOut();
        tr.addClass('inactive');
        tr.find("input").val("");
	      tr.find("checkbox").val("");
        return false;
      });
    }
  }
};



$(document).ready(function() {
  Application.add_to_do_item.init();
  Application.remove_to_do_item.init();
});

