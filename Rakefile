require 'vendor/gems/environment'
require 'rake'

# begin
#   require 'jeweler'
#   Jeweler::Tasks.new do |gem|
#     gem.name = "aeon"
#     gem.summary = %Q{TODO: one-line summary of your gem}
#     gem.description = %Q{TODO: longer description of your gem}
#     gem.email = "brent.dillingham@gmail.com"
#     gem.homepage = "http://github.com/brentd/aeon"
#     gem.authors = ["Brent Dillingham"]
#     gem.add_development_dependency "rspec"
#     # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
#   end
#   Jeweler::GemcutterTasks.new
# rescue LoadError
#   puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
# end

# require 'cucumber/rake/task'
 
# Cucumber::Rake::Task.new do |t|
#   t.cucumber_opts = %w{--format pretty}
# end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :spec