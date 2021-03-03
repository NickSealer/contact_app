class Contacts::UpdateContact

  def initialize(contact, params)
    @contact = contact
    @params = params
  end

  def process
    @contact.name = @params[:name]
    @contact.birthdate = @params[:birthdate]
    @contact.phone = @params[:phone]
    @contact.address = @params[:address]
    @contact.credit_card = @params[:credit_card]
    @contact.email = @params[:email]

    success = @contact.save
    
    if success
      [success, @contact]
    else
      success = false
      [success, false]
    end

  end

end
