module Rails
  class TemplateRunner

    DEBUG_LOGGING = true

    attr_accessor :template_paths

    def add_template_path(path, placement = :prepend)
      if placement == :prepend
        @template_paths.unshift path
      elsif placement == :append
        @template_paths.push path
      end
    end

    def commit_state(comment)
      git :add => "."
      git :commit => "-am '#{comment}'"
    end

    def current_app_name
      current_app_name = File.basename(File.expand_path(root))
    end

    def debug_log(msg)
      if DEBUG_LOGGING
        log msg
      end
    end

    def delete(file)
      debug_log "Removing file: #{file}"
      run "rm #{file}"
    end

    def download(from, to = from.split("/").last)
      #run "curl -s -L #{from} > #{to}"
      file to, open(from).read
    rescue
      puts "Can't get #{from} - Internet down?"
      exit!
    end

    def init_template_framework(template, root)
      @template_paths = [File.expand_path(File.dirname(template), File.join(root,'..'))]
      @template_paths << File.join(File.expand_path(File.dirname(template), File.join(root,'..')), '../..')
      @template_identifier = 'default'
    end

    def load_from_file_in_template(file_name, parent_binding = nil, file_group = 'default', file_type = :pattern)
      base_name = file_name.gsub(/^\./, '')
      begin
        if file_type == :config
          contents = {}
        else
          contents = ''
        end
        paths = template_paths

        paths.each do |template_path|
          full_file_name = File.join(template_path, file_type.to_s.pluralize, file_group, base_name)
          debug_log "Searching for #{full_file_name} ... "

          next unless File.exists? full_file_name
          debug_log "Found!"

          if file_type == :config
            contents = open(full_file_name) { |f| YAML.load(f) }
          else
            contents = open(full_file_name) { |f| f.read }
          end
          if contents && parent_binding
            contents = eval("\"" + contents.gsub('"','\\"') + "\"", parent_binding)
          end
          # file loaded, stop searching
          break if contents

        end
        contents
      rescue => ex
        debug_log "Error in load_from_file_in_template #{file_name}"
        debug_log ex.message
      end
    end

    # Load a pattern from a file, potentially with string interpolation
    def load_pattern(pattern_name, pattern_group = "default", parent_binding = nil)
      load_from_file_in_template(pattern_name, parent_binding, pattern_group, :pattern)
    end

  end
end