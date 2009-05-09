module TemplateHelpers

  def haml!
    run 'haml --rails .'
  end

  # Piston  is smart enough that we do not need an options hash to specify :git or :svn
  def piston(plugin_name, repository_location)
    puts "Installing #{plugin_name} using piston"
    run "piston import #{repository_location} vendor/plugins/#{plugin_name}"
  end
end