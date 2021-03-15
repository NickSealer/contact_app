class Api::V1::ContactsController < ApplicationController
  prepend_before_action :authenticate_user_from_token!
  before_action :set_contact, only: %i[show update destroy]

  def index
    @contacts = current_user.contacts.order(created_at: :desc)
    render json: @contacts, status: :ok
  end

  def show
    render json: @contact, status: :ok
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      render json: { success: true, contact: @contact }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: { success: true, contact: @contact }, status: :ok
    else
      render json: { success: false, contact: @contact }, status: :unprocessable_entity
    end
  end

  def destroy
    if @contact.destroy
      render json: { success: true, contact: @contact }, status: :ok
    else
      render json: { success: false, contact: @contact }, status: :internal_error
    end
  end

  private

    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    def authenticate_user_from_token!
      user_email = params[:user_email].presence
      user = user_email && User.find_by(email: user_email)
      if user && Devise.secure_compare(user.authenticatable_salt, params[:user_token])
        sign_in user, store: true
      else
        render json: { error: 'Authentication failed' }, status: :unauthorized
        false
      end
    end

    def contact_params
      params.require(:contact).permit(:name, :birthdate, :phone, :address, :email, :credit_card)
    end
end
