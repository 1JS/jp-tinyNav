# original version: https://github.com/viljamis/TinyNav.js/blob/master/tinynav.js
# write for practise, no css needed

(($, window) ->
  $.fn.tinyNav = (options) ->
    # defaults
    defaults =
      breakpoint: 600   # String: Responsive breakpoint for tinyNav
      header: ''            # String: Specify text for "header" and show header instead of the active item

    #setting
    settings = $.extend({}, defaults, options)

    $window = $(window)   
    i = 0 # use for namespacing

    return this.each( ->
      $nav = $(@) # cache
      t = undefined # for setTimeout

      # namespacing
      i++
      namespace = 'tinynav' + i
      namespaceClass = '.' + namespace
      namespaceId = '#' + namespace
      $select = $('<select/>').attr('id', namespace)

      # build options, multi-level supported
      options = ''

      $nav
      .addClass("#{namespace} desktop-nav")
      .find("a").each( ->
        a = $(@) # cache

        options += '<option vlaue="' + a.attr('href') + '">'

        j = 0
        len = a.parentsUntil(namespaceClass, 'ul, ol').length
        options += '- ' for j in [1..len] by 1

        options += a.text() + '</option>'
      )

      # append options to a select
      $select.append(options)

      # select the active item
      index = $(namespaceClass + ' li').index( $(namespaceClass + ' li.active') )
      $select.find('option:eq(' + index + ')').attr('selected', true)

      # change window location on option change
      $select.change( (e)->
        console.log @
        console.log $(@).val()
        # window.location.href = $(@).val()
        e.preventDefault()
      )

      # inject select
      $(namespaceClass).after($select);


      # switch nav depend on window width
      switchNav = ->
        if ($window.width() < settings.breakpoint)
          $('.desktop-nav').hide()
          $(namespaceId).show()
        else
          $(namespaceId).hide()
          $('.desktop-nav').show()

      switchNav() # call function when page load

      # on window resize
      $window.resize( ->
        clearTimeout(t)
        t = setTimeout(switchNav, 200)
      )
    )

)(jQuery, window)

# my solution( learn from css tricks):
# 1 loop through nav build a '<option></option>' for each '<li></li>', hide link in 'value' attribute, wrap in '<select></select>'
# 2 hide orginal nav and show the build nav when window.width() reach breakpoint
# 3 go to the option vlaue address when selected
# 4 window.resize

# author's solution
# 1 namespacing -> 2 build options -> 3 Append options to a select -> 4 select the active item
# -> 5 change window location on change -> 6 inject select

# to improve:　
# - make it support mul-level nav, by add '-' before subNav and '--' to the third level nav

# drove me nuts:
# - $select.change, $(@).val() I get the text instead of option value.