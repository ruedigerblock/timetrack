module Gui
  class Calendarweek 
    attr_accessor :result_tab
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
      @result_tab = Gui::ResultTab.new
      @table.attach @result_tab.get_table,7,8,0,1
    end

    def days
      return @days
    end
  end
  class ResultTab
    attr_accessor :result_label
    def initialize
      @result_table=Gtk::Table.new 0,0, false
      create_name_label

      empty_label1 = Gtk::Label.new
      empty_label1.height_request=25
      empty_label2 = Gtk::Label.new
      empty_label2.height_request=25
      empty_label3 = Gtk::Label.new
      empty_label3.height_request=25

      @result_label = Gtk::Label.new "0.0"
      @result_label.height_request=25
      @result_table.attach empty_label1 ,0,1,1,2,Gtk::EXPAND | Gtk::FILL,0,0,0
      @result_table.attach empty_label2 ,0,1,2,3,Gtk::EXPAND | Gtk::FILL,0,0,0
      @result_table.attach empty_label3 ,0,1,3,4,Gtk::EXPAND | Gtk::FILL,0,0,0
      @result_table.attach @result_label,0,1,4,5,Gtk::EXPAND | Gtk::FILL,0,0,1

    end

    def get_table
      return @result_table
    end

    def create_name_label
      label = Gtk::Label.new "Result"
      label.angle=90
      label.height_request=80
      label.yalign=1
      @result_table.attach label,0,1,0,1,Gtk::EXPAND | Gtk::FILL,0,0,0
    end
  end
end
