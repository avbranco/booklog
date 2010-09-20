require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  test "should not save book without a title" do
    book = Book.new(:author => "DHH")
    assert !book.save, "Saved the book without a title"
  end
  
  test "should not save book without an author" do
    book = Book.new(:title => "Rails Rocks")
    assert !book.save, "Saved the book without an author"
  end
  
  test "should save book" do
    book = Book.new(:title => "Rails Rocks",:author => "DHH")
    assert book.save
  end
  
  test "should not save book without an author and title" do
    book = Book.new
    assert !book.save, "Saved the book wihout an author and title"
  end
  
end
