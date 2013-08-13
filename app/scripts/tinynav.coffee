# original version: https://github.com/viljamis/TinyNav.js/blob/master/tinynav.js
# write for practise, no css needed

(($, window) ->
  $.fn.tinyNav = (options) ->
    # defaults
    defaults =
      breakpoint: '600px'   # String: Responsive breakpoint for tinyNav
      header: ''            # String: Specify text for "header" and show header instead of the active item

    #setting
    settings = $.extend({}, defaults, options)

    i = 0 # use for namespacing

    return this.each( ->
      $nav = $(@) # cache

      # namespacing
      i++
      namespace = 'tinynav' + i
      $select = $('<select/>').attr('id', namespace)

      # build options, multi-level supported
      options = ''

      $nav
      .addClass(namespace)
      .find("a").each( ->
        a = $(@) # cache
        options += '<option vlaue="' + a.attr('href') + '">'

        # j = undefined
        len = a.parentsUntil('.' + namespace, 'ul, ol').length
        console.log len
        # for (j = 0; j < len; j++)
        j = 0
        options += '- ' for j in [1..len] by 1

        options += a.text() + '</option>'
      )

      console.log options

      # append options to a select
      $select.append(options)

      # select the active item


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