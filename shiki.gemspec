# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shiki/version'

Gem::Specification.new do |spec|
  spec.name          = "shiki"
  spec.version       = Shiki::VERSION
  spec.authors       = ["n-kats"]
  spec.email         = ["n-kats19890214@hotmail.co.jp"]
  spec.summary       = %q{tex and mathjax framework}
  spec.description   = %q{tex and mathjax framework}
  spec.homepage      = "https://github.com/n-kats/shiki"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.1.4"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'thir'
end
