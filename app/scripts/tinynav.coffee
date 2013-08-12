# original version: https://github.com/viljamis/TinyNav.js/blob/master/tinynav.js
# write for practise

(($) ->
  $.fn.tinyNav = (options) ->
    # defaults
    defaults =
      breakpoint: '600px' # String: Responsive breakpoint for tinyNav
      header: '' # String: Specify text for "header" and show header instead of the active item

    settings = $.extend({}, defaults, options)

    return this.each( ->
      nav = $(@)
      
      console.log settings

      list = ''
      nav.find("a").each( ->
        a = $(@)
        link = a.attr('href')
        text = a.text()

        li = "<option vlaue= '#{link}'>#{text}</option>"
        list = list.concat(li)
      )

      console.log list
    )

)(jQuery)

# my solution( learn from css tricks):
# 1 loop through nav build a '<option></option>' for each '<li></li>', hide link in 'value' attribute, wrap in '<select></select>'
# 2 hide orginal nav and show the build nav when window.width() reach breakpoint
# 3 go to the option vlaue address when selected

# to improve:　
# - make it support mul-level nav, by add '-' before subNav and '--' to the third level nav