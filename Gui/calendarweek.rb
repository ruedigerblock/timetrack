module Gui
  class Calendarweek 
    def initialize (number)
      @number = number
      @frame = Gtk::Frame.new @number.to_s
      @table = Gtk::Table.new 0,0,true
      @frame.add(@table)
      create_days
      create_result
    end

    def get_frame
      return @frame
    end

    def number
      return @number
    end

    def create_days
        @days = []
      7.times do |i|
        day = Gui::Day.new(Date::DAYNAMES[i-6],i) 
        @days << day
        @table.attach day.get_table,i,i+1,0,1
      end
    end

    def create_result
      rt = Gui::ResultTab.new
      @table.attach rt.get_table,7,8,0,1
    end

    def days
      return @days
    end
  end
  class ResultTab
    def initialize
      @result_table=Gtk::Table.new 0,0, false
      create_name_label

      start_entry = Gui::Entry.new
      break_entry = Gui::Entry.new
      @result_table.attach start_entry,0,1,1,2,Gtk::EXPAND | Gtk::FILL,0,0,0
      @result_table.attach break_entry,0,1,2,3,Gtk::EXPAND | Gtk::FILL,0,0,1

    end

    def get_table
      return @result_table
    end

    def create_name_label
      label = Gtk::Label.new "Result"
      label.angle=90
      label.height_request=80
      @result_table.attach label,0,1,0,1,Gtk::EXPAND | Gtk::FILL,0,0,0
    end
  end
end
