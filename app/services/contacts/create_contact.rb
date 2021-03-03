class Contacts::CreateContact

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def process

    exist = @current_user.contacts.where(email: @params[:email]).last
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

    success = contact.save

    if success
      [success, contact]
    else
      success = false
      [success, false]
    end

  end

end
