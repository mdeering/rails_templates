class User < ActiveRecord::Base

  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  attr_accessible :email, :lock_version, :password, :password_confirmation

  normalize_attribute   :email, :password

  validates_inclusion_of :admin, :in => [ false, true ]

  validates_presence_of :email

end