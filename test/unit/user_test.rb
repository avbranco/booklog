require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many :readings
  should have_many(:books).through(:readings)
end
