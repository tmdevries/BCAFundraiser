class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.boolean :name_visible
      t.boolean :notify_by_text
      t.boolean :notify_by_email
      t.boolean :admin
      t.string :auth_token
      t.string :remember_digest
    end
  end
end
