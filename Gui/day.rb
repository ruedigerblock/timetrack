module Gui
  class Day
    attr_accessor :date_label, :start_entry, :break_entry, :end_entry, 
                  :result_label, :dayname, :number
    def initialize (dayname,number)
      @dayname=dayname
      @number=number
      @table=Gtk::Table.new 0,0,false
      create_dayname_label
     
      @date_label   = Gtk::Label.new
      @date_label.height_request=25
      @start_entry  = Gui::Entry.new
      @break_entry  = Gui::Entry.new
      @end_entry    = Gui::Entry.new
      @result_label = Gtk::Label.new "0.0"
      @result_label.height_request=25

      @table.attach @date_label   ,0,1,1,2,Gtk::EXPAND | Gtk::FILL,0,0,0
      @table.attach @start_entry  ,0,1,2,3,Gtk::EXPAND | Gtk::FILL,0,0,0
      @table.attach @break_entry  ,0,1,3,4,Gtk::EXPAND | Gtk::FILL,0,0,0
      @table.attach @end_entry    ,0,1,4,5,Gtk::EXPAND | Gtk::FILL,0,0,0
      @table.attach @result_label ,0,1,5,6,Gtk::EXPAND | Gtk::FILL,0,0,1

    end

    def create_dayname_label
      dayname_label = Gtk::Label.new "#{@dayname}"
      dayname_label.angle=90
      dayname_label.height_request=80
      dayname_label.yalign=1
    @table.attach dayname_label,0,1,0,1,Gtk::EXPAND | Gtk::FILL, Gtk::FILL,1,0

    end

    def get_table
      return @table
    end
  end
end
