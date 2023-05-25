class Public::SessionsController < Devise::SessionsController
  
  def after_sign_in_path_for(resource)
    about_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to about_path, notice: 'ゲストユーザーでログインしました。'
  end
end
