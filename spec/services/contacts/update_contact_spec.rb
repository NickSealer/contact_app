require 'rails_helper'

RSpec.describe Contacts::UpdateContact, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @contact = FactoryBot.create(:contact, user: @user)
    @contact_params = FactoryBot.attributes_for(:contact)
  end

  describe "#process" do
    context "has valid data" do
      it "updates contact" do
        @contact_params[:name] = "Name changed"
        Contacts::UpdateContact.new(@contact, @contact_params).process
        expect(@contact.name).to eq("Name changed")
      end
    end

    context "has invalid data" do
      it "does not update contact" do
        @contact_params[:name] = nil
        Contacts::UpdateContact.new(@contact, @contact_params).process
        expect(@contact.name).to be(nil)
      end
    end
  end

end
