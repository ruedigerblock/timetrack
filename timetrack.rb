#!/usr/bin/env ruby

require 'gtk2'
require 'fileutils'
require 'yaml'
require_relative 'Gui/gui'
require_relative 'Gui/calendarweek'
require_relative 'Gui/day'
require_relative 'Gui/entry'
#require_relative 'Gui/task'
require_relative 'Gui/io'

Gtk.init
w=Gui::Window.new
Gtk.main
