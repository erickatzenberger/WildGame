$.fn.bindCustomerForm = () ->
  return if this.length == 0

  bioForm = this[0]
  $bioForm = $(bioForm)

  $firstName = $(bioForm['customer[first_name]'])
  $lastName  = $(bioForm['customer[last_name]'])

  $zip   = $(bioForm['customer[zip]'])
  $state = $(bioForm['customer[state]'])
  $city  = $(bioForm['customer[city]'])

  $mobile     = $(bioForm['customer[mobile]'])
  $homeMobile = $(bioForm['customer[home_mobile]'])
  $workMobile = $(bioForm['customer[work_mobile]'])

  $firstName.add($lastName).add($state).add($city).disableDigitsAndSymbols()

  $zip       .mask("?99999")
  $mobile    .mask("?(999) 999-9999")
  $homeMobile.mask("?(999) 999-9999")
  $workMobile.mask("(999) 999-9999? x99999")

  $zip.change(() ->
    zip = $(this).val()
    geocodeZipLoader = $('#geocode_zip_loader')
    if(zip.length == 5)
      geocodeZipLoader.show()
      $.post(
        '/orders/geocode_zip',
        { zip: zip },
        (data) ->
          $state.val(data.state).trigger('change').trigger('focousout')
          $city .val(data.city) .trigger('change').trigger('focousout')
          geocodeZipLoader.hide()
      )
  )

  $bioForm.find('.buttons .button').on('click', () ->
    return false if $bioForm.find('.field_with_errors').length > 0

    if $(this).hasClass('add-next-customer')
      $bioForm.append($('<input>', {type: 'hidden', name: 'add_next_customer', value: 1}))

    if $(this).hasClass('dont-save-add-game')
      $bioForm.append($('<input>', {type: 'hidden', name: 'dont_save_add_game', value: 1}))

    loader = $('<img>').addClass('loader').attr('src', '/assets/loader.gif')
    $bioForm.hide().parent().append(loader)
    $.post($bioForm.attr('action'), $bioForm.serialize(), (data) ->
      $bioForm.show().parent().find('.loader').remove()

      if data.errors
        alert(data.errors)
      else
        if data.orderId && $('#order_id').length == 0
          $('body').append($('<input>', {type: 'hidden', id: 'order_id', value: data.orderId}))
        if data.customers
          # Update customers tab
          $('#customers_window').html(data.customers)
          $('#customers_counter').text(data.customersQuantity)
          $('.tabs .sub-tabs > span').bindSubTabs()
          $('#customers_window .sub-tabs > span:last').trigger('click')

        if data.selectGameForm
          $('#form_window .window').html(data.selectGameForm)
          $('#select_game_form').bindSelectGameForm()
        else if data.customerForm
          $('#form_window .window').html(data.customerForm)
          $('#bio_form').bindCustomerForm().validate()

        if data.url
          window.history.pushState({html: data.customers, pageTitle: 'Edit Order'}, '', data.url)
    )

    return false
  )

  return this

$(document).ready(() ->
  $('#bio_form').bindCustomerForm()
)
