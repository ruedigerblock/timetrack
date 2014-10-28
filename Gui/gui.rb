module Gui
  class Window < Gtk::Window
    def initialize
      super

      @config=Gui::IO.load_config
      @width, @height=default_size
      @data=Gui::IO.load_data(2014)

      init_ui
      show_all

    end

    def init_ui
      set_title "timetrack"
      self.set_default_size 800,300
   #   self.resizable=(false)
      build_ui
      signal_connect "destroy" do
        Gtk.main_quit
        Gui::IO.write_data 2014,@data
      end

    end

    def build_ui
      sw = Gtk::ScrolledWindow.new
      add(sw)

      maintable = Gtk::Table.new 0,0

      4.times do |i|
        cw = Gui::Calendarweek.new
        maintable.attach cw i,i+1,0,0
      end

    end
  end
end
