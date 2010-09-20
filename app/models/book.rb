class Book < ActiveRecord::Base
  validates_presence_of :title, :author
  
  has_attached_file :image
  
  
end
