class ContactsController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  before_action :set_contact, only: %i[ show edit update destroy ]

  rescue_from ActiveRecord::RecordNotFound do |e|
    redirect_to root_url, alert: "Record not found."
  end

  def index
    if params[:status].present? && !params[:status].blank?
      @contacts = current_user.contacts.where(is_valid: params[:status]).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @contacts = current_user.contacts.valid.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      redirect_to root_url, notice: "Created OK"
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: "Updated OK"
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to root_url, notice: "Deleted OK"
  end

  def import_csv
    csv_file = params[:csv_file]

    if csv_file.present? && File.extname(csv_file.original_filename) == '.csv'
      Documents::CreateDocument.new(params, current_user).process
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
    def contact_params
      params.require(:contact).permit(:name, :birthdate, :phone, :address, :email, :credit_card)
    end

    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

end
