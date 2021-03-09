require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  before do
    @user = FactoryBot.create(:user) # simulate login user
    @contact = FactoryBot.create(:contact, user: @user) # simulate contact's login user
    @contact_params = FactoryBot.attributes_for(:contact) # contact params
    @other_user = FactoryBot.create(:user) # other login user trying to get access for contacts that dont belongs to it
  end

  describe "#index" do
    context "authenticate user" do
      it "should get index" do
        sign_in @user
        get :index
        expect(response).to be_success
      end

      it "returns 200 response" do
        sign_in @user
        get :index
        expect(response).to have_http_status 200
      end

      it "should get index with status 1" do
        sign_in @user
        get :index, params: {status: 1}
        expect(response.request.params).to include('status')
        expect(response.request.params[:status]).to eq('1')
        expect(response.request.params[:status].present?).to be_truthy
      end

      it "should get index with status 0" do
        sign_in @user
        get :index, params: {status: 0}
        expect(response.request.params).to include('status')
        expect(response.request.params[:status]).to eq('0')
        expect(response.request.params[:status].present?).to be_truthy
      end

      it "should fail if status params is not present" do
        sign_in @user
        get :index, params: {other_status: 1}
        expect(response.request.params).not_to include('status')
        expect(response.request.params[:status].present?).to be_falsey
      end
    end

    context "no authenticate user" do
      it "returns to sign_in" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        get :index
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#show" do
    context "authenticate user" do
      it "should get show" do
        sign_in @user
        get :show, params: { id: @contact }
        expect(response).to be_success
      end

      it "returns 200 response" do
        sign_in @user
        get :show, params: { id: @contact }
        expect(response).to have_http_status 200
      end
    end

    context "no authorized user" do
      it "redirect to root_path" do
        sign_in @other_user
        get :show, params: { id: @contact }
        expect(response).to redirect_to root_path
      end
    end

    context "no authenticate user" do
      it "redirect to sign_in" do
        get :show, params: { id: @contact }
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        get :show, params: { id: @contact }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#create" do
    context "authenticate user" do
      it "creates a contact" do
        sign_in @user
        expect {
          post :create, params: { contact: @contact_params }
        }.to change(@user.contacts, :count).by 1
      end

      it "does not creates contact with invalid data" do
        sign_in @user
        @contact = FactoryBot.attributes_for(:contact, name: nil)
        expect {
          post :create, params: { contact: @contact }
        }.not_to change(@user.contacts, :count)
      end
    end

    context "no authenticate user" do
      it "does not creates a contact" do
        expect {
          post :create, params: { contact: @contact_params }
        }.not_to change(@user.contacts, :count)
      end

      it "redirect to sign_in" do
        post :create, params: { contact: @contact_params }
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        post :create, params: { contact: @contact_params }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#new" do
    context "authenticate user" do
      it "should get new" do
        sign_in @user
        get :new
        expect(response).to be_success
      end

      it "returns 200 response" do
        sign_in @user
        get :new
        expect(response).to have_http_status 200
      end
    end

    context "no authenticate user" do
      it "redirect to sign_in" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        get :new
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#update" do
    context "authenticate user" do
      it "updates a contact" do
        sign_in @user
        @contact_params[:name] = "Name updated from test"
        put :update, params: { id: @contact, contact: @contact_params }
        expect(@contact.reload.name).to eq("Name updated from test")
      end

      it "does not update contact with invalid data" do
        sign_in @user
        @contact_params[:name] = nil
        put :update, params: { id: @contact, contact: @contact_params }
        expect(@contact.reload.name).not_to eq(nil)
      end
    end

    context "no authorized user" do
      it "does not update the contact" do
        sign_in @other_user
        @contact_params[:name] = "Name updated from test"
        put :update, params: { id: @contact, contact: @contact_params }
        expect(@contact.reload.name).not_to eq("Name updated from test")
      end

      it "redirect to root_path" do
        sign_in @other_user
        put :update, params: { id: @contact, contact: @contact_params }
        expect(response).to redirect_to root_path
      end

      it "returns 302 response" do
        sign_in @other_user
        put :update, params: { id: @contact, contact: @contact_params }
        expect(response).to have_http_status 302
      end
    end

    context "no authenticate user" do
      it "does not update the contact" do
        @contact_params[:name] = "Name updated from test"
        put :update, params: { id: @contact, contact: @contact_params }
        expect(@contact.reload.name).not_to eq("Name updated from test")
      end

      it "redirect to sign_in" do
        put :update, params: { id: @contact, contact: @contact_params }
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        put :update, params: { id: @contact, contact: @contact_params }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#edit" do
    context "authenticate user" do
      it "shoud get edit" do
        sign_in @user
        get :edit, params: { id: @contact }
        expect(response).to be_success
      end

      it "returns 200 response" do
        sign_in @user
        get :edit, params: { id: @contact }
        expect(response).to have_http_status 200
      end
    end

    context "no authenticate user" do
      it "no authorized user" do
        sign_in @other_user
        get :edit, params: { id: @contact }
        expect(response).to redirect_to root_path
      end

      it "redirect to sign_in" do
        get :edit, params: { id: @contact }
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        get :edit, params: { id: @contact }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#destroy" do
    context "authenticate user" do
      it "deletes contact" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @contact }
        }.to change(@user.contacts, :count).by -1
      end
    end

    context "no authorized user" do
      it "does not delete contact" do
        sign_in @other_user
        expect {
          delete :destroy, params: { id: @contact }
        }.not_to change(@user.contacts, :count)
      end

      it "redirect to root_path" do
        sign_in @other_user
        delete :destroy, params: { id: @contact }
        expect(response).to redirect_to root_path
      end
    end

    context "no authenticate user" do
      it "does not delete contact" do
        expect {
          delete :destroy, params: { id: @contact }
        }.not_to change(@user.contacts, :count)
      end

      it "redirect to sign_in" do
        delete :destroy, params: { id: @contact }
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        delete :destroy, params: { id: @contact }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#download_csv"
    context "authenticate user" do
      it "respond to csv output" do
        sign_in @user
        get :download_csv, format: :csv
        expect(response.content_type).to eq("text/csv")
      end

      it "content correct headers" do
        sign_in @user
        get :download_csv, format: :csv
        expect(response.body).to eq("name,birthdate,phone,address,credit_card,email\n")
      end
    end

    context "no authenticate user" do
      it "unauthorized" do
        get :download_csv, format: :csv
        expect(response).to have_http_status 401
      end
    end

  describe "#import_csv" do

    before do
      @document = fixture_file_upload("#{Rails.root.to_s}/public/test_csv.csv", "text/csv")
      @wrong_document = fixture_file_upload("#{Rails.root.to_s}/public/test_csv.jpg", "image/jpg")
    end

    context "authenticate user" do
      it "has valid format" do
        sign_in @user
        post :import_csv, params: { csv_file: @document }
        expect(response).to redirect_to documents_path
      end

      it "has invalid format" do
        sign_in @user
        post :import_csv, params: { csv_file: @wrong_document }
        expect(response).to redirect_to root_path
      end
    end

    context "no authenticate user" do
      it "redirect_to sign_in" do
        post :import_csv, params: { csv_file: @document }
        expect(response).to redirect_to new_user_session_path
      end

      it "returns 302 response" do
        post :import_csv, params: { csv_file: @document }
        expect(response).to have_http_status 302
      end
    end
  end

end
