class Contacts::CreateContactFromCSV
  require 'csv'

  def initialize(csv_file, user_id)
    @csv_file = csv_file
    @user_id = user_id
  end

  def process
    contacts_count = 0
    errors = 0
    message = ""
    failed = false

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

      params = {}
      params[:name] = name
      params[:birthdate] = birthdate
      params[:phone] = phone
      params[:address] = address
      params[:credit_card] = credit_card
      params[:email] = email
      params[:user_id] = @user_id

      contact_created, contact, msg = Contacts::CreateContact.new(params, @user_id).process
      contacts_count += 1 if contact.is_valid && contact_created
      errors += 1 unless contact.is_valid
      message += "#{msg}"
      failed = true if errors >= 1
    end

    contacts_count = 1 if contacts_count < 1
    [contacts_count, errors, message, failed]
  end
end
