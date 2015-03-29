winLoss = (data) ->
  $('#win_loss_hero').highcharts
    chart: type: 'column'
    title: text: 'by played hero'
    xAxis: categories: [
      'Win'
      'Loose'
    ]
    yAxis: title: text: 'Win / Loss'
    series: data
  return

$(document).on "page:change", ->
  if ($('#win_loss_hero').length)
    $.ajax
      url: '/stats/win_loss'
      type: 'GET'
      async: true
      dataType: 'json'
      success: (data) ->
        winLoss data
        return
    return

