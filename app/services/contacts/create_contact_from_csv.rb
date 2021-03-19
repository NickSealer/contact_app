# frozen_string_literal: true

module Contacts
  # Service to process csv file and invoke CreateContact service
  class CreateContactFromCSV
    require 'csv'

    def initialize(csv_file, current_user)
      @csv_file = csv_file
      @current_user = current_user
    end

    def process
      contacts_count = 0
      success = true

      csv_text = File.read(@csv_file)
      csv = CSV.parse(csv_text, headers: true, col_sep: ',')

      csv.each do |contact_array|
        Rails.logger.info "[INFO] Registering expense #{contact_array[5]}"

        name = contact_array[0]
        birthdate = contact_array[1]
        phone = contact_array[2]
        address = contact_array[3]
        credit_card = contact_array[4]
        email = contact_array[5]

        params = {
          name: name,
          birthdate: birthdate,
          phone: phone,
          address: address,
          credit_card: credit_card,
          email: email,
          user_id: @current_user.id
        }

        contact = Contacts::CreateContact.new(params, @current_user).process

        contacts_count += 1 if contact.is_valid
        success = false if contacts_count.zero?
      end

      success
    end
  end
end
