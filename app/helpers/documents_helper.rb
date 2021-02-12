module DocumentsHelper

  def status_color(value)
    case value
    when "Success"
      "table-success"
    when "Failed"
      "table-danger"
    when "Waiting"
      "table-secondary"
    when "Processing"
      "table-primary"
    end
  end

end
