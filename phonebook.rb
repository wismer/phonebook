require 'json'
require 'pry'


class Phonebook

  attr_accessor :filename, :content, :params

  def initialize(filename, params)
    @filename = "phonebooks/" + filename += ".pb"
    @params = params
  end

  def phonebook?
    File.exists? @filename
  end

  def create
    if !phonebook?
      File.new @filename, 'w'
      puts "New phonebook \"#{@filename}\" created"
    else
      puts "File already exists!"
    end
  end

  def add
    @content[@params[0]] = @params[1]
  end

  def open
    @content ||= File.read @filename if phonebook?
    JSON.parse @content
  end

  def print
    # path = "phonebooks/#{filename}.pb"
    # if File.exists? path
    #   puts File.read path
    # else
    #   puts "File doesn't exist!"
    # end
  end

end

x = Phonebook.new "test"
binding.pry
