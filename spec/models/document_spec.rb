# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:document) { FactoryBot.build(:document, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:file) }
  end

  describe 'field validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end

  describe 'document has right status' do
    it 'has Waiting status' do
      expect(document.status).to eq('Waiting')
    end

    it 'has Processing status' do
      document = FactoryBot.build(:document, :processing)
      expect(document.status).to eq('Processing')
    end

    it 'has Success status' do
      document = FactoryBot.build(:document, :success)
      expect(document.status).to eq('Success')
    end

    it 'has Failed status' do
      document = FactoryBot.build(:document, :failed)
      expect(document.status).to eq('Failed')
    end
  end

  describe 'validates document factory' do
    it 'valid document' do
      expect(document.valid?).to be(true)
    end

    it "invalid document" do
      invalid_document = FactoryBot.build(:document, :invalid_document, user: user)
      expect(invalid_document.valid?).to be(false)
    end
  end
end
