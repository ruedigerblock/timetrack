module Gui
  class Entry < Gtk::Entry
    def initialize 
      super   
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
#       w.parent.parent.parent.parent.update_data
      end
    end
  end
end
