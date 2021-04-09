# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :request do
  let(:contact_params) { FactoryBot.attributes_for(:contact) }
  let(:user) { FactoryBot.create(:user, :with_contacts) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:contacts) { user.contacts }
  let(:contact) { contacts.first }
  let(:auth_params) { user.create_new_auth_token } # simulate login user retrieving auth headers

  describe '#index' do
    context 'authenticate user' do
      it 'retrieves contacts' do
        contacts
        get api_v1_contacts_path, headers: auth_params
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(response).to have_content_type(:json)
        expect(JSON.parse(response.body)).to_not include('error')
      end
    end

    context 'no authenticate user' do
      it 'should get 401 status' do
        get api_v1_contacts_path
        expect(response).to_not have_http_status 200
        expect(response).to have_http_status 401
      end
    end
  end

  describe '#show' do
    context 'authenticate user' do
      it 'retrieves a contact' do
        get api_v1_contact_path(contact), headers: auth_params
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq(contact.id)
      end
    end

    context 'no authenticate user' do
      it 'should get 401 status' do
        get api_v1_contact_path(contacts)
        expect(response).to_not have_http_status 200
        expect(response).to have_http_status 401
      end
    end

    context 'unauthorized user' do
      it 'should get 404 status' do
        get api_v1_contact_path(contact), headers: other_user.create_new_auth_token
        expect(response).to have_http_status 404
      end
    end
  end

  describe '#create' do
    context 'authenticate user' do
      it 'creates a contact' do
        post api_v1_contacts_path, params: { contact: contact_params }, headers: auth_params
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['success']).to be(true)
      end
    end

    context 'no authenticate user' do
      it 'should get 401 status' do
        post api_v1_contacts_path, params: { contact: contact_params }
        expect(response).to_not have_http_status 200
        expect(response).to have_http_status 401
      end
    end
  end

  describe '#update' do
    context 'authenticate user' do
      it 'updates a contact' do
        contact_params[:name] = 'Updating the name'
        contact_params[:address] = 'Address changed'
        put api_v1_contact_path(contact), params: { id: contact, contact: contact_params }, headers: auth_params
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['success']).to be(true)
      end
    end

    context 'no authenticate user' do
      it 'should get 401 status' do
        put api_v1_contact_path(contacts), params: { id: contact, contact: contact_params }
        expect(response).to_not have_http_status 200
        expect(response).to have_http_status 401
      end
    end

    context 'unauthorized user' do
      it 'should get 404 status' do
        put api_v1_contact_path(contact), headers: other_user.create_new_auth_token
        expect(response).to have_http_status 404
      end
    end
  end

  describe '#destroy' do
    context 'authenticate user' do
      it 'deletes a contact' do
        delete api_v1_contact_path(contact), params: { id: contact }, headers: auth_params
        expect(response).to have_http_status 200
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['success']).to be(true)
      end
    end

    context 'no authenticate user' do
      it 'should get 401 status' do
        delete api_v1_contact_path(contact), params: { id: contact }
        expect(response).to_not have_http_status 200
        expect(response).to have_http_status 401
      end
    end

    context 'unauthorized user' do
      it 'should get 404 status' do
        delete api_v1_contact_path(contact), headers: other_user.create_new_auth_token
        expect(response).to have_http_status 404
      end
    end
  end
end
