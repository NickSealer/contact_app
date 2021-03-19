# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contacts::CreateContact, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let!(:contact) { FactoryBot.create(:contact, user: user) }

  describe '#process' do
    it 'creates a contactd' do
      expect(contact.persisted?).to be(true)
    end

    context 'finds existing contact' do
      it 'calls update contact service' do
        expect do
          @contact_service = Contacts::CreateContact.new(contact.attributes.symbolize_keys, user).process
        end.to change(user.contacts, :count).by 0
        expect(contact).to eq(@contact_service)
      end
    end
  end
end
