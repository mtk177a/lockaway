class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:privacy]

  def privacy
  end
end
