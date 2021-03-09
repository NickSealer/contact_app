require 'rails_helper'

RSpec.describe Contacts::CreateContact, type: :model do

  before do
    @contact_params = FactoryBot.attributes_for(:contact)
    @user = FactoryBot.create(:user)
  end

  describe "#process"do
    context "has valid contact data" do
      it "creates contact" do
        contact = Contacts::CreateContact.new(@contact_params, @user).process
        expect(contact.persisted?).to be(true)
      end
    end

    context "has invalid data" do
      it "does not creates contact" do
        @contact_params[:name] = nil
        contact = Contacts::CreateContact.new(@contact_params, @user).process
        expect(contact).to be(false)
      end
    end

    context "finds existing contact" do
      it "calls update contact service" do
        contact = FactoryBot.create(:contact, user: @user)
        expect {
          @contact_service = Contacts::CreateContact.new(contact, @user).process
        }.to change(@user.contacts, :count).by 0
        expect(contact).to eq(@contact_service)
      end
    end
  end

end