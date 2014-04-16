#!/usr/bin/env ruby

require 'gtk2'
require 'fileutils'
require './Gui/gui'
require './Gui/button'
require './Gui/task'
require './Gui/io'

Gtk.init
w=Gui::Window.new
Gtk.main
