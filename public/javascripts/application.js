var Application = {
  unwatch_todo_list: {
    init: function() {
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
    }
  },
  watch_todo_list: {
    init: function() {
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
  },
  submit_todo_item: {
    submit: function() {
      $("#new_todo_item_form").submit( function (){
        var form = $(this);        
        $.ajax({
          url: form.attr('action'),
          type: 'post',
          dataType: 'json',
          data: form.serialize(),
          async:false,
          success: function(data) {
            todo_item = data.todo_item
            table_tbody = $('table#todo_items tbody');
            table_tbody.prepend("<tr><td>" + todo_item.description + "</td><td>" + todo_item.deadline + "</td><td>" + todo_item.done + "</td><td><a href='/todo_lists/" + todo_item.todo_list_id+ "/todo_items/" + todo_item.id + "/complete' class='complete_todo_item'>Complete</a>" +  
             "</td><td><a href='/todo_lists/" + todo_item.todo_list_id + "/todo_items/" + todo_item.id+ "' class='destroy_todo_item'>Delete</a></td></tr>" );

          },
          // error: function(response) {
          //   alert("Erro");
          // }
            
          });
        return false;
      });
      
    }
  },
  complete_todo_item: {
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
    }
  },
  destroy_todo_item: {
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
};



$(document).ready(function() {
  Application.unwatch_todo_list.init();
  Application.watch_todo_list.init();
  Application.add_to_do_item.init();
  Application.remove_to_do_item.init();
  Application.destroy_todo_item.destroy();
  Application.complete_todo_item.complete();
  Application.submit_todo_item.submit();
});

