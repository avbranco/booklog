require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  setup { @book = Factory.build(:book_one) }
  
  [:title, :author, :isbn, :image].each do |attribute|
    test "should not save book without #{attribute}" do
      @book.send("#{attribute}=", nil)
      assert !@book.save, "Saved the book without #{attribute}"
    end
  end
  
  test "should not save book without image remote url when image url provided" do
    @book.image_url = 'image_url'
    @book.expects(:do_download_remote_image).returns(@book.image)
    @book.save
    assert_equal @book.image_url, @book.image_remote_url, "Saved the book without image remote url when image url provided"
  end
  
  [9, 11].each do |digits|
    test "should not save book with invalid isbn (#{digits} digits)" do
      isbn = ''
      digits.times { isbn << '1' }
      @book.isbn = isbn
      assert !@book.save, "Saved the book with invalid isbn (#{digits} digits)"
    end
  end
  
  [12, 14].each do |digits|
    test "should not save book with invalid isbn13 (#{digits} digits)" do
      isbn13 = ''
      digits.times { isbn13 << '1' }
      @book.isbn13 = isbn13
      assert !@book.save, "Saved the book with invalid isbn13 (#{digits} digits)"
    end
  end

  test "should save book" do
    assert @book.save, "Didn't save the book"
  end
  
  test "should not save book without an author, title and isbn" do
    assert !Book.new.save, "Saved the book wihout an author, title and isbn"
  end
  
  test "should save a book only if the isbn does not exist" do
    Factory.build(:book_two).save    
    assert !Factory.build(:book_two).save, "Saved a book with the same isbn"    
  end
 
end
