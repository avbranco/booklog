require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  
  setup do
    @reading = Reading.new
  end
  
  should belong_to :user
  should belong_to :book
  
  should validate_presence_of :user
  should validate_presence_of :book
  
  test "should save reading" do
    @reading.book = Factory(:book_one)
    @reading.user = Factory(:user)
    assert @reading.save, "Didn't save the reading"
  end
  
end
