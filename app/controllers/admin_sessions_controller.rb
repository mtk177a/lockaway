class AdminSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    Rails.logger.info("Attempting login for email: #{params[:email]}")
    admin = login(params[:email], params[:password], user_class: Admin)
    if admin
      Rails.logger.info("Login successful for admin ID: #{admin.id}")
      session[:admin_id] = admin.id
      Rails.logger.info("Admin ID set in session: #{session[:admin_id]}")
      redirect_back_or_to(admin_dashboard_path, notice: 'Login successful')
    else
      Rails.logger.info("Login failed for email: #{params[:email]}")
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
