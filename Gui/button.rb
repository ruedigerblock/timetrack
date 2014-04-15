module Gui
  class Button < Gtk::Button
    def initialize (text,entry)
      super (text)
      @entry = entry

    self.signal_connect "clicked" do
      adder = case self.label
        when "<" then "-0.25"
        when "<<" then "-0.5"
        when ">" then "0.25"
        when ">>" then "0.5"
      end

      result = (@entry.text.to_f+adder.to_f)
      if result >= 0
        @entry.text=result.to_s
      end
    end

  end                                                                                                           

  def get_f
    puts f
  end

  end
end
