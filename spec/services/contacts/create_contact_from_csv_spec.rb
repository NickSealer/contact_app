require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe Contacts::CreateContactFromCSV, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @url_success = "#{Rails.root.to_s}/public/test_csv.csv"
    @url_failed = "#{Rails.root.to_s}/public/test_f_csv.csv"
  end

  context '#process' do
    it "at least 1 contact is correct" do
      success = Contacts::CreateContactFromCSV.new(@url_success, @user).process
      expect(success).to be(true)
    end

    it "all contacts with wrong data" do
      success = Contacts::CreateContactFromCSV.new(@url_failed, @user).process
      expect(success).to be(false)
    end
  end

end
