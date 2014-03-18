# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cwc/version'

Gem::Specification.new do |spec|
  spec.name          = "cwc"
  spec.version       = Cwc::VERSION
  spec.authors       = ["AppMeUp", "Hans Gamarra"]
  spec.email         = ["jose@appmeup.co", "hans@appmeup.co"]
  spec.summary       = %q{Gem for connecting with CWC API}
  spec.description   = %q{Gem for connecting with CWC API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  
  spec.add_runtime_dependency "commander", "~> 4.1.6"
  spec.add_runtime_dependency "nokogiri", "~> 1.6.1"
end
