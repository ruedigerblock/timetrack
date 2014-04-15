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

      hbox = Gtk::HBox.new(true, 0)
      vbox = Gtk::VBox.new(false, 0)
      
      #### CALENDAR
      calendar = Gtk::Calendar.new
      calendar.show_heading=true
      calendar.show_week_numbers=true
      calendar.show_day_names=true

      #### DATE

#      date = Date.new(calendar.date.to_a)
#      puts date
      
      #### VON-BIS TABLE
      vonbis_table = Gtk::Table.new(6,6, false)

      d = calendar.date
      date = Date.new(d[0],d[1],d[2])
      date_label = Gtk::Label.new
      date_label.set_markup("<big><b>#{date.strftime('%A %d %B %Y')}</b></big>")

      von_label = Gtk::Label.new "von"
      von_entry     = Gtk::Entry.new
      von_entry.max_length=5
      von_entry.text="8.5"
      von_entry.width_chars=5
      von_gg_button = Button.new ">>" ,von_entry
      von_k_button  = Button.new "<"  ,von_entry
      von_kk_button = Button.new "<<" ,von_entry
      von_g_button  = Button.new ">"  ,von_entry

      pause_label = Gtk::Label.new "pause"
      pause_entry = Gtk::Entry.new
      pause_entry.max_length=5
      pause_entry.text="0.5"
      pause_entry.width_chars=5
      pause_gg_button = Button.new ">>" ,pause_entry
      pause_k_button  = Button.new "<"  ,pause_entry
      pause_kk_button = Button.new "<<" ,pause_entry
      pause_g_button  = Button.new ">"  ,pause_entry

      bis_label = Gtk::Label.new "bis"
      bis_entry     = Gtk::Entry.new
      bis_entry.max_length=5
      bis_entry.text="17.0"
      bis_entry.width_chars=5
      bis_gg_button = Button.new ">>" ,bis_entry
      bis_k_button  = Button.new "<"  ,bis_entry
      bis_kk_button = Button.new "<<" ,bis_entry
      bis_g_button  = Button.new ">"  ,bis_entry

      expand        = Gtk::Label.new 
      expand1        = Gtk::Label.new 

      vonbis_table.attach date_label    ,0,5,0,1
      vonbis_table.attach von_label     ,0,5,1,2
      vonbis_table.attach von_k_button  ,0,1,2,3
      vonbis_table.attach von_kk_button ,1,2,2,3
      vonbis_table.attach von_entry     ,2,3,2,3
      vonbis_table.attach von_gg_button ,3,4,2,3
      vonbis_table.attach von_g_button  ,4,5,2,3
      
      vonbis_table.attach pause_label     ,0,5,3,4
      vonbis_table.attach pause_k_button  ,0,1,4,5
      vonbis_table.attach pause_kk_button ,1,2,4,5
      vonbis_table.attach pause_entry     ,2,3,4,5
      vonbis_table.attach pause_gg_button ,3,4,4,5
      vonbis_table.attach pause_g_button  ,4,5,4,5
      
      vonbis_table.attach bis_label     ,0,5,5,6
      vonbis_table.attach bis_k_button  ,0,1,6,7
      vonbis_table.attach bis_kk_button ,1,2,6,7
      vonbis_table.attach bis_entry     ,2,3,6,7
      vonbis_table.attach bis_gg_button ,3,4,6,7
      vonbis_table.attach bis_g_button  ,4,5,6,7

      vonbis_table.attach expand        ,0,1,7,8
    

      #### TASKS
      
      task_table = Gtk::Table.new(5,1, false)
      
      task = Task.new
      task1 = Task.new

      task_table.attach task.get_task_table, 0,1,0,1
      task_table.attach task1.get_task_table, 0,1,1,2

      hbox.pack_start calendar, false, true, 0
      hbox.pack_start vonbis_table, false, true, 0

      vbox.pack_start hbox, true, true, 0
      vbox.pack_start task_table, true, true, 0

      add vbox

    end

  end

end
