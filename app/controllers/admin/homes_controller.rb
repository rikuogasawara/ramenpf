class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
   @review = Review.page(params[:page])
  end
end
