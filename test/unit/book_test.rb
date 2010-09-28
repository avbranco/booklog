require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  [:title, :author, :isbn].each do |attribute|
    test "should not save book without #{attribute.to_s}" do
      book = books(:one)
      book.send("#{attribute.to_s}=", nil)
      assert !book.save, "Saved the book without #{attribute.to_s}"
    end
  end
  
  [9, 11, 12, 14].each do |digits|
    test "should not save book with invalid isbn (#{digits} digits)" do
      book = books(:one)
      isbn = ''
      digits.times { isbn << '1' }
      book.isbn = isbn
      assert !book.save, "Saved the book with invalid isbn (#{digits} digits)"
    end
  end
  
  [10, 13].each do |digits|
    test "should save book with valid isbn (#{digits} digits)" do
      book = books(:one)
      isbn = ''
      digits.times { isbn << '1' }
      book.isbn = isbn
      assert book.save, "Didn't save the book with valid isbn (#{digits} digits)"
    end
  end
  
  test "should not save book with non-digit isbn" do
    book = books(:one)
    book.isbn = 'aoeuidhtns'
    assert !book.save, "Saved the book with non-digit isbn"
  end

  test "should save book" do
    assert books(:one).save, "Didn't save the book"
  end
  
  test "should not save book without an author, title and isbn" do
    assert !Book.new.save, "Saved the book wihout an author, title and isbn"
  end
  
end
