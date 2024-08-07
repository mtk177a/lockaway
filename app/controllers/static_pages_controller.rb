class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:privacy, :terms_of_service]

  def privacy
  end

  def terms_of_service
  end
end
