require 'open-uri'

class Book < ActiveRecord::Base
  attr_accessor :image_url
  attr_accessible :isbn, :isbn13, :title, :author, :image_url, :image_content_type, :image_file_name, :image_file_size

  has_attached_file :image, :styles => { :thumb => ["64x64#", :png], :default => ["150x200>", :png] }
  
  has_many :readings
  has_many :users, :through => :readings

  validates_presence_of :title, :author, :isbn
  validates_uniqueness_of :isbn, :isbn13, :case_sensitive => false
  validates_length_of :isbn, :is => 10
  validates_length_of :isbn13, :is => 13
  before_validation :download_remote_image, :if => :image_url_provided?
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  
  private
  def image_url_provided?
    !self.image_url.blank?
  end
  
  def download_remote_image
    self.image = do_download_remote_image
    self.image_remote_url = image_url
  end
  
  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  end
end
