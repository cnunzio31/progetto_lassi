class HomesController < ApplicationController
  before_action :authenticate_user!
$TwitterClient = Twitter::REST::Client.new do |config|
  config.consumer_key        = Rails.application.secrets.twitter_consumer_key
  config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
end
  def show
    authorize! :show, Home, :message => "You can't read home page"
    @username = current_user.username
    @tweets = $TwitterClient.search("Dungeons and Dragons",result_type: "recent",lang: "en").first(10)
  end
  def create
    authorize! :create, Home, :message => "You can't change your role"
    role = params[:user][:roles_mask]
    current_user.update_attributes(:roles_mask => role)
    redirect_to home_path
  end
end
