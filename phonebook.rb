class Phonebook

  def create(filename)
    filename += ".pb"
    if !File.exists? filename
      File.new "phonebooks/" + filename, 'w'
      puts "New phonebook \"#{filename}\" created"
    else
      puts "File already exists!"
    end
  end

  def print(filename)

    path = "phonebooks/#{filename}.pb"

    if File.exists? path
      puts File.read path
    else
      puts "File doesn't exist!"
    end
  end

end
