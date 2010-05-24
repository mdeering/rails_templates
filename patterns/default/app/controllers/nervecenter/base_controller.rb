class Nervecenter::BaseController < ApplicationController

  prepend_view_path('app/views/nervecenter')

  def create
    create! do |success, failure|
      failure.html { render :template => 'new' }
    end
  end

  def update
    update! do |success, failure|
      failure.html { render :template => 'edit' }
    end
  end

  [ 'edit', 'index', 'new', 'show' ].each do |action|
    define_method action do
      super do |format|
        format.html { render :template => action }
      end
    end
  end

  private

    def authorized?
      return false unless logged_in?
      current_user.admin?
    end

end
