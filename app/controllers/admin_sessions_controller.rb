class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = login(params[:email], params[:password], user_class: Admin)
    if admin
      session[:admin_id] = admin.id
      redirect_back_or_to(admin_dashboard_path, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    session[:admin_id] = nil
    redirect_to(admin_login_path, notice: 'Logged out!')
  end
end
