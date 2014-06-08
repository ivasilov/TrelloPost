in_node_webkit = (typeof require == 'function')

if in_node_webkit
  gui = window.require 'nw.gui'

  tray = new gui.Tray({ icon: 'assets/images/tray_icon.png' })
  tray.on('click', () ->
    gui.Window.get().show()
  )
