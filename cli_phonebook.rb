#!/usr/bin/env ruby

require 'phonebook.rb'

command = ARGV[0].to_sym
Phonebook.new.send(command, ARGV[1])
