require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  render_views
  describe '#index' do
    context 'when user is logged in' do
      before { sign_in }
      
      context 'when the user exists' do
        before do
          allow($twitter).to receive(:user).with('stacksocial') { twitter_user }
          allow($twitter).to receive(:user_timeline).with('stacksocial') { Array.new(25, twitter_time_line) }
          get :index, id: 'stacksocial'
        end

        let(:twitter_user) do
          double({name: 'Stack Social', screen_name: 'stacksocial'})
        end
        let(:twitter_time_line) do
          double({full_text: 'simple tweet'})
        end

        it "shows the user's tweets" do          
          expect(response.body).to match(/simple tweet/)
        end

        it { expect(response).to have_http_status(:ok) }
      end

      context 'when the user does not exist' do
        before do
          allow($twitter).to receive(:user).with('nonexistent_user').and_raise(Twitter::Error::NotFound)
          allow($twitter).to receive(:user_timeline).with('nonexistent_user').and_raise(Twitter::Error::NotFound)
          get :index, id: 'nonexistent_user'
        end

        it 'does not show any tweet' do
          expect(response.body).to match(/User not found/)
        end

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context 'when the user is not logged in' do
      before { sign_in nil }

      it 'redirects to sign_in page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end