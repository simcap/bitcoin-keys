# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitcoin/keys/version'

Gem::Specification.new do |spec|
  spec.name          = "bitcoin-keys"
  spec.version       = Bitcoin::Keys::VERSION
  spec.authors       = ["simcap"]
  spec.email         = ["simcap@fastmail.com"]
  spec.summary       = %q{Generate and manage Bitcoin keys}
  spec.description   = %q{Generate and manage Bitcoin keys}
  spec.homepage      = "https://github.com/simcap/bitcoin-keys"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
