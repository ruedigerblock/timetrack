module Gui
  class Window < Gtk::Window
    def initialize
      super

      init_ui
      show_all

    end

    def init_ui
      set_title "timetracking"
      signal_connect "destroy" do
        Gtk.main_quit
      end

      hbox = Gtk::HBox.new(false, 0)
      vonbis_table = Gtk::Table.new(5,1, false)
      von_label = Gtk::Label.new "von"
      bis_label = Gtk::Label.new "bis"

      von_kl_button = Gtk::Button.new "<"
      von_entry     = Gtk::Entry.new
      von_entry.max_length=5
      von_entry.text="8,5"
      von_entry.width_chars=5
      von_gr_button = Gtk::Button.new ">"
      bis_kl_button = Gtk::Button.new "<"
      bis_entry     = Gtk::Entry.new
      bis_entry.max_length=5
      bis_entry.text="17,0"
      bis_entry.width_chars=5
      bis_gr_button = Gtk::Button.new ">"

      vonbis_table.attach von_label, 1,2,0,1
      vonbis_table.attach bis_label, 4,5,0,1
      vonbis_table.attach von_kl_button , 0,1,1,2
      vonbis_table.attach von_entry     , 1,2,1,2
      vonbis_table.attach von_gr_button , 2,3,1,2
      vonbis_table.attach bis_kl_button , 3,4,1,2
      vonbis_table.attach bis_entry     , 4,5,1,2
      vonbis_table.attach bis_gr_button , 5,6,1,2

      calendar = Gtk::Calendar.new

      hbox.pack_start vonbis_table, true, true, 0
      hbox.pack_start calendar, true, true, 0

      add hbox

    end

  end
end
