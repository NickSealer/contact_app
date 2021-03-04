require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    context "is valid data" do
      it "is valid with email and password" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context "is invalid data" do
      it "is invalid without an email" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it "is invalid with a duplicate email" do
        user = FactoryBot.build(:user, email: "nickfontechav@gmail.com")
        expect(user.errors[:email]).not_to include("has already been taken")
      end
    end

    it "generate user with contacts" do
      user = FactoryBot.build(:user, :with_contacts)
      puts user.inspect
      puts user.contacts.inspect
      expect(user.contacts.count).to eq 0
    end

  end

end
