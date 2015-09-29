# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ajax:success" , "form#comments-form" , (ev,data)->
	console.log data
	$("#comments-box").append('<div class="row"><div class="large-2 columns small-3"><img alt="Bubble" src="/assets/bubble.png"></div>'+"<strong>#{data.user.email}: </strong>"+"#{data.body}"+"<hr></div>")
		