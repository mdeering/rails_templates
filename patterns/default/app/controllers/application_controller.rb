class ApplicationController < ActionController::Base
  include AuthenticationSystem
  inherit_resources
  filter_parameter_logging :password
  protect_from_forgery

  private

    def home_url
      return root_url unless logged_in?
      current_user.admin? ? nervecenter_root_url : user_url(current_user)
    end

end
