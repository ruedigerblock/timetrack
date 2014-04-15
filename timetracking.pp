#!/usr/bin/env ruby

require 'gtk2'
require './Gui/gui'
require './Gui/button'
require './Gui/task'

Gtk.init
w=Gui::Window.new
Gtk.main
