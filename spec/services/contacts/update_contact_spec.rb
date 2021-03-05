require 'rails_helper'

RSpec.describe Contacts::UpdateContact, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @contact = FactoryBot.create(:contact, user: @user)
    @contact_params = FactoryBot.attributes_for(:contact)
    @other_user = FactoryBot.create(:user)
  end

  describe "#process" do
    context "has valid data" do
      it "updates contact" do
        @contact_params[:name] = "Nombre cambiado"
        success, contact = Contacts::UpdateContact.new(@contact, @contact_params).process
        expect(success).to be(true)
        expect(contact.name).to eq("Nombre cambiado")
      end
    end

    context "has invalid data" do
      it "does not update contact" do
        @contact_params[:name] = nil
        success, contact = Contacts::UpdateContact.new(@contact, @contact_params).process
        expect(success).to be(false)
        expect(contact).to be(false)
      end
    end
  end
  
end
