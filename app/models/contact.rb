class Contact < ApplicationRecord
  require 'bcrypt'

  belongs_to :user

  before_save :valid_contact?

  scope :valid, -> { where(is_valid: true) }

  def valid_contact?
    validate_name
    validate_birthdate
    validate_phone
    validate_address
    validate_email
    validate_credit_card

    self.is_valid = true if !name.include?('Error') &&
                            !birthdate.blank? &&
                            !phone.include?('Error') &&
                            !address.include?('Error') &&
                            !email.include?('Error') &&
                            !credit_card.include?('Error')
  end

  def validate_name
    self.name = if !name.blank? && name.match?(/^[a-zA-Z\s-]+$/)
                  name
                else
                  'Error: Invalid name'
                end
  end

  def validate_birthdate
    date = valid_date(birthdate.to_s)
    self.birthdate = if !birthdate.blank? && (date.match?(/\d{4}-\d{2}-\d{2}/) || date.match?(%r{\d{4}/\d{2}/\d{2}}))
                       date
                     end
  end

  def validate_phone
    self.phone = if !phone.blank? && phone.match?(/[(][+]\d{1,2}[)]\s{1,1}\d{3,3}[\s-]\d{3,3}[\s-]\d{2,2}[\s-]\d{2,2}$/)
                   phone
                 else
                   'Error: Invalid phone'
                 end
  end

  def validate_address
    self.address = address.blank? ? 'Error: Invalid address' : address
  end

  def validate_email
    self.email = if !email.blank? && email.match?(/^([a-zA-Z0-9_.+-])+@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/)
                   email
                 else
                   'Error: Invalid email'
                 end
  end

  def validate_credit_card
    validator = CreditCardValidations::Detector.new(credit_card)
    if !credit_card.blank? && validator.valid?
      self.credit_card = encrypt_number(validator.number)
      self.franchise = validator.brand.to_s
      [credit_card, franchise]
    else
      self.credit_card = 'Error: Invalid Credit card'
      self.franchise = nil
      [credit_card, franchise]
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
