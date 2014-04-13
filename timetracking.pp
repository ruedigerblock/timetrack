#!/usr/bin/env ruby

require 'gtk2'
require './Gui/gui'

Gtk.init
w=Gui::Window.new
Gtk.main
