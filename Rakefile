require 'rdoc/task'
require 'rubygems'
require 'rubygems/package_task'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task default: :rspec

desc 'Run the specs'
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = ['--color']
  t.pattern = './spec/**/*_spec.rb'
end
