module Gui 
  class Task
    def initialize(w)
      @window = w
      @task_table = Gtk::Table.new(1, 6, false)
      task_remover    = Gtk::Button.new "-"
      task_proj_combo = Gtk::ComboBoxEntry.new(true)
      task_proj_combo.child.max_length=7
      task_proj_combo.child.width_chars=7
      task_name_entry = Gtk::Entry.new
      task_zeit_entry = Gtk::Entry.new
      task_zeit_entry.max_length = 5
      task_zeit_entry.width_chars = 5
      task_zeit_entry.text = "0.00"
      task_k_button   = Button.new "<"   , task_zeit_entry
      task_kk_button  = Button.new "<<"  , task_zeit_entry
      task_gg_button  = Button.new ">>"  , task_zeit_entry
      task_g_button   = Button.new ">"   , task_zeit_entry
      @task_table.attach task_remover    , 0, 1, 0, 1
      @task_table.attach task_proj_combo , 1, 2, 0, 1
      @task_table.attach task_name_entry , 2, 3, 0, 1
      @task_table.attach task_k_button   , 3, 4, 0, 1
      @task_table.attach task_kk_button  , 4, 5, 0, 1
      @task_table.attach task_zeit_entry , 5, 6, 0, 1
      @task_table.attach task_gg_button  , 6, 7, 0, 1
      @task_table.attach task_g_button   , 7, 8, 0, 1

      task_remover.signal_connect "clicked" do 
        @window.remove_task(@task_table)
      end

      task_proj_combo.signal_connect "changed" do
        puts task_proj_combo.active_text
      end

      task_proj_combo.child.signal_connect "activate" do
        task_proj_combo.append_text task_proj_combo.active_text
      end

      task_name_entry.signal_connect "activate" do
        @window.create_task (@window)
      end
      @task_table.each do |child|
        child.show
      end

      @task_table.show

    end
    
    def get_task_table
      return @task_table
    end

  end
end

