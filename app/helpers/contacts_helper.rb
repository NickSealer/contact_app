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
