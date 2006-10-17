namespace :gems do
  desc "Unfreeze/unlink a RubyGem from this Rails application"
  task :unfreeze do
    raise "No gem specified" unless gem_name = ENV['GEM']
    Dir["vendor/gems/#{gem_name}*"].each { |d| rm_rf d }
  end
end