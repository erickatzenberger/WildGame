clientSideValidations.validators.local['hunting_licence_nr_texas_format'] = (element, options) ->
  if $('#game_no_hunting_licence_nr:checked').length == 0
    if element.val() != '' and $('#game_state').val() == 'Texas' and !(/^\d{12}$/).test(element.val())
      return options.message

clientSideValidations.validators.local['presence_with_no_checkbox'] = (element, options) ->
  no_checkbox = $('#game_' + options.checkbox)
  if !no_checkbox[0].checked and element.val() == ''
      return options.message

clientSideValidations.validators.local['part_name_presence'] = (element, options) ->
  # Do not validate presence if this is other part and other checkbox isn't checked
  if element.val() == '' and element.parents('.checkbox-button').find('input[type="checkbox"]').attr('checked')
    return options.message

clientSideValidations.validators.local['custom_species_name_presence'] = (element, options) ->
  if $('#game_species').val() == 'Other' and element.val() == ''
    return options.message

# Binding checkbox to disable corresponding input when checked
$.fn.bindNoCheckbox = ($input) ->
  $(this).on('change', () ->
    if this.checked
      $input.
        val('').
        trigger('change').
        trigger('focusout').
        attr('disabled', true)
    else
      $input.attr('disabled', false)
  ).trigger('change')

$.fn.bindSelectGameForm = () ->
  # Select game
  $selectGameForm = this
  $selectGame = $selectGameForm.find('.select-game')
  $selectGame.find('li').on 'click', () ->
    typeId = $(this).data('game')
    typeName = $(this).text()

    $selectGameForm.append($('<input>', {type: 'hidden', name: 'type', value: typeId}))

    loader = $('<img>').addClass('loader').attr('src', '/assets/loader.gif')
    $('#form_window > .window').html(loader)
    $.post($selectGameForm.attr('action'), $selectGameForm.serialize(), (data) ->

      if data.errors
        alert(data.errors)
        $selectGameForm.show()
      else
        $('#form_window > .window').html(data.gameForm)

        $gameForm = $('#game_form')
        $gameForm.bindGameForm().validate()

        # Show first step
        $gameForm.find('.step:first').show().addClass('current')

        # Show next and back buttons
        $gameForm.find('.buttons .save').hide()
        $gameForm.find('.buttons').show()

        # Add new tab to Games
        $('#games_window').append($('<table>', {class: 'data-table'}))
        label = $('<span>').text(typeName)
        $('#games_window > .sub-tabs').append(label)
        label.bindSubTabs()

        gamesCounter = $('#games_counter')
        gamesCounter.text(parseInt(gamesCounter.text())+1)

        # Click Games tab and current Game tab
        $('.tabs nav .games').trigger 'click'
        label.trigger('click')
    )

  $('.form-link').on 'click', () ->
    $('#form_window > .window').load(this.href)
    return false

  $('#go_to_steak_cuts').on 'click', () ->
    $('#form_window > .window').load(this.href, () ->
      $('#form_window > .window form').bindSteakCutsForm()
    )
    return false

$.fn.bindGameForm = () ->
  $gameForm = this
  gameForm = $gameForm[0]

  # Hide steps and buttons - leave just game select step
  $gameForm.find('.step:not(:first), .buttons').hide()

  # Proceed to next step
  $gameForm.find('.next-step').on('click', () ->
    currentStep = $gameForm.find('.step.current')

    visibleRows = currentStep.find('tr:visible')

    # Fields (inputs, selects) from current step
    fields = visibleRows.find('select, input')

    # Validate fields
    fields.trigger('change').trigger('focusout')

    # Abort if there is any validation error on some input from current step
    return false if visibleRows.find('.field_with_errors').length > 0

    visibleRows.each((i, row) ->
      row = $(row)
      selection = null

      # Get field (select/input) and its value
      if row.find('select').length > 0
        field = row.find('select:first')
        selection = field.find('option:selected').text()
      else if row.find('input[type="radio"]').length > 0
        field = row.find('input[type="radio"]:checked:first')
        selection = field.next('label').text()
      else if row.find('input[type="checkbox"]').length > 0 and row.find('.name').length > 0
        fields = row.find('input[type="checkbox"]:checked')
        selections = $.map(fields, (field) ->
          parent =  $(field).parent()
          nameField = parent.find('.name')
          selection = if nameField.prop('tagName') == 'INPUT' then nameField.val() else nameField.text()
          quantityInput = parent.find('input[type="number"]')
          if quantityInput.length > 0
            selection += ' (' + quantityInput.val() + ')'
          selection
        )
        selection = selections.join(', ')
      else if row.find('input[type="checkbox"]:checked').length == 1
        field = row.find('input[type="checkbox"]:checked')
        selection = field.next('label').text()
      else if row.find('input[type="text"]:visible, input[type="nunber"]:visible').length > 0
        field = row.find('input:first')
        selection = field.val()

      return if selection == null
      label = row.find('th label')

      # Append step to game table info
      tr = $(document.createElement('tr')).attr('field', label.attr('for'))
      tr.append(
        $('<th>').text(label.text())
      ).append(
        $('<td>').text(selection)
      )
      $('#games_window .data-table:last').append(tr)
    )

    currentStep.hide()

    nextStep = currentStep.next('.step')

    if nextStep.length == 1
      # Show next step
      nextStep.show()

      # Mark next step as current
      currentStep.removeClass 'current'
      nextStep.addClass 'current'
      nextStep.find('input, select').trigger('element:validate:pass')

      gameWindow = $('.tabs .window.game')
      gameTable = $('#game_table')
      gameForm = $('#game_form')

      $('.tabs nav .game').trigger('click')

      if nextStep.next('.step').length == 0
        # Last step
        $gameForm.find('.buttons .next-step').text('Save')
    else
      # Save
      loader = $('<img>').addClass('loader').attr('src', '/assets/loader.gif')
      $gameForm.hide().parent().append(loader)
      $.post($gameForm.attr('action'), $gameForm.serialize(), (data) ->
        $gameForm.show().parent().find('.loader').remove()

        if data.errors
          alert(data.errors)
        else
          $('#games_window').html(data.gamesTable)
          $('#games_window > .sub-tabs > span').bindSubTabs()
          $('#games_window > .sub-tabs > span:last').trigger 'click'

          $('#form_window > .window').html(data.selectGameForm)

          $('#game_select_form').bindSelectGameForm()
      )

    return false
  )

  # Back to previous step
  $gameForm.find('.back-step').on('click', () ->
    currentStep = $gameForm.find('.step.current')

    # Get previous step
    prevStep = currentStep.prev('.step')

    # Hide current step
    currentStep.hide()

    prevStep.find('tr').each((i, row) ->
      row = $(row)

      # Get field (select/input) and its value
      if row.find('select').length > 0
        field = row.find('select:first')
        value = field.find('option:selected').text()
      else if row.find('input[type="radio"]').length > 0
        field = row.find('input[type="radio"]:checked:first')
        value = field.val()
      else if row.find('input').length > 0
        field = row.find('input:first')
        value = field.val()

      label = row.find('th label')

      $('#games_window .data-table:last tr[field="'+label.attr('for')+'"]').remove()
    )

    if prevStep.length == 1
      prevStep.show().addClass('current')
    else
      # Back to select game form
      orderId = $('#order_id').val()
      loader = $('<img>').addClass('loader').attr('src', '/assets/loader.gif')
      $('#form_window > .window').html(loader)
      $('#form_window > .window').load(
        '/orders/'+orderId+'/games/select_form',
        () ->
          $('#select_game_form').bindSelectGameForm()
      )

      # Remove tab from Games
      $('#games_window .data-table:last').remove()
      $('#games_window > .sub-tabs > span:last').remove()
      $('#games_window > .sub-tabs > span:last').trigger 'click'

      gamesCounter = $('#games_counter')
      gamesCounter.text(parseInt(gamesCounter.text())-1)

    currentStep.removeClass 'current'

    $gameForm.find('.buttons .next-step').html("Next &raquo;")

    return false
  )

  $species = $(gameForm['game[species]'])
  $species.on('change', () ->
    if this.value == 'Other'
      $(this).next('.name').show()
    else
      $(this).parent().find('.name').val('').trigger('change').trigger('focusout').hide()
  ).trigger 'change'

  # Bind origin radio buttons to switch between licence + kill tag and MLDP
  $origin = $(gameForm['game[origin]'])
  $huntingLicenceNr = $(gameForm['game[hunting_licence_nr]'])
  $huntingLicenceNrStep = $huntingLicenceNr.parents('tr')
  $killTag = $(gameForm['game[kill_tag]'])
  $killTagStep = $killTag.parents('tr')
  $MLDP = $(gameForm['game[mldp]'])
  $MLDPStep = $MLDP.parents('tr')
  $origin.on('change', () ->
    return true if !this.checked
    if this.value == 'hunted'
      $huntingLicenceNrStep.show()
      $killTagStep.show()
      $MLDPStep.hide()
    else if this.value == 'domestic'
      $huntingLicenceNrStep.hide()
      $killTagStep.hide()
      $MLDPStep.show()
  ).trigger('change')

  # Bind "No" checkboxes to disable corresponding input
  $noHuntingLicenceNr = $(gameForm['game[no_hunting_licence_nr]'])
  $noHuntingLicenceNr.bindNoCheckbox($huntingLicenceNr)
   # Bind "No Licence" checkbox to hide kill tag when checked
  $noHuntingLicenceNr.on('change', () ->
    $noKillTag.attr('checked', this.checked).trigger('change').parent().hide()
  )

  $noKillTag = $(gameForm['game[no_kill_tag]'])
  $noKillTag.bindNoCheckbox($killTag)

  $noMLDP = $(gameForm['game[no_mldp]'])
  $noMLDP.bindNoCheckbox($MLDP)

  $condition = $(gameForm['game[condition]'])
  $weight = $(gameForm['game[weight]'])
  $weightStep = $weight.parents('tr')
  $partsStep = $gameForm.find('.partsStep')
  $lugsQuantity = $(gameForm['game[lugs_quantity]'])
  $lugsQuantityStep = $lugsQuantity.parents('tr')

  $condition.on('change', () ->
    # Show parts checkboxes and hide weight input
    # when "Parts" condition selected
    if this.value == 'Parts'
      $weightStep.hide()
      $partsStep.show()
    else
      $partsStep.hide()
      $weightStep.show()

      # Show lugs quantity input
      # when condition other than 'Skin On' and 'Skin Off' selected
    if this.value != 'Skin On' && this.value != 'Skin Off'
      $lugsQuantityStep.show()
    else
      $lugsQuantityStep.hide()
  ).trigger('change')

  $unableToWeigh = $('#game_unable_to_weigh')
  $unableToWeigh.bindNoCheckbox($weight)

  # Show quantity input when part checkbox checked
  $partsStep.find('input[type="checkbox"]').on('change', () ->
    $(this).parent().find('input[type="number"]').toggle(this.checked)
  ).trigger('change')

  # Show input for custom part name when "Other" part checked
  $partsStep.find('input[type="checkbox"]:last').on('change', () ->
    $(this).parent().find('.name').toggle(!this.checked)

    otherName = $(this).parent().find('.other-name')
    otherName.toggle(this.checked)
    if !this.checked
      otherName.val('').trigger('change').trigger('focusout')
  ).trigger('change')


  $frozenInIceChest = $('#game_frozen_in_ice_chest')
  $iceChestsQuantity = $(gameForm['game[ice_chests_quantity]'])

  $frozenInIceChest.on('change', () ->
    # Toggle input for Ice Chests Quantity
    $iceChestsQuantity.toggle(this.checked)
    if this.checked
      $iceChestsQuantity.trigger('change')

    # Toggle check "Unable to Weigh"
    $unableToWeigh.attr('checked', this.checked).trigger('change')
  ).trigger('change')

  $iceChestsQuantity.on('change', () ->
    # If condition other than "Unable To Describe" is selected
    # then enter the same value to Lugs Quantity input
    if $condition.val() != 'Unable To Describe'
      $lugsQuantity.val(this.value).trigger('change').trigger('focusout')
  )


  $miscItemsStep = $('#misc_items_step')

  $otherForAmericanTaxidermy = $miscItemsStep.find('.taxidermy .other')
  $otherForAmericanTaxidermyName = $otherForAmericanTaxidermy.parent().find('.name')

  $county = $(gameForm['game[county]'])
  $ranch = $(gameForm['game[ranch]'])

  $countyStep = $county.parents('tr')
  $ranchStep = $ranch.parents('tr')

  $otherForAmericanTaxidermy.on('change', () ->
    $otherForAmericanTaxidermyName.toggle this.checked
    if !this.checked
      $otherForAmericanTaxidermyName.val('').trigger('change').trigger('focusout')
  ).trigger('change')

  scanTaxidermyCheckboxes = () ->
    if $miscItemsStep.find('.taxidermy input[type="checkbox"]:checked').length > 0
      $countyStep.add($ranchStep).show()
    else
      $countyStep.add($ranchStep).hide()

  $miscItemsStep.find('.taxidermy input[type="checkbox"]').on('change', scanTaxidermyCheckboxes)
  scanTaxidermyCheckboxes()

  return this
$(document).ready(() ->
  $('#select_game_form').bindSelectGameForm()
)
