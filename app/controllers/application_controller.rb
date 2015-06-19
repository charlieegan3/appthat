class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def index
    @channels = Channel.all.sort_by(&:recent_activity).reverse
  end

  def search
    tags = params[:query].downcase.gsub(/\W|\s/, '').split(/\s+/)
    render json: Tweet.search(tags).map { |t| t.as_json(only: [:id, :url, :screen_name, :text, :created_at]) }
  end

  def flag
    t = Tweet.find(params[:id])
    Flag.set(t, request.remote_ip)
    render json: t.flags.size
  end
end
