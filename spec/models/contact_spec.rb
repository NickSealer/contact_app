# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_contact) { FactoryBot.build(:contact) }
  let(:invalid_contact) { FactoryBot.build(:contact, :invalid_contact) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    context 'has fields with right format' do
      it 'has name with right format' do
        expect(valid_contact.validate_name).to be_nil
      end

      it 'has birthdate with right format' do
        expect(valid_contact.validate_birthdate).to be_nil
      end

      it 'has phone with right format' do
        expect(valid_contact.validate_phone).to be_nil
      end

      it 'has address with right data ' do
        expect(valid_contact.validate_address).to be_nil
      end

      it 'has email with right format' do
        expect(valid_contact.validate_email).to be_nil
      end

      it 'has credit card with right data' do
        expect(valid_contact.validate_credit_card).not_to include(nil)
      end
    end

    context 'has fields with wrong format' do
      it 'has name with wrong format' do
        expect(invalid_contact.validate_name).to include('Error')
      end

      it 'has birthdate with wrong format' do
        expect(invalid_contact.validate_birthdate).to include('Error')
      end

      it 'has phone with wrong format' do
        expect(invalid_contact.validate_phone).to include('Error')
      end

      it 'has address with empty data ' do
        expect(invalid_contact.validate_address).to include('Error')
      end

      it 'has email with wrong format' do
        expect(invalid_contact.validate_email).to include('Error')
      end

      it 'has credit card with wrong format' do
        expect(invalid_contact.validate_credit_card).to include(nil)
      end
    end
  end

  describe 'validates contact data' do
    it 'is valid' do
      valid_contact.valid_contact?
      expect(valid_contact.is_valid).to be(true)
    end

    it 'is invalid' do
      invalid_contact.valid_contact?
      expect(invalid_contact.is_valid).to be(false)
    end
  end

  describe "search contacts by 'valid' scope" do
    let(:contact_1) { FactoryBot.create(:contact, user: user) }
    let(:contact_2) { FactoryBot.create(:contact, :invalid_contact, user: user) }

    it 'return contacts that are valids' do
      expect(user.contacts.valid).to include(contact_1)
      expect(user.contacts.valid).to_not include(contact_2)
    end
  end
end
