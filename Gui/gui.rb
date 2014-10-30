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
     #   Gui::IO.write_data 2014,@data
      end

    end

    def build_ui
      sw = Gtk::ScrolledWindow.new
      add(sw)

      maintable = Gtk::Table.new 0,0
      sw.add_with_viewport maintable

      inner_table = Gtk::Table.new 0,0, false
      outer_table = Gtk::Table.new 0,0
      outer_table.attach inner_table,0,1,0,1
      frame = Gtk::Frame.new "KW"
      frame.add outer_table

      label = Gtk::Label.new
      label.angle=90
      label.height_request=80

      start_label = Gtk::Label.new "start"
      start_label.height_request=25
      break_label = Gtk::Label.new "break"
      break_label.height_request=25
      end_label = Gtk::Label.new "end"
      end_label.height_request=25
      result_label = Gtk::Label.new "="
      result_label.height_request=25

      inner_table.attach label,0,1,0,1,Gtk::EXPAND | Gtk::FILL,0,0,0
      inner_table.attach start_label,0,1,1,2,Gtk::EXPAND | Gtk::FILL,0,0,0
      inner_table.attach break_label,0,1,2,3,Gtk::EXPAND | Gtk::FILL,0,0,0
      inner_table.attach end_label,0,1,3,4,Gtk::EXPAND | Gtk::FILL,0,0,0
      inner_table.attach result_label,0,1,4,5,Gtk::EXPAND | Gtk::FILL,0,0,1

      maintable.attach frame,0,1,0,1

      4.times do |i|
        cw = Gui::Calendarweek.new 41
        fill_ui cw
        maintable.attach cw.get_frame,1+i,1+i+1,0,1
      end
      show_all
    end
    
    def fill_ui cw
      cw.days.each do |day|
        date = Date.commercial(2014,(cw.number.to_i),(day.number.to_i)+1)
        if @data[date.to_date]
          store=@data[date.to_date]
          _start  = store["start"].to_f
          _break  = store["break"].to_f
          _end    = store["end"].to_f
          _result = _end-_break-_start

          day.start_entry.text  =_start.to_s
          day.break_entry.text  =_break.to_s
          day.end_entry.text    =_end.to_s
          day.result_label.text =_result.to_s
        end
      end
    end

  end
end
