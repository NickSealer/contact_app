require 'rails_helper'

RSpec.describe Contact, type: :model do

  before do
    @valid_contact_params = {
      name: 'Valid-name',
      birthdate: '1990-01-01',
      phone: '(+57) 123 123-12-12',
      address: 'Address',
      email: 'email@email.com',
      credit_card: '4111111111111111'
    }

    @invalid_contact_params = {
      name: nil,
      birthdate: nil,
      phone: nil,
      address: nil,
      email: nil,
      credit_card: nil
    }

    @valid_contact = Contact.new(@valid_contact_params)
    @invalid_contact = Contact.new(@invalid_contact_params)
  end

  it 'is invalid' do
    @invalid_contact.valid_contact?
    expect(@invalid_contact.is_valid).to be(false)
  end

  it 'is valid' do
    @valid_contact.valid_contact?
    expect(@valid_contact.is_valid).to be(true)
  end

  context 'validation' do
    it 'has invalid name with wrong format' do
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

  end

  context "search contacts by 'valid' scope" do
    before do
      @user = User.create_with(password: '123456789').find_or_create_by(email: 'email@email.com')
      @contact_1 = @user.contacts.create(@valid_contact_params)
      @contact_2 = @user.contacts.create(@invalid_contact_params)
    end

    it 'return contacts that are valids' do
      expect(@user.contacts.valid).to include(@contact_1)
    end

    it "return contacts that aren't valids" do
      expect(@user.contacts.valid).not_to include(@contact_2)
    end
  end

  context "generate contact factory" do
    it "valid factory" do
      contact = FactoryBot.create(:contact, :birthdate_100_year_ago)
      puts "Factory: #{contact.inspect}"
      puts "Association: #{contact.user.inspect}"
      expect(contact.user).to be_truthy
    end
  end

end
