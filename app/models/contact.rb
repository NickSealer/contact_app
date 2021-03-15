class Contact < ApplicationRecord
  require 'bcrypt'

  belongs_to :user

  validate :valid_contact?

  scope :valid, -> { where(is_valid: true) }

  def valid_contact?
    validate_name
    validate_birthdate
    validate_phone
    validate_address
    validate_email
    validate_credit_card

    self.is_valid = import_errors? ? false : true
  end

  def validate_name
    return if !name.blank? && name.match?(/^[a-zA-Z\s-]+$/)

    import_errors[:name] = 'Error: Invalid name'
  end

  def validate_birthdate
    date = valid_date(birthdate.to_s)
    return if !birthdate.blank? && (date.match?(/\d{4}-\d{2}-\d{2}/) || date.match?(%r{\d{4}/\d{2}/\d{2}}))

    import_errors[:birthdate] = 'Error: Invalid date'
  end

  def validate_phone
    return if !phone.blank? && phone.match?(/[(][+]\d{1,2}[)]\s{1,1}\d{3,3}[\s-]\d{3,3}[\s-]\d{2,2}[\s-]\d{2,2}$/)

    import_errors[:phone] = 'Error: Invalid phone'
  end

  def validate_address
    return unless address.blank?

    import_errors[:address] = 'Error: Invalid address'
  end

  def validate_email
    return if !email.blank? && email.match?(/^([a-zA-Z0-9_.+-])+@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/)

    import_errors[:email] = 'Error: Invalid email'
  end

  def validate_credit_card
    validator = CreditCardValidations::Detector.new(credit_card)
    if !credit_card.blank? && validator.valid?
      self.credit_card = encrypt_number(validator.number)
      self.brand = validator.brand.to_s
      [credit_card, brand]
    else
      import_errors[:credit_card] = 'Error: Invalid Credit card'
      import_errors[:brand] = 'Error: Invalid brand'
      [credit_card, brand]
    end
  end

  private

    def valid_date(date)
      Date.parse(date).strftime('%F')
    rescue StandardError
      Date.today.next_year.strftime('%F')
    end

    def encrypt_number(number)
      encriptor = BCrypt::Password.create(number)
      encriptor = encriptor.chars.shuffle.join('')
      encriptor += number[number.size - 4..number.size - 1]
      encriptor
    end
end
