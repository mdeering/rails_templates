module TemplateHelpers

  def haml!
    run 'haml --rails .'
  end

  def piston(vendor_directory_name, repository_location)
    run "piston import #{repository_location} vendor/plugins/#{vendor_directory_name}"
  end
end