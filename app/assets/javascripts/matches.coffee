$(document).on "page:change", ->
  $(".match_win a, .match_loose a")
    .on "click", (e) ->
      e.preventDefault();
      $.ajax
        url: $('#new_matches').data('action-url')
        type: "POST"
        data:
          "match":
            "hero": $("#hero").val()
            "arena": $("#arena").val() if $("#arena")
            "opponent": $(this).attr("value")
            "win": $(this).parent().attr("class") == "match_win"
        success: (data) ->
          $("#my_matches").prepend(data)
            .bind "ajax:success", (evt, data, status, xhr) ->
              $(evt.target).parent().parent().remove()
            .bind "ajax:error", (evt, data, status, xhr) ->
              alert("error")
        error: (data) ->
          $("#flash_errors").append(data.responseText)
          window.setTimeout (->
            $(".alert-box a.close").trigger("click.fndtn.alert")
            return
          ), 2000
          $(document).foundation('alert', 'reflow');
  $("#hero").change (e) ->
    selected = $(this).val()
    hero = if selected == "" then "none" else selected
    $(".hero-frame img").attr("src", "/assets/heroes/"+hero+".png")
  $("#hero").trigger("change")
