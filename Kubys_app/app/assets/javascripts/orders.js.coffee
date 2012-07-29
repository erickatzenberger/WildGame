$.fn.bindSubTabs = () ->
  # Subtabs - customers, games
  this.on('click', () ->
    subtabs = $(this).parent()
    subtabs.find('span.active').removeClass('active')
    window = $(this).parents('.window')
    window.find('.data-table').hide()

    $(this).addClass('active')
    window.find('.data-table').eq(subtabs.find('span').index(this)).show()
  )

$(document).ready () ->
  # Main tabs
  $('.tabs > nav > span:not(.disabled)').on('click', () ->
    $('.tabs > nav > span.active').removeClass('active')
    $('.tabs .window:visible').hide()

    $(this).addClass('active')
    $('.tabs .window').eq($('.tabs > nav > span').index(this)).show()
  )

  $('.tabs .sub-tabs > span').bindSubTabs()

  $('.tabs > nav > span:first').trigger('click')
  $('#customers_window > .sub-tabs > span:first, #games_window > .sub-tabs > span:first').trigger('click')
