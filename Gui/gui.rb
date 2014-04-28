require 'date'

module Gui
  class Window < Gtk::Window
    def initialize
      super

      @config=Gui::IO.load_config
      @width, @height=default_size
      
      init_ui
      show_all

    end

    def init_ui
      set_title "timetrack"
      self.resizable=(false)

      signal_connect "destroy" do
        Gtk.main_quit
        update_data
        Gui::IO.write_data @calendar.year,@data
      end


      hbox = Gtk::HBox.new(true, 0)
      vbox = Gtk::VBox.new(false, 0)
      
      #### CALENDAR
      @calendar = Gtk::Calendar.new
      @calendar.show_heading=true
      @calendar.show_week_numbers=true
      @calendar.show_day_names=true

      #### Entry

      @von_entry = Gtk::Entry.new
      @pause_entry = Gtk::Entry.new
      @bis_entry = Gtk::Entry.new
      
      @data = Gui::IO.load_data @calendar.year

      @calendar.signal_connect "day-selected" do
        d = @calendar.date
        date = Date.new(d[0],d[1],d[2])
        day =  date.strftime('%A')
        datum = date.strftime('%d %B %Y')
        self.set_title "#{day} #{datum}"
        update_von_bis date
        update_summe
        delete_tasks
        add_tasks date
      end

      #### VON-BIS TABLE
      vonbis_table = Gtk::Table.new(6,6, false)

      @von_label = Gtk::Label.new "von"      
      @von_entry = Gtk::Entry.new
      @von_entry.max_length=5
      @von_entry.width_chars=5
      @von_gg_button = Button.new ">>" , @von_entry
      @von_k_button  = Button.new "<"  , @von_entry
      @von_kk_button = Button.new "<<" , @von_entry
      @von_g_button  = Button.new ">"  , @von_entry
      @pause_label = Gtk::Label.new "pause"
      @pause_entry = Gtk::Entry.new
      @pause_entry.max_length=5
      @pause_entry.width_chars=5
      @pause_gg_button = Button.new ">>" , @pause_entry
      @pause_k_button  = Button.new "<"  , @pause_entry
      @pause_kk_button = Button.new "<<" , @pause_entry
      @pause_g_button  = Button.new ">"  , @pause_entry

      @bis_label = Gtk::Label.new "bis"
      @bis_entry     = Gtk::Entry.new
      @bis_entry.max_length=5
      @bis_entry.width_chars=5
      @bis_gg_button = Button.new ">>" , @bis_entry
      @bis_k_button  = Button.new "<"  , @bis_entry
      @bis_kk_button = Button.new "<<" , @bis_entry
      @bis_g_button  = Button.new ">"  , @bis_entry

      @summe        = Gtk::Label.new

      vonbis_table.attach @von_label     ,0,5,0,1
      vonbis_table.attach @von_k_button  ,0,1,1,2
      vonbis_table.attach @von_kk_button ,1,2,1,2
      vonbis_table.attach @von_entry     ,2,3,1,2
      vonbis_table.attach @von_gg_button ,3,4,1,2
      vonbis_table.attach @von_g_button  ,4,5,1,2
      
      vonbis_table.attach @pause_label     ,0,5,2,3
      vonbis_table.attach @pause_k_button  ,0,1,3,4
      vonbis_table.attach @pause_kk_button ,1,2,3,4
      vonbis_table.attach @pause_entry     ,2,3,3,4
      vonbis_table.attach @pause_gg_button ,3,4,3,4
      vonbis_table.attach @pause_g_button  ,4,5,3,4
      
      vonbis_table.attach @bis_label     ,0,5,4,5
      vonbis_table.attach @bis_k_button  ,0,1,5,6
      vonbis_table.attach @bis_kk_button ,1,2,5,6
      vonbis_table.attach @bis_entry     ,2,3,5,6
      vonbis_table.attach @bis_gg_button ,3,4,5,6
      vonbis_table.attach @bis_g_button  ,4,5,5,6
     
      vonbis_table.attach @summe  ,0,5,6,7

      #### TASKS
      
      @task_table = Gtk::Table.new(1,7, false)      
      @task_array = Array.new

      new_task_button = Gtk::Button.new "+"
      new_task_button.set_size_request 450,31
      new_task_button.signal_connect "clicked" do
        create_task(self)
      end

      hbox.pack_start @calendar, false, true, 0
      hbox.pack_start vonbis_table, false, true, 0

      vbox.pack_start hbox, true, true, 0
      vbox.pack_start @task_table, true, true, 0
      vbox.pack_start new_task_button, true, true, 0

      @calendar.day=@calendar.day
      add vbox

    end

    def create_task(window,proj=nil,text="",dur="0.0")
      task = Task.new(window,proj,text,dur)
      n = @task_table.n_rows
      @task_table.attach task.get_task_table, 0,1,n,n+1
    end  

    def remove_task(task)
      count = -1
      @task_table.each do
        count+=1
      end
      @task_table.remove(task)
      @task_table.resize(@task_table.n_rows-1,1)
      self.set_default_size @width,@height
    end

    def update_data
      d = @calendar.date
      date = Date.new(d[0],d[1],d[2])
      jobs = {}

      temp_a = Array.new
      @task_table.each do |child|
        temp_a << child
      end

      temp_a = temp_a.reverse
      i=0
      temp_a.each do |child|
        a = Array.new
        child.each do |c|
          a<<c
        end
        proj = a[6].active_text
        text  = a[5].text
        dura  = a[2].text
        job = {
            i => {
          'name' => proj,
          'text' => text,
          'duration' => dura
          }
        }
        jobs.merge!(job)
        i+=1
      end
       @data[date] = {
         'start' => @von_entry.text,
         'break' => @pause_entry.text,
         'end'   => @bis_entry.text,
         'jobs' => jobs
       }
        update_summe
    end

    def update_von_bis(date)

      if !@data[date] 
          day = {
            date => {
              'start' => @config['general']['start'],
              'break' => @config['general']['break'],
              'end'   => @config['general']['end'],           
              'jobs'=> {}
            }
          }
          @data.merge!(day)
      end
    
      @von_entry.text   = @data[date]['start'].to_s.chomp
      @pause_entry.text = @data[date]['break'].to_s.chomp
      @bis_entry.text   = @data[date]['end'].to_s.chomp

    end

    def update_summe
      summe = @bis_entry.text.to_f - @von_entry.text.to_f - @pause_entry.text.to_f
      case
        when summe < 8 then color = "red"
        else color = "green"
      end
        
      @summe.set_markup("<big><b><span foreground='#{color}'>#{summe}</span></b></big>")

    end

    def delete_tasks
      @task_table.each do |task|
        remove_task task
      end
    end

    def add_tasks (date)
      @data[date]['jobs'].each do |job|
        create_task self, job[1]['name'], job[1]['text'], job[1]['duration']
      end
      
    end
      
    def config
      return @config
    end

  end

end
