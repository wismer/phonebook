require 'json'
require 'pry'
class Phonebook
  attr_accessor :filename, :content, :flag, :json_data

  def initialize(args)
    @file      = "phonebook.pb"
    @flag      = args.shift
    @content   = args
    @json_data = begin 
      JSON.parse(File.read(@file))
    rescue JSON::ParserError
      ''
    end
  end

  def help
    puts "Create a category: create cat <category>"
    puts "Create an entry: create entry <category> <name> <phone>"
    puts "Show all entries: show all"
    puts "Show all entries within a category: show <cat>"
    puts "Find for a specific entry: search <name> OR <phone>"
    puts "Edit a category: edit cat <category> <new cat>"
    puts "Delete a category: delete cat <category>"
    puts "Edit an entry: edit entry cat <category> name <name> <new name> OR phone <phone> <new phone>"
    puts "List Categories: list cat"
  end


  # -cat rickshaw
  # -new rickshaw <name> <phone>
  # -find -a <name>
  # -show
  def start
    case @flag
    when 'create'
      arg = @content.shift
      if arg == 'cat' || arg == 'category'
        create_category
      elsif arg == 'entry' || arg == 'name'
        create_entry
      else
        raise 'invalid option'
      end
    when 'show' || '-s'
      show_data
    when 'edit' || '-e'
      arg = @content.shift
      if arg == 'cat' || arg == 'category'
        edit_category
      elsif arg == 'entry'
        edit_entry
      else
        raise 'invalid option'
      end
    when 'help' || '-h'
      help
    when 'find' || '-f'
      find
    when 'delete'
      delete
    else
      raise 'incorrect parameter'
    end
  end

  def delete
    @json_data.delete(@content.shift)
    write_to_file
  end

  def edit_category
    old_cat, new_cat = @content
    if @json_data.has_key?(old_cat)
      @json_data[new_cat] = @json_data.delete(old_cat)
      write_to_file
    else
      raise 'Key not found'
    end
  end

  def find
    opt = Regexp.new @content.shift
    @json_data.each do |k, v|
      v.each do |val|
        if val['phone'] =~ opt
          puts "#{k}: NAME: #{val['name']} PHONE: #{val['phone']}"
        elsif val['name'] =~ opt
          puts "#{k}: NAME: #{val['name']} PHONE: #{val['phone']}"
        end
      end
    end
  end

  def edit_entry
    cat = @content.shift
    opt = @content.shift
    if opt == 'name'
      old_name, new_name = @content
      @json_data.each do |k,v|
        v.each do |val|
          if val['name'] == old_name
            val['name'] = new_name
          end
        end
      end
    elsif opt == 'phone'
      old_phone, new_phone = @content
      @json_data[cat].find{ |e| e['phone'] == old_phone }['phone'] = new_phone
    else
      raise 'invalid opts'
    end
    write_to_file
  end

  def show_data
    arg = @content.shift
    if arg == 'all'
      @json_data.each do |k, v|
        v.each do |val|
          puts "#{k}: NAME: #{val['name']} PHONE: #{val['phone']}"
        end
      end
    elsif @json_data[arg]
      puts "No entries were made yet for #{arg}." if @json_data[arg].empty?
      @json_data[arg].each { |k,v| puts "NAME: #{k['name']} PHONE: #{k['phone']}" }
    else
      raise 'invalid option'
    end
  end

  def create_category
    if @json_data.empty?
      File.open(@file, 'w') { |io| io << JSON.generate({"#{@content.shift}" => []}) }
    else
      @json_data[@content.shift] = []
      write_to_file
    end
  end

  def from_json
    JSON.parse(File.read(@file))
  end

  def write_to_file
    File.open(@file, "w") { |io| io << JSON.generate(@json_data) }
  end

  def create_entry
    cat, name, phone = @content

    if @json_data[cat] 
      @json_data[cat] << { name: name, phone: phone }
    else
      puts "That category was not found"
    end
    write_to_file
  end
end

x = Phonebook.new ARGV
x.start
