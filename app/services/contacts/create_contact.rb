class Contacts::CreateContact

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def process

    contact_found = @current_user.contacts.where(email: @params[:email]).last
    if contact_found
      Contacts::UpdateContact.new(contact_found, @params).process
      return contact_found
    end

    contact = Contact.new()
    contact.name = @params[:name]
    contact.birthdate = @params[:birthdate]
    contact.phone = @params[:phone]
    contact.address = @params[:address]
    contact.credit_card = @params[:credit_card]
    contact.email = @params[:email]
    contact.user = @current_user

    return false unless contact.save
    contact

  end

end
