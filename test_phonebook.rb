require "test/unit"
require_relative "phonebook.rb"

class PBTest < Test::Unit::TestCase

  def setup
    @testpb = Phonebook.new
    @testpb.create("testerpb")
  end

  def testcreate
    assert_equal true, File.exist?("testerpb.pb")
  end

  def teardown
    File.delete "testerpb.pb"
  end
end

