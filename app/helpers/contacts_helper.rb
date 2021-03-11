module ContactsHelper

  def formated_date(date)
    date.strftime("%Y #{spanish_month(date.strftime("%B"))} %d")
  end

  def retrieve_card(number)
    "●●●●●●●●#{number[number.size-4..number.size-1]}"
  end

  def contacts_error_color(truly)
    truly ? "table-danger" : ''
  end

  def error_name_value(import_errors)
    import_errors['name'].present? ? import_errors['name'] : ''
  end

  def error_birthdate_value(import_errors)
    import_errors['birthdate'].present? ? import_errors['birthdate'] : ''
  end

  def error_phone_value(import_errors)
    import_errors['phone'].present? ? import_errors['phone'] : ''
  end

  def error_address_value(import_errors)
    import_errors['address'].present? ? import_errors['address'] : ''
  end

  def error_credit_card_value(contact)
    contact.import_errors['credit_card'].present? ? contact.import_errors['credit_card'] : contact.brand
  end

  def error_email_value(import_errors)
    import_errors['email'].present? ? import_errors['email'] : ''
  end

  private
    def spanish_month(month)
      case month
      when "January"
        "Enero"
      when "February"
        "Febrero"
      when "March"
        "Marzo"
      when "April"
        "Abril"
      when "May"
        "Mayo"
      when "June"
        "Junio"
      when "July"
        "Julio"
      when "August"
        "Agosto"
      when "September"
        "Septiembre"
      when "October"
        "Octubre"
      when "November"
        "Noviembre"
      when "December"
        "Diciembre"
      end
    end

end
