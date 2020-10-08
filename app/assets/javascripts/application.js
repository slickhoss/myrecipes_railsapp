// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require_tree .


function submitMessage(event){
    event.preventDefault();
    $('#new_message').submit();
}

function scrollToBottom(){
    if($('#messages').length > 0){
        $('#messages').scrollTop($('#messages')[0].scrollHeight);
    }
}


$('#send').keypress(function(e){
    if(e.which == 13){
         $(this).closest('form').submit();
     }
});


var ready;
ready = function ()
{
    console.log('scroll called')
    scrollToBottom();
}
$(document).ready(ready);

$(document).on('turbolinks:load', function() {
    $("#new_message").on("ajax:complete", function(e, data, status) {
      $('#message_content').val('');
    })
    scrollToBottom();
  });