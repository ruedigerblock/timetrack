module Gui::IO
  def self.load_data(year)

    file="#{year}.db"
    unless File.exists?(file)
      output = File.new(file, "w")
      output.close
    end
    
    data = YAML.load_file (file)    
    if data==false 
      data={}
    end

    return data

  end

  def self.write_data(year,data)
    file = "#{year}.db"
    File.open(file, 'w') {|f| f.write data.to_yaml}
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

