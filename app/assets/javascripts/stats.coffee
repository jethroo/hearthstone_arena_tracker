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

overTime = (data) ->
  $('#win_loss_over_time').highcharts
    chart: type: 'spline'
    title: text: 'over time (all heros)'
    xAxis:
      type: 'datetime'
      dateTimeLabelFormats:
        month: '%e. %b'
        year: '%b'
      title: text: 'Date'
    yAxis:
      title: text: 'Win / Loss'
      min: 0
    plotOptions: spline: marker: enabled: true
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
  if ($('#win_loss_over_time').length)
    $.ajax
      url: '/stats/win_loss_over_time'
      type: 'GET'
      async: true
      dataType: 'json'
      success: (data) ->
        overTime data
        return
  return


