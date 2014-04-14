require 'date'

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

      vbox = Gtk::VBox.new(false, 0)
      
      #### CALENDAR
      calendar = Gtk::Calendar.new
      calendar.show_heading=true
      calendar.show_week_numbers=true
      calendar.show_day_names=true
      puts calendar.style

      #### DATE

        puts calendar.inspect
#      date = Date.new(calendar.date.to_a)
#      puts date
      
      #### VON-BIS TABLE
      vonbis_table = Gtk::Table.new(7,1, false)
      von_label = Gtk::Label.new "von"
      bis_label = Gtk::Label.new "bis"

      von_k_button = Gtk::Button.new "<"
      von_kk_button = Gtk::Button.new "<<"
      von_entry     = Gtk::Entry.new
      von_entry.max_length=5
      von_entry.text="8.5"
      von_entry.width_chars=5
      von_gg_button = Gtk::Button.new ">>"
      von_g_button = Gtk::Button.new ">"
      bis_k_button = Gtk::Button.new "<"
      bis_kk_button = Gtk::Button.new "<<"
      bis_entry     = Gtk::Entry.new
      bis_entry.max_length=5
      bis_entry.text="17.0"
      bis_entry.width_chars=5
      bis_gg_button = Gtk::Button.new ">>"
      bis_g_button = Gtk::Button.new ">"

      vonbis_table.attach von_label, 1,2,0,1
      vonbis_table.attach bis_label, 4,5,0,1
      vonbis_table.attach von_k_button  , 0, 1,1,2
      vonbis_table.attach von_kk_button , 1, 2,1,2
      vonbis_table.attach von_entry     , 2, 3,1,2
      vonbis_table.attach von_gg_button , 3, 4,1,2
      vonbis_table.attach von_g_button  , 4, 5,1,2
      vonbis_table.attach bis_k_button  , 5, 6,1,2
      vonbis_table.attach bis_kk_button , 6, 7,1,2
      vonbis_table.attach bis_entry     , 7, 8,1,2
      vonbis_table.attach bis_gg_button , 8, 9,1,2
      vonbis_table.attach bis_g_button  , 9,10,1,2

      #### JOBS
      
      job_table = Gtk::Table.new(5,1, false)
      job_name = Gtk::Entry.new
      job_k_button = Gtk::Button.new ("<")
      job_kk_button = Gtk::Button.new ("<<")
      job_zeit = Gtk::Entry.new
      job_zeit.max_length=5
      job_zeit.text="0,00"
      job_zeit.width_chars=5
      job_gg_button = Gtk::Button.new (">>")
      job_g_button = Gtk::Button.new (">")

      job_table.attach job_name, 0,1,0,1
      job_table.attach job_k_button, 1,2,0,1
      job_table.attach job_kk_button, 2,3,0,1
      job_table.attach job_zeit, 3,4,0,1
      job_table.attach job_gg_button, 4,5,0,1
      job_table.attach job_g_button, 5,6,0,1

      vbox.pack_start calendar, true, true, 0
      vbox.pack_start vonbis_table, true, true, 0
      vbox.pack_start job_table, true, true, 0

      add vbox

    end

  end
end
