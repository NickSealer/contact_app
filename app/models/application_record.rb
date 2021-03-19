# frozen_string_literal: true

# Main rails class for models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
