# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mtracker/version'

Gem::Specification.new do |spec|
  spec.name          = "mtracker"
  spec.version       = Mtracker::VERSION
  spec.authors       = ["Yusuke Murata"]
  spec.email         = ["info@muratayusuke.com"]
  spec.summary       = %q{Simple time tracker better than benchmark.}
  spec.description   = %q{Simple time tracker better than benchmark.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
