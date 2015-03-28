winLoss = (data) ->
  $('#chart').highcharts
    chart: type: 'column'
    title: text: 'Played Hero'
    xAxis: categories: [
      'Win'
      'Loose'
    ]
    yAxis: title: text: 'Win / Loss'
    series: data
  return

$(document).on "page:change", ->
  if ($('#chart').length)
    $.ajax
      url: '/stats/win_loss'
      type: 'GET'
      async: true
      dataType: 'json'
      success: (data) ->
        winLoss data
        return
    return

