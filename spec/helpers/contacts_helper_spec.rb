require 'rails_helper'

RSpec.describe ContactsHelper, type: :helper do

  context "#formated_date" do
    it "should be a date data type" do
      expect(formated_date(Date.today).to_date).to eq(Date.today)
    end
  end

  context "#retrieve_card" do
    it "last 4 characters are numbers" do
      example_string = "AKJD3$%&DDWNISUDNIUKJ45AS4569"
      characters = retrieve_card(example_string)
      expect(characters[characters.size-4..characters.size-1].to_i.is_a? Numeric).to be_truthy
    end
  end

  context "#spanish_month" do
    it "retrieves months in spanish" do
      expect(spanish_month('January')).to eq("Enero")
      expect(spanish_month('February')).to eq("Febrero")
      expect(spanish_month('March')).to eq("Marzo")
      expect(spanish_month('April')).to eq("Abril")
      expect(spanish_month('May')).to eq("Mayo")
      expect(spanish_month('June')).to eq("Junio")
      expect(spanish_month('July')).to eq("Julio")
      expect(spanish_month('August')).to eq("Agosto")
      expect(spanish_month('September')).to eq("Septiembre")
      expect(spanish_month('October')).to eq("Octubre")
      expect(spanish_month('November')).to eq("Noviembre")
      expect(spanish_month('December')).to eq("Diciembre")
    end
  end

  context "#contacts_error_color" do
    it "has error value" do
      expect(contacts_error_color("Error")).to eq("table-danger")
    end
  end

  describe 'error fields messages' do
    context '#error_name_value' do
      it "has no error in field" do
        expect(error_name_value({})).to eq('')
      end
      it "has error in field" do
        expect(error_name_value({"name": "Error"}.stringify_keys)).to include('Error')
      end
    end

    context '#error_birthdate_value' do
      it "has not error in field" do
        expect(error_birthdate_value({})).to eq('')
      end
      it "has error in field" do
        expect(error_birthdate_value({"birthdate": "Error"}.stringify_keys)).to include('Error')
      end
    end

    context '#error_phone_value' do
      it "has not error in field" do
        expect(error_phone_value({})).to eq('')
      end
      it "has error in field" do
        expect(error_phone_value({"phone": "Error"}.stringify_keys)).to include('Error')
      end
    end

    context '#error_address_value' do
      it "has not error in field" do
        expect(error_address_value({})).to eq('')
      end
      it "has error in field" do
        expect(error_address_value({"address": "Error"}.stringify_keys)).to include('Error')
      end
    end

    context '#error_credit_card_value' do
      it "has not error in field" do
        expect(error_credit_card_value(Contact.new(import_errors: {}, brand: "VISA"))).to_not include('Error')
      end
      it "has error in field" do
        expect(error_credit_card_value(Contact.new(import_errors: {"credit_card": "Error"}.stringify_keys))).to include('Error')
      end
    end

    context '#error_email_value' do
      it "has not error in field" do
        expect(error_email_value({})).to eq('')
      end
      it "has error in field" do
        expect(error_email_value({"email": "Error"}.stringify_keys)).to include('Error')
      end
    end
  end

end
