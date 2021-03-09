require 'rails_helper'

RSpec.describe Document, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @document = FactoryBot.create(:document, user: @user)
    @invalid_document = Document.new(name: "", status: "", user_id: @user.id)
    @invalid_document.valid?
  end

  describe "validations" do
    context "has name" do
      it "has valid name" do
        expect(@document.name).not_to be_nil
      end

      it "has invalid name" do
        expect(@invalid_document.errors[:name]).to include("can't be blank")
      end
    end

    context "has status" do
      it "has valid status" do
        expect(@document.status).not_to be_nil
      end

      it "has invalid status" do
        expect(@invalid_document.errors[:status]).to include("can't be blank")
      end
    end

    context "document statuses" do
      it "has Waiting status" do
        expect(@document.status).to eq("Waiting")
      end

      it "has Processing status" do
        document = FactoryBot.build(:document, :processing)
        expect(document.status).to eq("Processing")
      end

      it "has Success status" do
        document = FactoryBot.build(:document, :success)
        expect(document.status).to eq("Success")
      end

      it "has Failed status" do
        document = FactoryBot.build(:document, :failed)
        expect(document.status).to eq("Failed")
      end
    end
  end

end
