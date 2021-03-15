module ContactsHelper

  def formated_date(date)
    date.strftime("%Y #{spanish_month(date.strftime("%B"))} %d")
  end

  def retrieve_card(number)
    "●●●●●●●●#{number[number.size-4..number.size-1]}"
  end

  def contacts_error_color(contact, field)
    contact.import_errors[field].present? ? "table-danger" : ''
  end

  def error_value(contact, field)
    contact.import_errors[field].present? ? contact.import_errors[field] : ''
  end

  def error_credit_card_value(contact)
    contact.import_errors['credit_card'].present? ? contact.import_errors['credit_card'] : contact.brand
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
