class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = login(params[:email], params[:password])
    if admin
      redirect_back_or_to(admin_dashboard_path, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(admin_login_path, notice: 'Logged out!')
  end
end
