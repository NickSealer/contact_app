# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contacts::CreateContactFromCSV, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:url_success) { "#{Rails.root}/public/test_csv.csv" }
  let(:url_failed) { "#{Rails.root}/public/test_f_csv.csv" }

  context '#process' do
    it 'at least 1 contact is correct or empty file' do
      success = Contacts::CreateContactFromCSV.new(url_success, user).process
      expect(success).to be(true)
    end

    it 'all contacts with wrong data' do
      success = Contacts::CreateContactFromCSV.new(url_failed, user).process
      expect(success).to be(false)
    end
  end
end
