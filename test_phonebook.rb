require "test/unit"
require_relative "phonebook.rb"

class PBTest < Test::Unit::TestCase

  def setup
    @testpb = Phonebook.new
    @testpb.create("testerpb")
  end

  def test_create
    assert_equal true, File.exist?("phonebooks/testerpb.pb")
  end

  # def test_print
  #
  #   @testpb.print("phonebooks/testerpb.pb")
  #   assert_output
  # end

  def teardown
    File.delete "phonebooks/testerpb.pb"
  end

end

