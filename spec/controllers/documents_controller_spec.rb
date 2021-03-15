require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe '#index' do
    context 'authenticate user' do
      it 'should get index' do
        sign_in user
        get :index
        expect(response).to be_success
      end

      it 'returns 200 response' do
        sign_in user
        get :index
        expect(response).to have_http_status 200
      end
    end

    context 'no authenticate user' do
      it 'redirect to sign_in' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it 'returns 302 response' do
        get :index
        expect(response).to have_http_status 302
      end
    end
  end
end
