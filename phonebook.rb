require 'json'
require 'pry'


class Phonebook

  attr_accessor :filename, :content, :flag

  def initialize(args)
    @file     = "phonebook.pb"
    @flag     = args.shift
    @content  = args
  end


  # -cat rickshaw
  # -new rickshaw <name> <phone>
  # -find -a <name>
  # -show
  def start
    case @flag
    when '-c'
      # new category
      create_category
    when '-n'
      create_entry
    when '-show'
      show_data
    end
  end

  def show_data
    arg = @content.shift
    binding.pry
    if arg == "-a"
      name, phone = @content
      from_json.each do |k, v|
        v.each do |e|
          if e['name'].include?(name)
            puts e
          end
        end
      end
    end
  end

  def create_category(cat=nil)
    data = File.read(@file)
    if data.empty?
      File.open(@file, 'w') { |io| io << JSON.generate({"#{@content.shift}" => []}) }
    else
      file_data = JSON.parse(data)
      file_data[@content.shift] = []
      File.open(@file, 'w') { |io| io << JSON.generate(file_data) }
    end
  end

  def from_json
    JSON.parse(File.read(@file))
  end

  def write_to_file(data)
    File.open(@file, "w") { |io| io << data }
  end

  def create_entry
    cat = @content.shift
    if from_json[cat]
      data = from_json
      data[cat] << { name: @content.shift, phone: @content.shift }
      write_to_file(JSON.generate(data))
    else
      puts "That category was not found"
    end
  end

  def read_data
    File.read(@file)
  end
end

x = Phonebook.new ARGV
x.start
