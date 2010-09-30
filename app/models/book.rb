class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :isbn
  validate :length_of_isbn
  validates_uniqueness_of :isbn, :scope => :isbn
  
  has_attached_file :image
  
  has_many :readings
  has_many :users, :through => :readings
  
  private
  def length_of_isbn
    size = isbn.to_s.size
    errors.add(:isbn, "must have 10 or 13 digits") unless size == 10 || size == 13
  end
 
end
