require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "is valid with email and password" do
      user = User.new(email: "email@email.com", password: "123456789")
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email" do
      user = User.new(email: "nickfontechav@gmail.com", password: "123456789")
      expect(user.errors[:email]).not_to include("has already been taken")
    end
  end
end
