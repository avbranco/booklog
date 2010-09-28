class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :isbn
  validates_numericality_of :isbn, :on => :create
  validate :length_of_isbn
  
  has_attached_file :image
  
  private
  def length_of_isbn
    size = isbn.to_s.size
    errors.add(:isbn, "must have 10 or 13 digits") unless size == 10 || size == 13
  end
end
