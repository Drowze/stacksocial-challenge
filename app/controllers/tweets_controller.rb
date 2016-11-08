class TweetsController < ApplicationController
  rescue_from Twitter::Error::NotFound, with: :render_not_found

  def index
    if user_signed_in?
      @user = $twitter.user(params[:id])
      @tweets = $twitter.user_timeline(params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  private

  def render_not_found
    render :not_found, status: 404
  end
end