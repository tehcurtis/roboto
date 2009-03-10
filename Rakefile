%w[rubygems rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/roboto'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "Roboto"
    s.executables = "roboto"
    s.summary = "A simple robots.txt parser and wrapper method for open-uri's open that respects robot.txt files"
    s.email = "curtis.edmond@gmail.com"
    s.homepage = "http://github.com/tehcurtis/roboto"
    s.description = "A simple robots.txt parser and wrapper method for open-uri's open that respects robot.txt files"
    s.authors = ["Curtis Edmond"]
    s.files =  FileList["[A-Z]*", "{lib,spec}/**/*", ]
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end


# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('roboto', Roboto::VERSION::String) do |p|
  p.developer('FIXME full name', 'FIXME email')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  p.rubyforge_name       = p.name # TODO this is default value
  # p.extra_deps         = [
  #   ['activesupport','>= 2.0.2'],
  # ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"]
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# task :default => [:spec, :features]
