class Public::HomesController < ApplicationController

  def top
    @review = Review.published.page(params[:page]).per(4).order("created_at DESC")
  end

  def about
  end
end
