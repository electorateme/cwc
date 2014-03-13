# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cwc/version'

Gem::Specification.new do |spec|
  spec.name          = "cwc"
  spec.version       = Cwc::VERSION
  spec.authors       = ["Hans Gamarra"]
  spec.email         = ["hans@appmeup.co"]
  spec.summary       = "Gem for connecting with CWC API"
  spec.description   = "Gem for connecting with CWC API"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
