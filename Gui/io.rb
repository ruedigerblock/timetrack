module Gui::IO
  def self.load_data(year)

    file="#{year}.db"

    unless File.exists?(file)
      output = File.new(file, "w")
      output.close
    end
    input = File.open (file)
    data=Array.new
    File.readlines(file).each do |line|
      data << line
    end  
    
    return data

  end
end

