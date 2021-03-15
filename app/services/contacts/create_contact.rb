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

    contact = @current_user.contacts.build(@params)

    return false unless contact.save

    contact
  end
end
