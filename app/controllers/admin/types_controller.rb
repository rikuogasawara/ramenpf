class Admin::TypesController < ApplicationController
  before_action :authenticate_admin!
   
  def index
    @types = Type.all
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
    if @type.save
      flash[:notice] = "新規登録しました"
      redirect_to admin_types_path
    else
      @types = Type.all
      render :index
    end
  end

  def edit
    @type = Type.find(params[:id])

  end

  def update
    @type = Type.find(params[:id])
     if @type.update(type_params)
      flash[:notice] = "内容を変更しました"
      redirect_to admin_types_path
     else
      render :edit
     end
  end
 
  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    flash[:notice] = "内容を削除しました"
    redirect_to admin_types_path
  end
  
 private
  def type_params
    params.require(:type).permit(:name)
  end
end
