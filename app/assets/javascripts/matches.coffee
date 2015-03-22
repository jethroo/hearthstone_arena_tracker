$(document).on "page:change", ->
  $(".match_win a, .match_loose a")
    .on "click", (e) ->
      e.preventDefault();
      $.ajax
        url: $('#new_matches').data('action-url')
        type: "POST"
        data:
          "match":
            "hero": "anduin"
            "opponent": $(this).attr("value")
            "win": $(this).parent().attr("class") == "match_win"
        success: (data) ->
          $("#my_matches").prepend(data)
            .bind "ajax:success", (evt, data, status, xhr) ->
              $(evt.target).parent().remove()
            .bind "ajax:error", (evt, data, status, xhr) ->
              alert("error")
        error: (data) ->
          $("#error").append(data)
          return
  $(".match_result_row")
