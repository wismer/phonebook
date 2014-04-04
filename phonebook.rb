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

end

Phonebook.new.create "der"
