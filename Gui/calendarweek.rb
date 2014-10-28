module Gui
  class Calendarweek 
    def initialize (number)
      @frame = Gtk::Frame.new number.to_s
      @table = Gtk::Table.new 0,0
      @frame.add(@table)
      create_days
      create_result
    end

    def get_frame
      return @frame
    end

    def create_days
      @days = []
      7.times do |i|
        day = Gui::Day.new(Date::DAYNAMES[i-6])
        @days << day
        @table.attach day.get_table,i,i+1,0,1
      end
    end

    def create_result
      rt = Gui::ResultTab.new
      @table.attach rt.get_table,7,8,0,1
    end
  end
  class ResultTab
    def initialize
      @result_table=Gtk::Table.new 0,0
      create_name_label
    end

    def get_table
      return @result_table
    end

    def create_name_label
      label = Gtk::Label.new "Result"
      label.angle=90
      @result_table.attach label,0,1,0,1
    end
  end
end
