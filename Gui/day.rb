module Gui
  class Day
    def initialize (dayname)
      @dayname=dayname
      @table=Gtk::Table.new 0,0
      create_dayname_label
    end

    def dayname
      return @dayname
    end

    def create_dayname_label
      dayname_label = Gtk::Label.new @dayname
      dayname_label.angle=90
      @table.attach dayname_label,0,1,0,1
    end


    def get_table
      return @table
    end
  end
end
