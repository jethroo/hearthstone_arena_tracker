# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#new_arena #arena_hero').change ->
    selected = $(this).val()
    hero = if selected == "" then "none" else selected
    $(".hero-frame img").attr("src", hero)
  $('#new_arena #arena_hero').trigger("change")
