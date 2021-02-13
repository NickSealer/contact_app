class ContactsController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  before_action :set_contact, only: %i[ show ]

  def index
    if params[:status].present? && !params[:status].blank?
      @contacts = Contact.includes(:user).where(user_id: current_user.id, is_valid: params[:status]).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @contacts = Contact.includes(:user).where(user_id: current_user.id, is_valid: true).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  def import_csv
    csv_file = params[:csv_file]

    if csv_file.present? && File.extname(csv_file.original_filename) == '.csv'
      document_created, document = Documents::CreateDocument.new(params, current_user).process
      # contacts_loaded, errors, msg = Contacts::CreateContactFromCSV.new(csv_file, current_user.id).process

      LoadFileJob.perform_later(document, current_user)
      redirect_to documents_url, notice: "Notice: file loaded successfully."
    else
      redirect_to root_url, alert: "An error has ocurred. Please verify if is a CSV file."
    end
  end

  def download_csv
    layout = CSV.generate do |csv|
                csv << ["name", "birthdate", "phone", "address", "credit_card", "email"]
              end
    respond_to do |format|
      format.csv { send_data layout, filename: "upload-contacts-#{Date.today}.csv" }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

end
