# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Documents::CreateDocument, type: :model do
  include ActionDispatch::TestProcess

  let(:user) { FactoryBot.create(:user) }
  let(:params) { { csv_file: fixture_file_upload("#{Rails.root}/public/test_csv.csv", 'text/csv') } }

  describe '#process' do
    context 'has valid data' do
      it 'creates document' do
        expect(LoadFileJob).to receive(:perform_later).once
        Documents::CreateDocument.new(params, user).process
      end
    end

    context 'has invalid data' do
      it 'does not creates document' do
        expect(LoadFileJob).to_not receive(:perform_later)
        Documents::CreateDocument.new(params, nil).process
      end
    end
  end
end
