require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_contact) { FactoryBot.build(:contact) }
  let(:invalid_contact) { FactoryBot.build(:contact, :invalid_contact) }
  let(:contact_1) { FactoryBot.create(:contact, user: user) }
  let(:contact_2) { FactoryBot.create(:contact, :invalid_contact, user: user) }

  context 'contact data' do
    it 'is valid' do
      valid_contact.valid_contact?
      expect(valid_contact.is_valid).to be(true)
    end

    it 'is invalid' do
      invalid_contact.valid_contact?
      expect(invalid_contact.is_valid).to be(false)
    end
  end

  describe 'validations' do
    context 'has valid data' do
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

    context 'has invalid data' do
      it 'has invalid name with wrong format' do
        expect(invalid_contact.validate_name).to include('Error')
      end

      it 'has invalid birthdate with wrong format' do
        expect(invalid_contact.validate_birthdate).to include('Error')
      end

      it 'has invalid phone with wrong format' do
        expect(invalid_contact.validate_phone).to include('Error')
      end

      it 'has invalid address with empty data ' do
        expect(invalid_contact.validate_address).to include('Error')
      end

      it 'has invalid email with wrong format' do
        expect(invalid_contact.validate_email).to include('Error')
      end

      it 'has invalid credit card' do
        expect(invalid_contact.validate_credit_card).to include(nil)
      end
    end
  end

  context "search contacts by 'valid' scope" do
    it 'return contacts that are valids' do
      expect(user.contacts.valid).to include(contact_1)
    end

    it "return contacts that aren't valids" do
      expect(user.contacts.valid).not_to include(contact_2)
    end
  end

  context 'generate contact factory' do
    it 'valid factory' do
      expect(contact_1.user).to be_truthy
    end
  end
end
