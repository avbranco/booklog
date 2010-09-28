require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  setup { @book = books(:one) }
  
  [:title, :author, :isbn].each do |attribute|
    test "should not save book without #{attribute}" do
      @book.send("#{attribute}=", nil)
      assert !@book.save, "Saved the book without #{attribute}"
    end
  end
  
  [9, 11, 12, 14].each do |digits|
    test "should not save book with invalid isbn (#{digits} digits)" do
      isbn = ''
      digits.times { isbn << '1' }
      @book.isbn = isbn
      assert !@book.save, "Saved the book with invalid isbn (#{digits} digits)"
    end
  end
  
  [10, 13].each do |digits|
    test "should save book with valid isbn (#{digits} digits)" do
      isbn = ''
      digits.times { isbn << '1' }
      @book.isbn = isbn
      assert @book.save, "Didn't save the book with valid isbn (#{digits} digits)"
    end
  end

  test "should save book" do
    assert @book.save, "Didn't save the book"
  end
  
  test "should not save book without an author, title and isbn" do
    assert !Book.new.save, "Saved the book wihout an author, title and isbn"
  end
  
end
