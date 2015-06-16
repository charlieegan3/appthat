class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @channels = Channel.all.sort_by(&:recent_activity).reverse
  end

  def flag
    t = Tweet.find(params[:id])
    t.toggle!(:flagged)
    redirect_to :back
  end
end
