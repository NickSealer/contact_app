# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:contacts) }
    it { should have_many(:documents) }
  end

  describe 'field validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).scoped_to(:provider).ignoring_case_sensitivity }
    it 'has duplicate email' do
      user = FactoryBot.create(:user, :duplicate_email)
      expect(user.errors[:email]).not_to include('has already been taken')
    end
  end

  describe 'validates user factory' do
    it 'valid user' do
      user = FactoryBot.build(:user)
      expect(user.valid?).to be(true)
    end

    it 'invalid user' do
      user = FactoryBot.build(:user, :no_email)
      expect(user.valid?).to be(false)
    end
  end
end
