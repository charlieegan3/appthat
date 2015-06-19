// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function post_flag() {
  $.ajax({
    type: 'POST',
    url: '/flag',
    data: { id: $(this).attr("data-id") }
  });
  $(this).toggleClass("flagged");
}

function build_tweet_div(item) {
  var tweet = document.createElement("div");

  var recent_date = new Date(new Date().getTime() - (24 * 60 * 60 * 1000));
  var new_date = new Date(new Date().getTime() - (12 * 60 * 60 * 1000));
  tweet.className = "tweet";
  if (new Date(item.created_at) > recent_date) {
    $(tweet).addClass("recent");
  }
  if (new Date(item.created_at) > new_date) {
    $(tweet).addClass("new");
  }
  return tweet;
}

function build_tweet_link(item) {
  var link = document.createElement("a");
  link.setAttribute("href", item.url);
  $(link).append("<p class=\"text\">" + item.text + "</p>");
  return link;
}

function build_tweet_details(item) {
  var details = document.createElement('p');
  details.className = "details";
  details.innerHTML = jQuery.timeago(item.created_at) + " ";
  var flag_button = document.createElement('button');
  $(flag_button).attr({ "data-id": item.id, "class": "flag-button" });
  flag_button.innerHTML = "⚑";
  $(flag_button).click(post_flag);
  $(details).append(flag_button);
  return details;
}

$("document").ready(function(){
  $(".flag-button").click(post_flag);

  $('#search').on('input',function(e){
    query = "search?query=" + $(this).val().replace(/\s+/g, '+');
    $("#results").html("");
    $.getJSON( query, function( data ) {
      var items = [];
      $.each( data, function( key, val ) {
        items.push(val);
      });
      if (items.length == 0) {
        $("#results").css("display", "none");
      } else {
        $.each(items, function( index, item ) {
          var tweet = build_tweet_div(item);
          $(tweet).append(build_tweet_link(item), build_tweet_details(item));
          $("#results").append(tweet);
        });
        $("#results").css("display", "block");
      }
    });
  });
});
