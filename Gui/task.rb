module Gui 
  class Task
    def initialize
      @task_table = Gtk::Table.new(6, 1, false)
      task_proj_combo = Gtk::ComboBoxEntry.new(false)
      task_name_entry = Gtk::Entry.new
      task_zeit_entry = Gtk::Entry.new
      task_zeit_entry.max_length = 5
      task_zeit_entry.width_chars = 5
      task_zeit_entry.text = "0.00"
      task_k_button   = Button.new "<"  , task_zeit_entry
      task_kk_button  = Button.new "<<" , task_zeit_entry
      task_gg_button  = Button.new ">>"  , task_zeit_entry
      task_g_button   = Button.new ">" , task_zeit_entry
      @task_table.attach task_proj_combo , 0, 1, 0, 1
      @task_table.attach task_name_entry , 1, 2, 0, 1
      @task_table.attach task_k_button   , 2, 3, 0, 1
      @task_table.attach task_kk_button  , 3, 4, 0, 1
      @task_table.attach task_zeit_entry , 4, 5, 0, 1
      @task_table.attach task_gg_button  , 5, 6, 0, 1
      @task_table.attach task_g_button   , 6, 7, 0, 1
    end
    
    def get_task_table
      return @task_table
    end

  end
end

