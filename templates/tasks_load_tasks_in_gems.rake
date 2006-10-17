# This file does not include any Rake files, but loads up the 
# tasks in the /vendor/gems/ folders

Dir[File.join(RAILS_ROOT, "vendor/gems/*/**/tasks/**/*.rake")].sort.each { |ext| load ext }