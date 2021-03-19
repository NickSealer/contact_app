# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DocumentsHelper, type: :helper do
  context '#status_color' do
    it 'must be a bootstrap table class' do
      expect(status_color('Success')).to eq('table-success')
      expect(status_color('Failed')).to eq('table-danger')
      expect(status_color('Waiting')).to eq('table-secondary')
      expect(status_color('Processing')).to eq('table-primary')
    end
  end
end
