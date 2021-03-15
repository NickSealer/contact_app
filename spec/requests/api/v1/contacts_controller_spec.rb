require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :request do
  let(:contact_params) { FactoryBot.attributes_for(:contact) }
  let(:user) { FactoryBot.create(:user, :with_contacts) }
  let(:contacts) { user.contacts }

  describe '#index' do
    context 'authenticate user' do
      it 'retrieves contacts' do
        contacts
        get api_v1_contacts_path, params: { user_email: user.email, user_token: user.authenticatable_salt }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to_not include('error')
      end
    end
  end

  describe '#show' do
    context 'authenticate user' do
      it "retrieves a contact" do
        contact = contacts.first
        get api_v1_contact_path(contact), params: { user_email: user.email, user_token: user.authenticatable_salt }
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq(contact.id)
      end
    end
  end

  describe '#create' do
    context 'authenticate user' do
      it "creates a contact" do
        post api_v1_contacts_path, params: { user_email: user.email, user_token: user.authenticatable_salt, contact: contact_params }
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['success']).to be(true)
      end
    end
  end

  describe '#update' do
    context 'authenticate user' do
      it "updates a contact" do
        contact = contacts.first
        contact_params[:name] = "Updating the name"
        contact_params[:address] = "Address changed"
        put api_v1_contact_path(contact), params: { user_email: user.email, user_token: user.authenticatable_salt, id: contact, contact: contact_params }
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['success']).to be(true)
      end
    end
  end

  describe '#destroy' do
    context 'authenticate user' do
      it "deletes a contact" do
        contact = contacts.first
        delete api_v1_contact_path(contact), params: { user_email: user.email, user_token: user.authenticatable_salt, id: contact }
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['success']).to be(true)
      end
    end
  end

end
