$.fn.bindSteakCutsForm = () ->
  this.find('.step:not(:first)').hide()

  this.on 'submit', () ->
    $.post($(this).attr('action'), $(this).serialize(), (data) ->
      $('#form_window > .window').html(data.steakCutsForm)
      $('#form_window > .window form').bindSteakCutsForm()
    )
    return false

  $('#part_step li').on 'click', () ->
    part_id = $(this).attr('value')
    $('#steak_cut_part_id').val(part_id)
    $.get('/orders/steak_cuts_cuts', { part_id: part_id }, (data) ->
      $('#part_step').hide()
      $('#cut_step').html(data).bindCutsStep().show()
    )

$.fn.bindCutsStep = () ->
  this.find('li').on 'click', () ->
    part_id = $('#steak_cut_part_id').val()
    cut_id = $(this).attr('value')
    $('#steak_cut_cut_id').val(cut_id)
    $.get('/orders/steak_cuts_sizes', { part_id: part_id, cut_id: cut_id }, (data) ->
      $('#cut_step').hide()
      $('#size_step').html(data).bindSizesStep().show()
    )
  return this

$.fn.bindSizesStep = () ->
  this.find('li').on 'click', () ->
    size_id = $(this).attr('value')
    $('#steak_cut_size_id').val(size_id)
    $('#size_step').hide()
    $('#how_many_step').show()
  return this
