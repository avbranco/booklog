require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @book = Factory(:book_one)
    @user = Factory(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new 
    assert_response :success
  end
  
  test "should create book" do
    assert_difference('Book.count') do
      post :create, :book => Factory.build(:book_two).attributes
    end
    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, :id => @book.to_param
    assert_response :success 
  end

  test "should get edit" do
    get :edit, :id => @book.to_param
    assert_response :success
  end

  test "should update book" do
    put :update, :id => @book.to_param, :book => @book.attributes
    assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, :id => @book.to_param
    end
    assert_redirected_to books_path
  end
  
  test "should get fetch" do
    book = Factory.build(:book_one)
    url = "http://search.barnesandnoble.com/books/product.aspx?ean=#{book.isbn}"
    html = %q{
      <div class="tab-title-repeat"><h2>Agile Web Development with Rails</h2></div>
      <div class="w-box wgt-productTitle"><em class="nl"><a>Sam Ruby</a></em></div>
      <div id="product-image"><img src="http://img2.imagesbn.com/images/37200000/37203766.JPG"></a></div>
      <div class="isbn-a">ISBN13</div>
      <div class="isbn-a">ISBN10</div>      
    }
    BooksController.any_instance.expects(:open).with(url).returns(html)
    xhr :get, :fetch, :isbn => book.isbn
    assert_response :success
    assert_not_nil assigns(:book)
    assert_blank flash[:notice]
  end
  
  test "should get fetch but not find" do
    book = Factory.build(:book_one)
    url = "http://search.barnesandnoble.com/books/product.aspx?ean=#{book.isbn}"
    BooksController.any_instance.expects(:open).with(url).returns('')
    xhr :get, :fetch, :isbn => book.isbn
    assert_response :success
    assert_not_nil assigns(:book)
    assert_present flash[:notice]
  end
end
