require 'test/unit'
require 'json'
require './phonebook.rb'

class TestPhonebook < Test::Unit::TestCase
  def setup
    @phonebook = Phonebook.new(['create', 'cat', 'super_duper'])
  end

  def test_phonebook_attributes
    assert_not_nil @phonebook.flag
    assert_kind_of String, @phonebook.flag
    assert_kind_of Array, @phonebook.content
    assert @phonebook.json_data.class == (Hash || String)
  end

  def test_create_category
    assert @phonebook.flag == 'create'
    assert @phonebook.content.shift == 'cat'
    assert_kind_of Hash, @phonebook.create_category
    assert_kind_of String, File.read(@phonebook.file)
    assert_kind_of Array, @phonebook.json_data['super_duper']
  end

  def test_create_entry
    @phonebook.content = ['aliens', 'superman', '000']
    assert_kind_of File, @phonebook.create_entry
    assert_not_nil @phonebook.json_data['aliens'].find { |e| e == { 'name' => 'zod', 'phone' => '215-999' } }
  end

  def test_find_all
    @phonebook.flag = 'show'
    @phonebook.content = ['all']

    assert_match (Regexp.new 'all'), 'all'
  end

  def test_find_entry
    @phonebook.flag = 'show'
    @phonebook.content = ['mike']
    assert_match (Regexp.new 'mike'), 'mike'
    assert_not_nil @phonebook.find
  end

  def test_delete
    @phonebook.flag = 'delete'
    @phonebook.content = ['super_duper']
    assert_not_nil @phonebook.json_data['super_duper']
    assert_kind_of File, @phonebook.delete
    assert_nil @phonebook.json_data['super_duper']
  end

  def test_edit_entry
    @phonebook.content = ['hacker schoolers', 'name', 'george', 'matt']
    assert_kind_of Hash, @phonebook.edit_entry
    assert_not_nil @phonebook.json_data['hacker schoolers']
    assert_not_nil @phonebook.json_data['hacker schoolers'].find { |x| x['name'] == 'matt' }
  end
end


