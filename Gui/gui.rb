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
#        update_data
#        Gui::IO.write_data @calendar.year,@data
      end

      main_table = Gtk::Table.new 0,0
      add(main_table)

      header_table = Gtk::Table.new 2,0
      
      header_table_left_button = Gtk::Button.new "<"
      header_table_month_label = Gtk::Label.new ("Month")
      header_table_year_label = Gtk::Label.new ("Year")
      header_table_right_button = Gtk::Button.new ">"
      
      header_table.attach header_table_left_button, 0, 1, 0, 1
      header_table.attach header_table_month_label, 1, 2, 0, 1
      header_table.attach header_table_year_label,  2, 3, 0, 1
      header_table.attach header_table_right_button,3, 4, 0, 1

      main_table.attach header_table, 0, 45, main_table.n_columns, main_table.n_columns+1

      date=DateTime.now
      first=Date.new(date.year,date.month,1)
      temp_date=first-first.wday+1
 
      1.step(35,7) do |i|
        entry = Gtk::Entry.new
        entry.text=(first+i).strftime("%W")
        main_table.attach entry, i-1, i+6, main_table.n_columns+1, main_table.n_columns+2
      end

      35.times do |i|

        label = Gtk::Label.new ((temp_date+i).strftime("%A"))
        label.angle=90
        main_table.attach label, i, i+1, main_table.n_columns+2, main_table.n_columns+3
        
        day = (temp_date+i).day
        entry = Gtk::Entry.new
        entry.text=day.to_s
        entry.width_chars=2
        entry.editable=false
        main_table.attach entry, i, i+1, main_table.n_columns+3, main_table.n_columns+4

      end



    end

    def get_thirtyfive_days

      days = Array.new
      5.times do 
        Date::DAYNAMES.each do |day|
          days << day
        end
      end
      days.push days.shift
      return days 
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
        proj = a[2].active_text
        text  = a[1].text
        dura  = a[0].text
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

      dayname=date.strftime('%A')
      @von_entry.text = ""
      @pause_entry.text = ""
      @bis_entry.text = ""

      if !@data[date] and dayname != "Saturday" and dayname != "Sunday"
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
     
      if @data[date]
        @von_entry.text   = @data[date]['start'].to_s.chomp
        @pause_entry.text = @data[date]['break'].to_s.chomp
        @bis_entry.text   = @data[date]['end'].to_s.chomp
      end
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
      if @data[date]
        @data[date]['jobs'].each do |job|
          create_task self, job[1]['name'], job[1]['text'], job[1]['duration']
        end
      end    
    end
      
    def config
      return @config
    end

  end

end
