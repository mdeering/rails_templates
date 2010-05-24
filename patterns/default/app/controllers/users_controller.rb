class UsersController < ApplicationController
  skip_before_filter :login_required, :only => [ :new, :create ]

  private

    def authorized?
      return false unless logged_in?
      return resource == current_user || current_user.admin?
    end
end
