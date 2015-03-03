# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'everyday/version'

Gem::Specification.new do |spec|
  spec.name          = "everyday"
  spec.version       = Everyday::VERSION
  spec.authors       = ["Jan Owiesniak"]
  spec.email         = ["jan@featurefabrik.de"]
  spec.summary       = %q{Everyday is a example based repository for solutions to common oss problems ruby developers have to struggle with almost everyday}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "minitest", "~> 5.5"
end
