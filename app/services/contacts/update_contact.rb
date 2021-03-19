# frozen_string_literal: true

module Contacts
  # Service to update contacts
  class UpdateContact
    def initialize(contact, params)
      @contact = contact
      @params = params.merge(import_errors: {})
    end

    def process
      @contact.update(@params)
    end
  end
end
