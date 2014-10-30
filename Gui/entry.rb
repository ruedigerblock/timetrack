module Gui
  class Entry < Gtk::Entry
    def initialize 
      super  
      self.width_chars=4
      self.signal_connect "scroll-event" do |w,e|
        case e.direction
          when Gdk::EventScroll::Direction::UP
            adder = "+0.25"
          when Gdk::EventScroll::Direction::DOWN
           adder = "-0.25"
        end
      result = (w.text.to_f+adder.to_f)
        if result >= 0
          w.text=result.to_s
        end
      end
      self.signal_connect "focus-out-event" do |w,e|
        date =  self.name.split('_').first
        name =  self.name.split('_').last
        data =  self.text
      #  self.parent.parent.parent.set_data date, name, data
      end
    end
  end
end
