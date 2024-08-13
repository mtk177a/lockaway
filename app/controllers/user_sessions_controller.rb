class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_logged_in_user, only: [:new, :create]

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(root_path, success: t('user_sessions.create.success'))
    else
      flash.now[:error] = t('user_sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other, success: t('user_sessions.destroy.success')
  end

  private

  def redirect_logged_in_user
    if logged_in?
      redirect_to root_path, notice: t('helpers.messages.already_logged_in')
    end
  end
end
