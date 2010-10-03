require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  setup do
    @book = Factory.build(:book_one)
    Factory(:book_two)
  end
  
  should have_many(:readings)
  should have_many(:users).through(:readings)
  should validate_presence_of :title
  should validate_presence_of :author
  should validate_presence_of :isbn
  
  should_have_attached_file :image
  should_validate_attachment_presence :image
#  should_validate_attachment_content_type :image, :valid => ['image/jpeg', 'image/png']
  should_validate_attachment_size :image, :less_than => 2.megabytes
  
  should validate_uniqueness_of(:isbn).case_insensitive
  should validate_uniqueness_of(:isbn13).case_insensitive
  should ensure_length_of(:isbn).is_equal_to(10)
  should ensure_length_of(:isbn13).is_equal_to(13)
  
  test "should not save book without image remote url when image url provided" do
    @book.image_url = 'image_url'
    @book.expects(:do_download_remote_image).returns(@book.image)
    @book.save
    assert_equal @book.image_url, @book.image_remote_url, "Saved the book without image remote url when image url provided"
  end

  test "should save book" do
    assert @book.save, "Didn't save the book"
  end
end
