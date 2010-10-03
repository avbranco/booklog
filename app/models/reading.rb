class Reading < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  
  validates_presence_of :user
  validates_presence_of :book
end
