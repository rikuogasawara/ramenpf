class Public::MyreviewsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @review = Review.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC").page(params[:page]).per(8)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "内容を削除しました"
    redirect_to myreviews_path
  end
end
