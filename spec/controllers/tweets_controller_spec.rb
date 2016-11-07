require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  render_views
  describe '#index' do
    context 'when the user exists' do
      let(:twitter_user) do
        double({name: 'Stack Social', screen_name: 'stacksocial'})
      end
      let(:twitter_time_line) do
        double({full_text: 'simple tweet'})
      end

      it "shows the user's tweets" do
        allow($twitter).to receive(:user).with('stacksocial') { twitter_user }
        allow($twitter).to receive(:user_timeline).with('stacksocial') { Array.new(25, twitter_time_line) }
        
        get :index, id: 'stacksocial'
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/simple tweet/)
      end
    end
  end
end


