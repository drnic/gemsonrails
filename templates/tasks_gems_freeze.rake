namespace :gems do
  desc "Freeze a RubyGem into this Rails application; init.rb will be loaded on startup."
  task :freeze do
    raise "No gem specified" unless gem_name = ENV['GEM']

    require 'rubygems'
    Gem.manage_gems
    
    gem = (version = ENV['VERSION']) ?
      Gem.cache.search(gem_name, "= #{version}").first :
      Gem.cache.search(gem_name).sort_by { |g| g.version }.last
    
    version ||= gem.version.version rescue nil
    
    unless gem && path = Gem::UnpackCommand.new.get_path(gem_name, version)
      raise "No gem #{gem_name} #{version} is installed.  Do 'gem list #{gem_name}' to see what you have available."
    end
    
    gems_dir = File.join(RAILS_ROOT, 'vendor', 'gems')
    mkdir_p gems_dir, :verbose => false if !File.exists?(gems_dir)
    
    target_dir = ENV['TO'] || File.basename(path).sub(/\.gem$/, '')
    rm_rf "vendor/gems/#{target_dir}", :verbose => false
    
    chdir gems_dir, :verbose => false do
      mkdir_p target_dir, :verbose => false
      (gem = Gem::Installer.new(path)).unpack(target_dir)
      chdir target_dir, :verbose => false do
        # TODO
        #require 'pp'
        #pp gem
        #pp gem.methods.sort
        if !File.exists?('init.rb') #&& gem.autorequire
          File.open('init.rb', 'w') do |file|
            file << <<-eos
#require something
eos
          end
        end
      end
      puts "Unpacked #{gem_name} #{version} to '#{target_dir}'"
    end
  end

end