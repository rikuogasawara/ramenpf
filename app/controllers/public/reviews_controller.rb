class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_current_customer, only: [:edit, :update]

  def new
    @review = Review.new
  end

  def index
    if params[:type_id].blank? && params[:soup_id].blank? && params[:q].blank?
      @review = Review.published.page(params[:page]).per(8).order("created_at DESC")
    elsif !params[:q].blank?
      @q = Review.where(status: "published").ransack(params[:q])
      @review = @q.result.page(params[:page]).per(8).order("created_at DESC")
    elsif !params[:type_id].blank? && !params[:soup_id].blank?
      @review = Review.where(status: "published",type_id:params[:type_id],soup_id:params[:soup_id]).page(params[:page]).per(8).order("created_at DESC")
    elsif !params[:type_id].blank? && params[:soup_id].blank?
      @review = Review.where(status: "published",type_id:params[:type_id]).page(params[:page]).per(8).order("created_at DESC")
    elsif params[:type_id].blank? && !params[:soup_id].blank?
      @review = Review.where(status: "published",soup_id:params[:soup_id]).page(params[:page]).per(8).order("created_at DESC")
    end
  end

  def create
    @review = Review.new(review_params)
    @type = Type.all
    @soup = Soup.all
    @review.customer_id = current_customer.id
    if review_params[:status] == 'published'
      @review.status = true
    else
      @review.status = false
    end

    if @review.save
      flash[:notice] = "投稿が成功しました"
      redirect_to review_path(@review.id)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    redirect_to reviews_path  if @review.customer_id != current_customer.id and @review.draft?
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "内容を変更しました"
      redirect_to review_path(@review.id)
    else
      render :edit
    end
  end

 private
 
  def review_params
    params.require(:review).permit(:name,:address,:latitude,:longitude,:menu,:introduction,:rate,:image,:status,:type_id,:soup_id)
  end
  
  def ensure_current_customer
    unless Review.find(params[:id]).customer_id == current_customer.id
        redirect_to reviews_path
    end
  end
end
