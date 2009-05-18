def download(location, destination)
  puts "Downloading #{location} => #{destination}"
  run "wget --directory-prefix=#{destination} #{location}"
end

def haml!
  run 'haml --rails .'
end

def piston(vendor_directory_name, repository_location)
  run "piston import #{repository_location} vendor/plugins/#{vendor_directory_name}"
end

def touch(*args)
  args = args.first if args.first.class == Array
  args.each do |file_location|
    next if File.file?(file_location)
    directory = File.dirname(file_location)
    basename  = File.basename(file_location)
    puts "Touching #{directory}/#{basename}"
    puts "Ran out of time for today TODO: Finish up touch function!"
  end
end
