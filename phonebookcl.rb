#!/usr/bin/env ruby

command = ARGV[0].to_sym

class Phonebook
  def create(filename)
    filename += ".pb"
    if !File.exists? filename
      File.new filename, 'w'
      puts "New phonebook \"#{filename}\" created"
    else
      puts "File already exists!"
    end
  end
end

Phonebook.new.send(command, ARGV[1])
