require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe Documents::CreateDocument, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @params = { csv_file: fixture_file_upload("#{Rails.root.to_s}/public/test_csv.csv", "text/csv") }
  end

  describe "#process" do
    context "has valid data" do
      it "creates document" do
        expect(LoadFileJob).to receive(:perform_later).once
        Documents::CreateDocument.new(@params, @user).process
      end
    end

    context "has invalid data" do
      it "does not creates document" do
        expect(LoadFileJob).not_to receive(:perform_later)
        Documents::CreateDocument.new(@params, nil).process
      end
    end
  end

end
