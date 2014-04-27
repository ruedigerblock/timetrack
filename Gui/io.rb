module Gui::IO
  def self.load_data(year,config)

    file="#{year}.db"
    @config = config
    unless File.exists?(file)
      output = File.new(file, "w")
      date = Date.new(year)
      365.times do
        if date.year == year
          day=date.strftime('%A')
          st = @config['general']['start']
          br = @config['general']['break']
          en = @config['general']['end']
          string = case day
                   when "Saturday" then "#{date}§§§§"
                   when "Sunday" then "#{date}§§§§"
                   else "#{date}§#{st}§#{br}§#{en}§"
          end

          output.puts string
          date+=1
        end
      end
      output.close
    end
    input = File.open (file)
    data=Array.new
    File.readlines(file).each do |line|
      data << line
    end  
    
    return data

  end

  def self.write_data(year,data)
    
    @data = data
    file = "#{year}.db"

    output = File.new(file, 'w')
    data.each_with_index do |w,i|
      output.puts "#{@data[i]}"
    end
    output.close
  end

  def self.load_config
    file = "timetrack.yaml"
    unless File.exists?(file)
      config = {
        'general' => {
          'start' => "8.0",
          'break' => "0.5",
          'end'   => "16.5",
          },
        'projects' => ['Project_1','Project_2']
      }
      File.open(file, 'w') {|f| f.write config.to_yaml }
    end
    
    config = YAML.load_file ('timetrack.yaml')
    return config 

  end

end

