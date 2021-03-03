require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'validation' do
    it 'has invalid name wiht wrong format' do
      contact = Contact.new(name: 'invalid_name')
      expect(contact.validate_name).to include('Error')
    end

    it 'has invalid birthdate with wrong format' do
      contact = Contact.new(birthdate: 'invalid date')
      expect(contact.validate_birthdate).to be_nil
    end

    it 'has invalid phone with wrong format' do
      contact = Contact.new(phone: 'invalid phone')
      expect(contact.validate_phone).to include('Error')
    end

    it 'has invalid address with empty data ' do
      contact = Contact.new(address: nil)
      expect(contact.validate_address).to include('Error')
    end

    it 'has invalid email with wrong format' do
      contact = Contact.new(email: 'invalid email @')
      expect(contact.validate_email).to include('Error')
    end

    it 'has invalid credit card' do
      contact = Contact.new(credit_card: '411111111111111')
      expect(contact.validate_credit_card).to contain_exactly('Error: Invalid Credit card', nil)
    end

    it 'is invalid contact' do
      contact = Contact.new(
        name: nil,
        birthdate: nil,
        phone: nil,
        address: nil,
        email: nil,
        credit_card: nil
      )
      contact.valid_contact?
      expect(contact.is_valid).to be(false)
    end

    it "is valid contact" do
      contact = Contact.new(
        name: "Valid-name",
        birthdate: "1990-01-01",
        phone: "(+57) 123 123-12-12",
        address: "Address",
        email: "email@email.com",
        credit_card: "4111111111111111"
      )
      contact.valid_contact?
      expect(contact.is_valid).to be(true)
    end
  end
end
