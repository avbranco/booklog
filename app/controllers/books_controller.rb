require 'open-uri'

class BooksController < ApplicationController
  respond_to :html, :js, :xml
  before_filter :authenticate_user!
  
  def index
    @books = Book.all(:order => 'title')
    respond_with @books
  end  

  def show
    @book = Book.find(params[:id])
    respond_with @book
  end


  def new
    @book = Book.new
    respond_with @book
  end

  def edit
    @book = Book.find(params[:id])
  end


  def create
    @book = Book.new(params[:book])
    @book.save
    respond_with @book
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(params[:book])
    respond_with @book
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_with @book
  end
  
  def fetch
    @book = Book.new()
    doc = Nokogiri::HTML(open("http://search.barnesandnoble.com/books/product.aspx?ean=#{params[:isbn]}"))
    title = doc.css(".tab-title-repeat h2").first
    if title
      flash[:notice] = ''
      @book.title = title.content
      @book.author = doc.css(".wgt-productTitle .nl a").first.content
      @book.image_url = doc.css("#product-image img").first['src']
      isbns = doc.css(".isbn-a")
      @book.isbn13 = isbns.first.content
      @book.isbn = isbns.last.content
    else
      flash[:notice] = 'Could not find book by isbn'
    end
    respond_with @book
  end
end
