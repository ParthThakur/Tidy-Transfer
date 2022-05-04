# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      # t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
          
    ## Remove password digest
    remove_column :users, :password_digest
  end

  def self.down
    ## Remove devise generated columns
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :email  # So the email isn't the index anymore.

    ## Add old columns back
    add_column :users, :email, :string
    add_column :users, :password_digest, :string

    puts "-- Don't forget to add 'has_secure_password' to models/users.rb --"
  end
end
