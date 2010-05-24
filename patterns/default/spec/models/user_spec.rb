require 'spec_helper'

describe User do
  fast_context "validations" do
    setup do
      @user = Factory(:user)
    end

    [ :email, :password, :password_confirmation ].each do |attribute|
      it { should allow_mass_assignment_of attribute }
    end

    [ :admin, :current_login_at, :current_login_ip, :encrypted_password,
      :last_login_at, :last_login_ip, :login_count, :persistence_token
    ].each do |attribute|
      it { should_not allow_mass_assignment_of attribute }
    end

    it { should normalize_attribute  :email }

    it { should validate_presence_of :email }
  end
end