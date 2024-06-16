class Admin::UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user&.admin?
      session[:user_id] = user.id
      redirect_back_or_to(admin_dashboard_path, notice: 'Login successful')
    else
      logout if user
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    session[:user_id] = nil
    redirect_to(admin_login_path, notice: 'Logged out!')
  end
end
