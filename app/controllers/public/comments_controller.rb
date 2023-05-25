class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_current_customer, only: [:destroy]
  
  def create
    review = Review.find(params[:review_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.review_id = review.id
    @comment.save
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], review_id: params[:review_id])
    @comment.destroy
  end

 private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def ensure_current_customer
    unless Comment.find_by(id: params[:id], review_id: params[:review_id]).customer_id == current_customer.id
        redirect_to review_path(params[:id])
    end
  end
  
end