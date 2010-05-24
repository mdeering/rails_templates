class UserSessionsController < ApplicationController

  skip_before_filter :login_required, :only => [ :create, :new ]

  def create
    create!{ home_url }
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy if @user_session.present?
    flash[:notice] = t 'flash.user_sessions.destroy.notice'
    redirect_to root_url
  end

  private

    def authorized?
      resource == current_user || current_user.admin?
    end

end
