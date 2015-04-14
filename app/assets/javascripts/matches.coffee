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
          match = $(data)
          match.prependTo("#my_matches")

          matchtype = match.attr("class").split(/\s+/).pop()
          if matchtype == "win"
            reduceMatchCounter("#open_wins") if $("#arena")
          else if matchtype == "loose"
            reduceMatchCounter("#open_losses") if $("#arena")
          arenaFinished() if $("#arena")
        error: (data) ->
          $("#flash_errors").append(data.responseText)
          window.setTimeout (->
            $(".alert-box a.close").trigger("click.fndtn.alert")
            return
          ), 2000
          $(document).foundation('alert', 'reflow');

  $("#my_matches").bind "ajax:success", (evt, data, status, xhr) ->
    match_result = $(evt.target).parent().parent()
    matchtype = match_result.attr("class").split(/\s+/).pop()
    if matchtype == "win"
      increaseMatchCounter("#open_wins") if $("#arena")
    else if matchtype == "loose"
      increaseMatchCounter("#open_losses") if $("#arena")
    match_result.remove()
  .bind "ajax:error", (evt, data, status, xhr) ->
    alert("error")

  $("#hero").change (e) ->
    selected = $(this).val()
    hero = if selected == "" then "none" else selected
    $(".hero-frame img").attr("src", "/assets/heroes/"+hero+".png")
  $("#hero").trigger("change")

reduceMatchCounter = (selector) ->
  counter = $(selector)
  counter.val(parseInt(counter.attr("value")) - 1) if counter.attr("value") >= 0

increaseMatchCounter = (selector) ->
  counter = $(selector)
  count = parseInt(counter.attr("value"))
  counter.val(count + 1) if selector == "#open_wins" && count < 12 or selector == "#open_losses" && count < 3

arenaFinished = ->
  if parseInt($("#open_wins").attr("value")) < 1 or parseInt($("#open_losses").attr("value")) < 1
    $('#arenaFinishedModal').foundation('reveal','open');
