class Admin::BaseController < ApplicationController
  before_action :require_admin_login

  private

  def require_admin_login
    unless current_admin
      redirect_to admin_login_path, alert: "Please login as an admin to access this section."
    end
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  helper_method :current_admin
end
