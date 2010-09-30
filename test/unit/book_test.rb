require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  setup { 
    @book = books(:one) 
    user = User.create!(
      :id => 1,
      :email => 'u...@test.com',
      :password => 'user123',
      :password_confirmation => 'user123'
    ) 
    @book.users[0] = user
  }
  
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
  
  test "should not save a book without a user" do
    book2 = books(:two)
    assert !book2.save, "Saved the book without a user"
  end
  
  test "should save a book only if the isbn does not exist" do
    books(:two).save    
    assert !books(:three).save, "Saved a book with the same isbn"    
  end
 
end
