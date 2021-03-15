require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'is valid data' do
      it 'is valid with email and password' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context 'has invalid data' do
      it 'is invalid without an email' do
        user = FactoryBot.build(:user, :no_email)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'has duplicate email' do
        user = FactoryBot.build(:user, :duplicate_email)
        expect(user.errors[:email]).not_to include('has already been taken')
      end
    end

    it 'generate user with contacts' do
      user = FactoryBot.create(:user, :with_contacts)
      expect(user.contacts.count).to_not eq 0
    end
  end
end
