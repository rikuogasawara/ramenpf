class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @review = Review.find(params[:id])
  end

  def destroy
  @review = Review.find(params[:id])
  @review.destroy
  flash[:notice] = "内容を削除しました"
  redirect_to admin_path
  end
end
