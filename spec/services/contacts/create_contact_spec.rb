require 'rails_helper'

RSpec.describe Contacts::CreateContact, type: :model do

  before do
    @contact_params = FactoryBot.attributes_for(:contact)
    @user = FactoryBot.create(:user)
  end

  describe "#process"do
    context "has valid contact data" do
      it "creates contact" do
        success, contact = Contacts::CreateContact.new(@contact_params, @user).process
        expect(success).to be(true) && be(contact.persisted?)
      end
    end

    context "has invalid data" do
      it "does not creates contact" do
        @contact_params[:name] = nil
        success, contact = Contacts::CreateContact.new(@contact_params, @user).process
        expect(success).to be(false)
        expect(contact).to be(false)
      end
    end
  end
end
