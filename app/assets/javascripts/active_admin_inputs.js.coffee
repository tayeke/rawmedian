chosen_forms = ->
  $select = $('.chzn-select')
  $select.chosen
    no_results_text: "Add Tag: "

  $('.chzn-results .no-results').live 'click', (e) ->
    tag = $(@).find('span').text()
    $select.append("<option selected=\"selected\">#{tag}</option>")
    $select.trigger('liszt:updated')

  return true

$(chosen_forms)