$.fn.disableDigitsAndSymbols = () ->
  $.each(this, (i, input) ->
    $(input).on('keypress', (event) ->
      if(
        (event.which >= 48 && event.which <= 57) || # digits
        $.inArray(event.which, [ # symbols:
          126, # `
           96, # ~
           33, # !
           64, # @
           35, # #
           37, # %
           94, # ^
           38, # &
           42, # *
           40, # (
           41, # )
          #45, # -
           95, # _
           61, # =
           43, # +
           91, # [
           93, # ]
          123, # {
          125, # }
           59, # ;
           58, # :
           39, # '
           34, # "
           92, # \
          124, # |
           44, # ,
          #46, # .
           60, # <
           62, # >
           47, # /
           63, # ?
        ]) != -1
      )
        return false
      else
        return true
    )
  )
