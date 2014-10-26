module Gui
  class Window < Gtk::Window
    def initialize
      super

      @config=Gui::IO.load_config
      @width, @height=default_size
      @data=Gui::IO.load_data(2014)

      init_ui
      show_all

    end

    def init_ui
      set_title "timetrack"
      self.resizable=(false)
      build_ui
      signal_connect "destroy" do
        Gtk.main_quit
        Gui::IO.write_data 2014,@data
      end

    end

    def build_ui
      @date=DateTime.now
      @widgets = { 'Header' => Hash.new, 'KWs' => Array.new, 'Days' => Hash.new }
      
      @main_table = Gtk::Table.new 0,0, true
      add(@main_table)

      main_table_left_button = Gtk::Button.new "<"
      main_table_left_button.signal_connect "clicked" do
        fill_ui @main_table, @widgets, @date-=30
      end
      main_table_month_label = Gtk::Label.new
      @widgets['Header']['month_label'] = main_table_month_label
      main_table_year_label = Gtk::Label.new 
      @widgets['Header']['year_label'] = main_table_year_label
      main_table_right_button = Gtk::Button.new ">"
      main_table_right_button.signal_connect "clicked" do
        fill_ui @main_table, @widgets, @date+=30
      end
      @main_table.attach main_table_left_button, 0, 1, 0, 1
      @main_table.attach main_table_month_label, 1, 10, 0, 1
      @main_table.attach main_table_year_label,  20, 35, 0, 1
      @main_table.attach main_table_right_button,35, 36, 0, 1

      1.step(35,7) do |i|
        label = Gtk::Label.new
        @main_table.attach label, i, i+1, 1, 2
        @widgets['KWs'] << label
      end
      
      36.times do |i|

        table = Gtk::Table.new 0, 0, false
        table.name=i.to_s

        if i==0
          weekday_label = Gtk::Label.new ("")
          weekday_label.angle=90
          weekday_label.height_request=70
          
          date_label = Gtk::Label.new ("Date")
          start_label = Gtk::Label.new ("start")
          break_label = Gtk::Label.new ("break")
          end_label = Gtk::Label.new ("end")
          result_label = Gtk::Label.new ("=")

          table.attach weekday_label, 0, 1, 0, 1
          table.attach date_label   , 0, 1, 1, 2          
          table.attach start_label  , 0, 1, 2, 3
          table.attach break_label  , 0, 1, 3, 4
          table.attach end_label    , 0, 1, 4, 5
          table.attach result_label , 0, 1, 5, 6

        else 
          temp_date=get_date @date
          dayname = (temp_date+i-1).strftime("%A")
          weekday_label = Gtk::Label.new dayname
          weekday_label.angle=90
          weekday_label.height_request=80
          if dayname == "Saturday" or dayname == "Sunday"
            weekday_label.set_markup ("<i><b>#{dayname}</b></i>")
          end
  
          @widgets['Days'][i.to_s] = Hash.new

          day_entry = Gtk::Entry.new
          day_entry.width_chars=2
          day_entry.editable=false
          @widgets['Days'][i.to_s]['day_entry']=day_entry

          start_entry = Entry.new
          start_entry.width_chars=4
          @widgets['Days'][i.to_s]["start_entry"]=start_entry

          break_entry = Entry.new
          break_entry.width_chars=4
          @widgets['Days'][i.to_s]["break_entry"]=break_entry

          end_entry = Entry.new
          end_entry.width_chars=4
          @widgets['Days'][i.to_s]["end_entry"]=end_entry
          
          result_entry = Gtk::Entry.new
          result_entry.width_chars=4
          @widgets['Days'][i.to_s]["result_entry"]=result_entry
          
          table.attach weekday_label        , 0, 1, 0, 1
          table.attach day_entry    , 0, 1, 1, 2
          table.attach start_entry  , 0, 1, 2, 3
          table.attach break_entry  , 0, 1, 3, 4
          table.attach end_entry    , 0, 1, 4, 5
          table.attach result_entry , 0, 1, 5, 6

        end
        @main_table.attach table, i,i+1,2,10

      end

      fill_ui @main_table, @widgets, @date

    end

    def fill_ui (mt,ws,dt)
      widgets = ws
      date = dt
      temp_date=get_date date
      
      widgets['Header']['month_label'].text=date.strftime("%B")
      widgets['Header']['year_label'].text=date.strftime("%Y")
      
      widgets['KWs'].each_with_index do |w,i|
        w.text=(temp_date.cweek+i).to_s
      end
     
      widgets['Days'].each_with_index do |widget,i|
        day = (temp_date+i).day

        widgets['Days'][(i+1).to_s].each do |widget|
          widget[1].text=""
        end
        
        widgets['Days'][(i+1).to_s]["start_entry"].name="#{(temp_date+i)}_start"
        widgets['Days'][(i+1).to_s]["break_entry"].name="#{(temp_date+i)}_break"
        widgets['Days'][(i+1).to_s]["end_entry"].name="#{(temp_date+i)}_end"
        
        save = @data[(temp_date+i).to_date]

        if save
          _start=save["start"]
          _break=save["break"]
          _end=save["end"]
          _result=_end.to_f-_break.to_f-_start.to_f
          widgets['Days'][(i+1).to_s]["start_entry"].text=_start.to_s
          widgets['Days'][(i+1).to_s]["break_entry"].text=_break.to_s
          widgets['Days'][(i+1).to_s]["end_entry"].text=_end.to_s
          widgets['Days'][(i+1).to_s]["result_entry"].text=_result.to_s
        end
        widgets['Days'][(i+1).to_s]["day_entry"].text=day.to_s
        widgets['Days'][(i+1).to_s]['day_entry'].modify_base Gtk::STATE_NORMAL, Gdk::Color.new(65000,65000,65000)
        
        if (temp_date+i).month != date.month 
          widgets['Days'][(i+1).to_s]['day_entry'].modify_base Gtk::STATE_NORMAL, Gdk::Color.new(20000,20000,20000)
        end
      end
    end

    def get_date (date)
      first=Date.new(date.year,date.month,1)
      temp_date=first-first.wday+1
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

    def set_data(w,name,data)
      w=w.split('-')
      date=Date.new(w[0].to_i,w[1].to_i,w[2].to_i)

      if !@data[date]
        tmp = { date => { "start" => "", "break" => "", "end" => ""} }
        @data.merge!(tmp)
      end

      @data[date]["#{name}"]=data
      fill_ui @main_table, @widgets, @date
    end

  end

end
