class Documents::CreateDocument

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def process
    document = Document.new()
    document.name = File.basename(@params[:csv_file].original_filename, ".*")
    document.status = "Waiting"
    document.user = @current_user
    document.file.attach(io: @params[:csv_file],
                         filename: File.basename(@params[:csv_file].original_filename, ".*"),
                         content_type: @params[:csv_file].content_type)

    success = document.save

    if success
      [success, document]
    else
      success = false
      [success, false]
    end
  end

end
