// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery.ui.all

$(document).ready(function(){
    $(".form_tooltip").tooltip({ placement: 'auto right'});

    $('.carousel').carousel({
      interval: 2000,
      pause: 'hover',
      wrap: false
    })


$('#leader_search').bind('keyup', function() {
        $.getJSON( "/search_users.json?search=" + $('#leader_search').val(), function(data) {
          var items = [];
          $.each( data, function( key, val ) {
            var add_leader_button = "<button class='btn btn-info' data-leader_id=" + val.id + ">Add leader</button>";
            items.push( "<li id='" + key + "'>" + val.firstname + " " + val.lastname + " " + add_leader_button +"</li>" );
          });
          $("#leaders").empty();
          $( "<ul/>", {
            "class": "my-new-list",
            html: items.join( "" )
          }).appendTo( "#leaders" );

        });


      });

});