class SiteController < ApplicationController
  class InvalidPath < StandardError; end
  class UnknownTemplate < StandardError; end

  skip_before_filter :login_required

  rescue_from SiteController::InvalidPath, SiteController::UnknownTemplate, :with => :not_found

  def show
    # make sure filenames are any combination of letters, separated by zero or more hypens
    unless (segments = params[:path].grep(/\A[a-z](?:-?[a-z]+)*\z/)) == params[:path]
      raise InvalidPath, "Path contains invalid characters #{params[:path] * '/'}"
    end

    path = Pathname.new("#{RAILS_ROOT}/app/views/site")
    segments.each { |s| path += s }

    if template = template_path(path)
      render :file => template.to_s, :layout => true
    else
      raise UnknownTemplate, "No template for #{path}"
    end
  end

  private

    def authorized?
      true
    end

    def template_path(path)
      if path.directory? && (index = path + 'index.html.haml').file?
        index
      else (file = path.dirname + (path.basename.to_s + '.html.haml')).file?
        file
      end
    end

end
