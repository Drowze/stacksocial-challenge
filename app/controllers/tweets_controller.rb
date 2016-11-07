class TweetsController < ApplicationController
  def index
    @user = $twitter.user(params[:id])
    @tweets = $twitter.user_timeline(params[:id])
  end
end