class Contacts::CreateContact

  def initialize(params, user_id)
    @params = params
    @user_id = user_id
  end

  def process

    exist = Contact.where(email: @params[:email], user_id: @user_id).first
    if exist
      return [false, exist, msg = "Notice: Already exist #{exist.try(:email)}, "] if exist.is_valid

      updated, contact_updated = Contacts::UpdateContact.new(exist, @params).process unless exist.is_valid
      success_msg = "| Notice: Contact updated #{contact_updated.try(:email)}, "
      error_msg = "| Error: Invalid fields in #{contact_updated.try(:email) ? contact_updated.try(:email) : contact_updated.id}"
      return [updated, contact_updated, msg = updated ? success_msg : error_msg]
    end

    contact = Contact.new()
    contact.name = @params[:name]
    contact.birthdate = @params[:birthdate]
    contact.phone = @params[:phone]
    contact.address = @params[:address]
    contact.credit_card = @params[:credit_card]
    contact.email = @params[:email]
    contact.user_id = @params[:user_id]

    validated, contact = Contacts::Validations.new(contact).process

    contact.is_valid = validated

    success = contact.save

    if success
      [success, contact]
    else
      success = false
      [success, false]
    end

  end

end
