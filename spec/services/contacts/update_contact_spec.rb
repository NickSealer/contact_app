require 'rails_helper'

RSpec.describe Contacts::UpdateContact, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:contact) { FactoryBot.create(:contact, user: user) }
  let(:contact_params) { FactoryBot.attributes_for(:contact) }

  describe '#process' do
    context 'has valid data' do
      it 'updates contact' do
        contact_params[:name] = 'Name changed'
        Contacts::UpdateContact.new(contact, contact_params).process
        expect(contact.import_errors.present?).to_not be(true)
      end
    end

    context 'has invalid data' do
      it 'does not update contact' do
        contact_params[:name] = nil
        Contacts::UpdateContact.new(contact, contact_params).process
        expect(contact.import_errors.present?).to be(true)
      end
    end
  end
end
