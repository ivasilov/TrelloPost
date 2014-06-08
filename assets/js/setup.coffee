# TODO: Multi site support
# TODO: Caching for most remote data (prepopulate on first connect then update every X or forced)
# TODO: Support pagination


in_node_webkit = (typeof require == 'function')

if in_node_webkit
  gui = window.require 'nw.gui'

  tray = new gui.Tray({ icon: 'assets/images/tray_icon.png' })
  tray.on('click', () ->
    gui.Window.get().show()
  )


DEBUG = true
###
if (!DEBUG)
  if !window.console
    window.console = {}
  methods = ["log", "debug", "warn", "info"]
  for method in methods
    console[method] = ->
    ###
