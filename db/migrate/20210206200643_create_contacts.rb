class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :birthdate
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :brand
      t.string :email
      t.jsonb :import_errors, default: {}
      t.boolean :is_valid, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
