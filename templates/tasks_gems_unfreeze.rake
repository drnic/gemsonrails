namespace :gems do
  desc "Unfreeze/unlink a RubyGem from this Rails application"
  task :unfreeze do
    gem_name = ENV['GEM']
		unless gem_name
		  puts <<-eos
Parameters:
  GEM      Name of gem (required)

  
eos
      break
		end
    Dir["vendor/gems/#{gem_name}*"].each { |d| rm_rf d }
  end
end