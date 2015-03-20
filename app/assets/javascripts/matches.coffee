$(document).on "page:change", ->
  $(".match_win a, .match_loose a")
    .bind "ajax:success", (evt, data, status, xhr) ->
      $("#my_matches").append(data)
    .bind "ajax:error", (evt, data, status, xhr) ->
      $("#error").append(data)
