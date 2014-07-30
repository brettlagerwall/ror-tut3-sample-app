class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.uo
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
