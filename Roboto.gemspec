# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Roboto}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Curtis Edmond"]
  s.date = %q{2009-03-10}
  s.default_executable = %q{roboto}
  s.description = %q{A simple robots.txt parser and wrapper method for open-uri's open that respects robot.txt files}
  s.email = %q{curtis.edmond@gmail.com}
  s.executables = ["roboto"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "Rakefile", "README.rdoc", "VERSION.yml", "lib/roboto", "lib/roboto/robots_txt.rb", "lib/roboto.rb", "spec/roboto_spec.rb", "spec/robots_txt_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "bin/roboto"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tehcurtis/roboto}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple robots.txt parser and wrapper method for open-uri's open that respects robot.txt files}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
