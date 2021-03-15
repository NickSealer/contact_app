class Contacts::UpdateContact
  def initialize(contact, params)
    @contact = contact
    @params = params.merge(import_errors: {})
  end

  def process
    @contact.update(@params)
  end

end
