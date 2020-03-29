# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'credova/version'

Gem::Specification.new do |spec|
  spec.name          = "credova"
  spec.version       = Credova::VERSION
  spec.authors       = ["Jeffrey Dill"]
  spec.email         = ["jeffdill2@gmail.com"]
  spec.summary       = %q{Credova API Ruby library.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/ammoready/credova"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "simplecov", "~> 0.9"
  spec.add_development_dependency "webmock", "~> 1.20"
  spec.add_development_dependency "yard", "~> 0.9.12"
end
