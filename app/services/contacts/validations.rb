class Contacts::Validations
  require 'bcrypt'

  def initialize(contact)
    @contact = contact
  end

  def process
    @is_valid = false
    @contact.name, valid_name = validate_name(@contact.name)
    @contact.birthdate, valid_birthdate = validate_birthdate(@contact.birthdate)
    @contact.phone, valid_phone = validate_phone(@contact.phone)
    @contact.address, valid_address = validate_address(@contact.address)
    @contact.email, valid_email = validate_email(@contact.email)

    card_fields, valid_card = validate_credit_card(@contact.credit_card)
    @contact.credit_card = card_fields[:credit_card]
    @contact.brand = card_fields[:brand] if valid_card

    @is_valid = true if (valid_name && valid_birthdate && valid_phone && valid_address && valid_email && valid_card)

    [@is_valid, @contact]
  end

  private
    def validate_name(name)
      if !name.blank? && name.match?(/^[a-zA-Z\s-]+$/)
        name = name
      else
        name = "Error: Invalid name"
      end
      field, validation = valid_record?(name)
    end

    def validate_birthdate(birthdate)
      date = valid_date(birthdate.to_s)

      if !birthdate.blank? && (date.match?(/\d{4}-\d{2}-\d{2}/) || date.match?(/\d{4}\/\d{2}\/\d{2}/))
        birthdate = date
      else
        birthdate = "Error: Invalid birthdate"
      end
      field, validation = valid_record?(birthdate)
    end

    def validate_phone(phone)
      if !phone.blank? && phone.match?(/[(][+]\d{1,2}[)][\s]{1,1}\d{3,3}[\s-]\d{3,3}[\s-]\d{2,2}[\s-]\d{2,2}$/)
        phone = phone
      else
        phone = "Error: Invalid phone"
      end
      field, validation = valid_record?(phone)
    end

    def validate_address(address)
      address = address.blank? ? "Error: Invalid address" : address
      field, validation = valid_record?(address)
    end

    def validate_credit_card(credit_card)
      validator = CreditCardValidations::Detector.new(credit_card)
      fields = {}
      if !credit_card.blank? && validator.valid?
        fields[:credit_card] = encrypt_number(validator.number)
        fields[:brand] = validator.brand.to_s
        [fields, true]
      else
        fields[:credit_card] = "Error: Invalid Credit card"
        fields[:brand] = ""
        [fields, false]
      end
    end

    def validate_email(email)
      if !email.blank? && email.match?(/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/)
        email = email
      else
        email = "Error: Invalid email"
      end
      field, validation = valid_record?(email)
    end

    def valid_record?(arg)
      if arg.include?("Error")
        [arg, false]
      else
        [arg, true]
      end
    end

    def valid_date(date)
      Date.parse(date).strftime("%F")
    rescue
      Date.today.next_year.strftime("%F")
    end

  protected
    def encrypt_number(number)
      encriptor = BCrypt::Password.create(number)
      encriptor = encriptor.chars.shuffle.join("")
      encriptor += number[number.size-4..number.size-1]
      encriptor
    end

end
