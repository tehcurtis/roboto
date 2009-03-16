# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Roboto}
  s.version = "0.0.5"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Curtis Edmond"]
  s.date = %q{2009-03-13}
  s.description = %q{A simple robots.txt parser and wrapper method for open-uri's open that respects robot.txt files}
  s.email = %q{curtis.edmond@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "Rakefile", "README.rdoc", "Roboto.gemspec", "VERSION.yml", "lib/roboto", "lib/roboto/robots_txt.rb", "lib/roboto.rb"]
  s.test_files = ["spec/roboto_spec.rb", "spec/robots_txt_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tehcurtis/roboto}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.summary = %q{A simple robots.txt parser and wrapper method for open-uri's open that respects robot.txt files}
end
