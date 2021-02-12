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

    validated, contact_updated = Contacts::Validations.new(@contact).process
    contact_updated.is_valid = validated
    contact_updated.save

    [validated, contact_updated]
  end

end
