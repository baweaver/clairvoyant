# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clairvoyant/version'

Gem::Specification.new do |spec|
  spec.name          = "clairvoyant"
  spec.version       = Clairvoyant::VERSION
  spec.authors       = ["Brandon Weaver"]
  spec.email         = ["keystonelemur@gmail.com"]
  spec.summary       = %q{Predict code to be written from RSPEC}
  spec.description   = %q{Attempts to divine what code will make tests pass}
  spec.homepage      = "https://www.github.com/baweaver/clairvoyant"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
