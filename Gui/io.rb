module Gui::IO
  def self.load_data(year)

    file="#{year}.db"

    unless File.exists?(file)
      output = File.new(file, "w")
      date = Date.new(year)
      365.times do
        if date.year == year
          day=date.strftime('%A')

          string = case day
                   when "Saturday" then "#{date}§§§§"
                   when "Sunday" then "#{date}§§§§"
                   else "#{date}§8.5§0.5§17.0§"
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
end

