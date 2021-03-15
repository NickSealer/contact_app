require 'rails_helper'

RSpec.describe Contacts::UpdateContact, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:contact) { FactoryBot.create(:contact, user: user) }
  let(:contact_params) { FactoryBot.attributes_for(:contact) }

  describe '#process' do
    it 'updates a contact' do
      contact_params[:name] = 'Name changed'
      Contacts::UpdateContact.new(contact, contact_params).process
      expect(contact.name).to eq('Name changed')
    end
  end
end
