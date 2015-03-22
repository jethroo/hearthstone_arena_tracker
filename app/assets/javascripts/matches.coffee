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
          $("#my_matches").append(data)
          return
        error: (data) ->
          $("#error").append(data)
          return
