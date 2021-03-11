class Contacts::CreateContactFromCSV
  require 'csv'

  def initialize(csv_file, current_user)
    # @csv_file = Rails.env == 'test' ? "#{Rails.root.to_s}/public/test_csv.csv" : csv_file
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

      params = {}
      params[:name] = name
      params[:birthdate] = birthdate
      params[:phone] = phone
      params[:address] = address
      params[:credit_card] = credit_card
      params[:email] = email
      params[:user_id] = @current_user.id

      contact = Contacts::CreateContact.new(params, @current_user).process

      contacts_count += 1 if contact.is_valid
      success = true if contacts_count >= 1
      success = false if contacts_count < 1
    end

    success
  end
end
