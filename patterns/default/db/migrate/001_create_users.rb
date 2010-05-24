class CreateUsers < ActiveRecord::Migration
  def self.up
    transaction do

      create_table :users do |table|
        table.timestamps
        table.with_options :null => false do |t|
          table.integer  :lock_version,       :default => 0
          table.string   :email
          table.string   :encrypted_password
          table.string   :persistence_token
          table.boolean  :admin,              :default => false
          table.integer  :login_count,        :default => 0
          table.datetime :current_login_at,                      :null => true
          table.datetime :last_login_at,                         :null => true
          table.string   :current_login_ip,                      :null => true
          table.string   :last_login_ip,                         :null => true
        end
      end

      add_index :users, [ :email ]

    end
  end

  def self.down
    transaction do
      drop_table :users
    end
  end

end
