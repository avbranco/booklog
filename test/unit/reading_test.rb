require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :book
end
