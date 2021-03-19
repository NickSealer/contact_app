# frozen_string_literal: true

# Helpers for contacts
module ContactsHelper
  def formated_date(date)
    date.strftime("%Y #{spanish_month(date.strftime('%B'))} %d")
  end

  def retrieve_card(number)
    "●●●●●●●●#{number[number.size - 4..number.size - 1]}"
  end

  def contacts_error_color(contact, field)
    contact.import_errors[field].present? ? 'table-danger' : ''
  end

  def error_value(contact, field)
    contact.import_errors[field].present? ? contact.import_errors[field] : ''
  end

  def error_credit_card_value(contact)
    contact.import_errors['credit_card'].present? ? contact.import_errors['credit_card'] : contact.brand
  end

  private

  def spanish_month(month)
    months = {
      'January': 'Enero', 'February': 'Febrero', 'March': 'Marzo',
      'April': 'Abril', 'May': 'Mayo', 'June': 'Junio',
      'July': 'Julio', 'August': 'Agosto', 'September': 'Septiembre',
      'October': 'Octubre', 'November': 'Noviembre', 'December': 'Diciembre'
    }
    months[month.to_sym]
  end
end
