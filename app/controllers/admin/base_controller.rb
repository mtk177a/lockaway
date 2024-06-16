class Admin::BaseController < ApplicationController
  before_action :require_admin_login

  private

  def require_admin_login
    unless current_user&.admin?
      redirect_to admin_login_path, alert: "Please login as an admin to access this section."
    end
  end
end
