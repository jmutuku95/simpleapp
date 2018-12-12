class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: true
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.datetime :activated_at
      t.boolean :activated, default: false
      t.string :activation_digest
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
