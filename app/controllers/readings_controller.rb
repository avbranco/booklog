class ReadingsController < ApplicationController
  
  respond_to :html, :js, :xml
  before_filter :authenticate_user!
 
  def index
    @readings = Reading.where("user_id" => current_user.id)
    respond_with @readings
  end

  def new
    @reading = Reading.new
    respond_with @reading 
  end

  def book
    @reading = Reading.new
    @reading.book = Book.find(params[:id])
    @reading.user = current_user
    @reading.save
    respond_with @readings
  end
  
  def update
    @reading = Reading.find(params[:id])
    @reading.update_attributes(params[:reading])
    respond_with @reading
  end

  
end
