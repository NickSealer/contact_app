class Contacts::CreateContact

  def initialize(params, user_id)
    @params = params
    @user_id = user_id
  end

  def process

    exist = Contact.where(email: @params[:email], user_id: @user_id).first
    if exist
      updated, contact_updated = Contacts::UpdateContact.new(exist, @params).process
      return [updated, contact_updated]
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
