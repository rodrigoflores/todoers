var Application = {
  todo_list_watch_actions: {
    unwatch: function() {
      $(".unwatch_link").click( function () {
        link = $(this);
        $.ajax({
          url: link.attr('href'),
          type: 'DELETE',
          dataType: 'script',
          success: function(){
            tr = link.parent().parent();  
            tr.slideUp();
          }});
        return false; 
      });
    },
    watch: function() {
      $("#list_watch").click( function () {
        link = $(this);
        $.ajax({
          url: link.attr('href'),
          type: 'PUT',
          dataType: 'script',
          success: function(){
            link.fadeOut();
            $("#watch_paragraph").html("You are now watching this list");
          } 
        });
        return false;
      });
    }
  }, 
  todo_item_crud_like: {
    append_one: function() {
      $("#new_to_do_link").click( function (){
        fields = $("tr.inactive:first");
        fields.fadeIn();
        fields.removeClass('inactive');
        return false;
      }); 
    },
    unappend_one: function(form) {
      $(".close_this_todo_item").click( function (){
        tr = $(this).parent().parent();
        tr.fadeOut();
        tr.addClass('inactive');
        tr.find("input").val("");
	      tr.find("checkbox").val("");
        return false;
      });
    },
    create: function() {
      $("#new_todo_item_form").submit( function (){
        var form = $(this);        
        $.ajax({
          url: form.attr('action'),
          type: 'post',
          dataType: 'json',
          data: form.serialize(),
          // async:false,
          success: function(data) {
            
            todo_item = data.todo_item
						table_tbody = $('table#todo_items tbody');
						tr_id = 'todo-item-' + todo_item.id;
						table_tbody.append($("<tr></tr>").attr('id',tr_id))
						tr = $("#"+tr_id);
						tr.append($("<td>" + todo_item.description + "</td>"));
						if(!todo_item.deadline) {
							tr.append($("<td></td>"));
						}
						else
						{
							tr.append($("<td>" + todo_item.deadline + "</td>"));
						}
						
						if(todo_item.done) {
							tr.append($("<td>Yes</td>"));
							tr.append($("<td></td>"));
						}
						else
						{
						  $('#errors').html("");
							tr.append($("<td>No</td>"));
							   tr.append($("<td></td>").append($("<a>Complete</a>").addClass("complete_link").attr('href','/todo_lists/' + todo_item.todo_list_id+ '/todo_items/'+ todo_item.id+ '/complete').addClass("complete_todo_item")) );
						}
						tr.append($("<td></td>").append($("<a>Delete</a>").attr('href','/todo_lists/' + todo_item.todo_list_id+ '/todo_items/'+ todo_item.id).addClass("destroy_todo_item")) );
						
						//As we added new stuff, we have to re run somethings
						Application.todo_item_crud_like.complete();
					  Application.todo_item_crud_like.destroy();
          },
          error: function(response) {
            $('#errors').html("");
            errors = jQuery.parseJSON(response.responseText);
            $.each(errors, function(index,value){
   $('#errors').css('display','none').append($("<li></li>").append(value.field + " " + value.description)).fadeIn();
            });
          }
            
        });
        return false;
      });
    },
    complete: function() {
      $(".complete_todo_item").click( function ( ){
        link = $(this);
        $.ajax({
            type: 'PUT',
            url: link.attr('href'),
            dataType: 'script',
            success: function(msg){
              tr = link.parent().parent();
              status_cell = tr.find('.status');
              status_cell.html("Yes");                                          
              link_cell = tr.find('.complete_link');
              link_cell.html("");
            }
        });
        return false;
      });
    },
    destroy: function() {
      $(".destroy_todo_item").click( function ( ){
        link = $(this);
        tr = link.parent().parent();
        $.ajax({
            type: 'DELETE',
            url: link.attr('href'),
            dataType: 'script',
            success: function(msg){
              
              link.parent().parent().fadeOut();
            }
        });
        return false;
      });
    }
  }
}


$(document).ready(function() {
  Application.todo_list_watch_actions.unwatch();
  Application.todo_list_watch_actions.watch();
  Application.todo_item_crud_like.append_one();
  Application.todo_item_crud_like.unappend_one();
  Application.todo_item_crud_like.create();
  Application.todo_item_crud_like.complete();
  Application.todo_item_crud_like.destroy();
});

